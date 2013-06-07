require_relative 'language_identifier/version'
require_relative 'language_identifier/kaf_builder'
require_relative 'language_identifier/option_parser'
require 'open3'

module Opener
  class LanguageIdentifier
    attr_reader :kernel, :lib

    def command(opts={})
      "perl -I #{lib} #{kernel} #{opts.join(' ')}"
    end

    def run(opts=ARGV)
      options = OptionParser.parse(opts.dup)
      if !options[:KAF]
        return `#{command(opts)}`
      else
        return kaf_output(opts)
      end
    end

    protected

    def kaf_output(opts)
      text = STDIN.read
      output, error, process = Open3.capture3(command(opts), :stdin_data=>text)
      STDOUT.puts KafBuilder.new(text, output).build
      STDERR.puts e if !error.empty?
    end

    def core_dir
      File.expand_path("../../../core", __FILE__)
    end

    def kernel
      File.join(core_dir,'language_detector.pl')
    end

    def lib
      File.join(core_dir,'lib/') # Trailing / is required
    end

  end
end
