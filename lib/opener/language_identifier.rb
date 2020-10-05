require 'open3'
require 'slop'
require 'builder'
require 'pp'

require 'detect_language'

require_relative 'language_identifier/version'
require_relative 'language_identifier/kaf_builder'
require_relative 'language_identifier/cli'
require_relative 'language_identifier/detector'
require_relative 'language_identifier/backend/detect_language_com'
if RUBY_ENGINE == 'jruby'
  require_relative 'language_identifier/backend/language_detection'
  require_relative 'language_identifier/backend/opennlp'
end

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
      args:  [],
      kaf:   true,
    }.freeze

    ##
    # @param [Hash] options
    #
    # @option options [Array] :args Arbitrary arguments to pass to the
    #  underlying kernel.
    #
    # @option options [TrueClass|FalseClass] :kaf When set to `true` the
    #  results will be displayed as KAF.
    #
    def initialize(options = {})
      @options  = DEFAULT_OPTIONS.merge(options)
      @detector = Detector.new ENV['BACKEND'], ENV['FALLBACK']
    end

    ##
    # Processes the input and returns an Array containing the output of STDOUT,
    # STDERR and an object containing process information.
    #
    # @param [String] input The text of which to detect the language.
    # @return [Array]
    #
    def run input, params = {}
      output = @detector.detect input
      output = build_kaf input, output if options[:kaf]

      return output
    end

    alias identify run

    protected

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
  end # LanguageIdentifier
end # Opener
