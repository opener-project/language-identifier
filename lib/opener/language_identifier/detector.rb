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
      def initialize(options = {})
        options.each do |key, value|
          instance_variable_set("@#{key}", value) if respond_to?(key)
        end

        @backend = Backend::LanguageDetection.new
      end

      ##
      # @return [String]
      #
      def detect(input)
        @backend.detect input
      end

      ##
      # @return [Array]
      #
      def probabilities(input)
        @backend.new_detector(input).get_probabilities.to_array
      end

    end # Detector
  end # LanguageIdentifier
end # Opener
