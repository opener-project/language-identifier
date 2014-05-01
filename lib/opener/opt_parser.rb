require 'ostruct'
require 'optparse'
module Opener
  class OptParser

    def self.parse!(args)
      options = {}
      options[:pid] = "/var/run"

      OptionParser.new do |opts|
        opts.banner = "Usage: language-identifier.rb <start|stop|restart> [options]"
        opts.separator ""
        opts.separator "Specific options:"

        opts.on("-i", "--input INPUT_QUEUE_NAME", "Input queue name") do |v|
          options[:input_queue] = v
        end

        opts.on("-o", "--output OUTPUT_QUEUE_NAME", "Output queue name") do |v|
          options[:output_queue] = v
        end

        opts.on("-b", "--batch-size BATCH_SIZE", "Request x messages at once") do |v|
          options[:batch_size] = v
        end

        opts.on("-t", "--threads THREADS", "number of threads") do |v|
          options[:threads] = v
        end

        opts.separator ""
        opts.separator "Common options:"

        # No argument, shows at tail.  This will print an options summary.
        # Try it and see!
        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end

        opts.on_tail("-v", "--version", "Show the version") do
          puts Opener::LanguageDetector::Version.join(".")
          exit
        end
      end.parse!

      return options
    end
  end
end
