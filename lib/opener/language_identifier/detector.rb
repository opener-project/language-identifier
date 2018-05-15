module Opener
  class LanguageIdentifier
    ##
    # Ruby wrapper around the Cybozu DetectorFactory and Detector classes. This
    # class automatically handles switching of profiles based on input sizes,
    # assigning priorities to languages, etc.
    #
    class Detector
      ##
      # @param [Hash] options
      #
      #
      def initialize
        #@backend = Backend::LanguageDetection.new
        @backend = Backend::Opennlp.new
      end

      ##
      # @return [String]
      #
      def detect(input)
        @backend.detect input
      end

    end
  end
end
