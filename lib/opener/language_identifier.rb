require 'open3'
require 'optparse'
require 'builder'
require 'java'
require 'opener/core'

require_relative '../../core/target/LanguageDetection-0.0.1.jar'
import 'org.vicomtech.opennlp.LanguageDetection.CybozuDetector'

require_relative 'language_identifier/version'
require_relative 'language_identifier/kaf_builder'
require_relative 'language_identifier/cli'
require_relative 'language_identifier/detector.rb'

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
      :args      => [],
      :kaf       => true,
      :benchmark => false
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
    # @option options [TrueClass|FalseClass] :benchmark When set to `true`
    #  benchmarking output will be added to the KAF document.
    #
    def initialize(options = {})
      @options = DEFAULT_OPTIONS.merge(options)
      @detector = Detector.instance
    end

    ##
    # Processes the input and returns an Array containing the output of STDOUT,
    # STDERR and an object containing process information.
    #
    # @param [String] input The text of which to detect the language.
    # @return [Array]
    #
    def run(input)
      output    = nil
      benchmark = Opener::Core::Benchmark.new('opener-language-identifier')

      results = benchmark.measure do
        if options[:probs]
          output = @detector.probabilities(input)
        else
          output = @detector.detect(input)
          output = build_kaf(input, output) if options[:kaf]
        end
      end

      if options[:kaf] and options[:benchmark]
        output = benchmark.write(output, results)
      end

      return output

    rescue Exception => error
      return Opener::Core::ErrorLayer.new(input, error.message, self.class).add
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
