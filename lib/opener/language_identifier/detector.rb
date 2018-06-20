module Opener
  class LanguageIdentifier
    ##
    # Ruby wrapper around the Cybozu DetectorFactory and Detector classes. This
    # class automatically handles switching of profiles based on input sizes,
    # assigning priorities to languages, etc.
    #
    class Detector

      attr_reader :backend

      ##
      # @param [Hash] options
      #
      #
      def initialize backend = nil
        klass    = Backend.const_get backend.to_s.camelize.to_sym if backend
        klass  ||= LanguageDetection
        @backend = klass.new
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
