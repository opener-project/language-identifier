require 'rubygems'
require 'aws-sdk-core'
require 'spoon'
require 'thread'

Thread.abort_on_exception = true

module Opener
    class Daemon
      attr_reader :batch_size, :input_queue, :output_queue, :threads
      attr_reader :visibility_timout, :input_buffer, :output_buffer, :consumers, :klass
      attr_reader :logger

      def initialize(klass, options={})
        @input_queue        = OpenerSQS.new(options.fetch(:input_queue))
        @output_queue       = OpenerSQS.new(options.fetch(:output_queue))
        @threads            = options.fetch(:threads, 5).to_i
        @consumers          = []

        @batch_size         = options.fetch(:batch_size, 10).to_i
        @visibility_timeout = options.fetch(:visibilitiy_timeout, 60)

        @input_buffer = Queue.new
        @output_buffer = Queue.new
        @klass = klass

        @logger = Logger.new(STDOUT)
      end

      def buffer_new_messages
        if input_buffer.size > buffer_size
          logger.debug "Maximum input buffer size reached"
          return
        end

        if output_buffer.size > buffer_size
          logger.debug "Maximum output buffer size reached"
          return
        end

        messages = input_queue.receive_messages(batch_size)

        return if messages.nil?
        messages.each do |message|
          logger.debug "received message: #{message[:receipt_handle][0..10]}./\/\/.#{message[:receipt_handle][-10..-1]}."
          input_buffer << message
        end
      end

      def start
        #
        # Load producer
        #
        producer = Thread.new do
          logger.info "Producer ready for action..."
          loop do
            buffer_new_messages
            sleep(1)
          end
        end

        #
        # Load actual workers
        #
        threads.times do |t|
          consumers << Thread.new do
            logger.info "Consumer #{t+1} launching..."
            identifier = klass.new
            loop do
              message = input_buffer.pop

              input = JSON.parse(message[:body])["input"]
              output = identifier.run(input)
              logger.debug "processed message: #{message[:receipt_handle][0..10]}./\/\/.#{message[:receipt_handle][-10..-1]}."

              output_buffer.push({ :output=>output,
                                   :handle=>message[:receipt_handle]})
            end
          end
        end

        #
        # Load pusher to Amazon
        #
        pusher = Thread.new do
          logger.info "Pusher ready for action..."
          loop do
            message = output_buffer.pop

            payload = {:input=>message[:output]}.to_json
            output_queue.send_message(payload)
            input_queue.delete_message(message[:handle])
          end
        end

        consumers.each(&:join)
        producer.join
        pusher.join
      end

      def buffer_size
        2 * batch_size
      end

      class OpenerSQS
        attr_reader :sqs, :name, :url

        def initialize(name)
          @sqs = Aws::SQS.new
          @name = name
          @url = sqs.get_queue_url(:queue_name=>name)[:queue_url]
        end

        def send_message(message)
          sqs.send_message(:queue_url=>url, :message_body=>message)
        end

        def delete_message(handle)
          sqs.delete_message(:queue_url=>url, :receipt_handle=>handle)
        end

        def receive_messages(limit)
          result = sqs.receive_message(:queue_url=>url,
                              :max_number_of_messages=>limit)[:messages]
        end

      end

    end
end
