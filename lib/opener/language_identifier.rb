require 'open3'
require 'optparse'
require 'builder'

require_relative 'language_identifier/version'
require_relative 'language_identifier/kaf_builder'
require_relative 'language_identifier/cli'

module Opener
  ##
  # Language identifier class that can detect various languages such as Dutch,
  # German and Swedish.
  #
  # @!attribute [r] options
  #  @return [Hash]
  #
  class LanguageIdentifier
    attr_reader :options

    ##
    # Hash containing the default options to use.
    #
    # @return [Hash]
    #
    DEFAULT_OPTIONS = {
      :args => [],
      :kaf  => false
    }.freeze

    ##
    # @param [Hash] options
    #
    # @option options [Array] :args Arbitrary arguments to pass to the
    #  underlying kernel.
    # @option options [TrueClass|FalseClass] :extended When set to `true`
    #  extended language detection will be enabled.
    # @option options [TrueClass|FalseClass] :kaf When set to `true` the
    #  results will be displayed as KAF.
    #
    def initialize(options = {})
      @options = DEFAULT_OPTIONS.merge(options)
    end

    ##
    # Returns a String containing the command to use for executing the kernel.
    #
    # @return [String]
    #
    def command
      return "java -jar #{kernel} #{command_arguments.join(' ')}"
    end

    ##
    # Processes the input and returns an Array containing the output of STDOUT,
    # STDERR and an object containing process information.
    #
    # @param [String] input The text of which to detect the language.
    # @return [Array]
    #
    def run(input)
      input = input.strip

      stdout, stderr, process = Open3.capture3(command, :stdin_data => input)

      if options[:kaf]
        stdout = build_kaf(input, stdout)
      end

      return stdout, stderr, process
    end

    alias identify run

    protected

    ##
    # Returns the arguments to pass to the underlying kernel as an Array.
    #
    # @return [Array]
    #
    def command_arguments
      arguments = options[:args].dup

      return arguments
    end

    ##
    # Builds a KAF document containing the input and the correct XML language
    # tag based on the output of the kernel.
    #
    # @param [String] input The input text.
    # @param [String] language The detected language
    # @return [String]
    #
    def build_kaf(input, language)
      builder = KafBuilder.new(input, language)
      builder.build

      return builder.to_s
    end

    ##
    # @return [String]
    #
    def core_dir
      return File.expand_path('../../../core/target', __FILE__)
    end

    ##
    # @return [String]
    #
    def kernel
      return File.join(core_dir, 'LanguageDetection-0.0.1.jar')
    end

    ##
    # @return [String]
    #
    def lib
      return File.join(core_dir, 'lib/') # Trailing / is required
    end
  end # LanguageIdentifier
end # Opener
