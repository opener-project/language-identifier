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

        opts.on("-b", "--batch-size BATCH_SIZE", Integer, "Request x messages at once where x is between 1 and 10") do |v|
          options[:batch_size] = v
        end

        opts.on("-w", "--workers NUMBER", Integer, "number of worker thread") do |v|
          options[:workers] = v
        end

        opts.on("-r", "--readers NUMBER", Integer, "number of readers threads") do |v|
          options[:readers] = v
        end

        opts.on("-p", "--writers NUMBER", Integer, "number of writers / pusher threads") do |v|
          options[:writers] = v
        end

        opts.on("-l", "--logfile FILENAME", "Filename and path of logfile") do |v|
          options[:pushers] = v
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
