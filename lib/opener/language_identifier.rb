require_relative 'language_identifier/version'
require_relative 'language_identifier/kaf_builder'
require_relative 'language_identifier/option_parser'
require 'open3'

module Opener
  class LanguageIdentifier
    attr_reader :kernel, :lib, :args
    attr_accessor :options

    def initialize(opts={})
      @args    = opts.delete(:args) || []
      @options = opts
    end

    def command
      "perl -I #{lib} #{kernel} #{args.join(' ')}"
    end

    def identify(text)
      options[:kaf] ? kaf_output(text) : default_output(text)
    end

    alias :run :identify

    def options
      OptionParser.parse(args.dup).merge(@options)
    end

    protected

    def default_output(text)
      Open3.capture3(command, :stdin_data=>text)
    end

    def kaf_output(text)
      output, error, process = default_output(text)
      output = KafBuilder.new(text, output).build
      [output, error, process]
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
