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
      def initialize backend = nil, fallback = nil
        klass     = Backend.const_get backend.to_sym if backend
        klass   ||= LanguageDetection
        @backend  = klass.new

        klass     = Backend.const_get fallback.to_sym if fallback
        @fallback = klass.new if klass

        @timeout = ENV['TIMEOUT']&.to_i
      end

      ##
      # @return [String]
      #
      def detect(input)
        backend_detect @backend, input
      rescue
        raise unless @fallback
        puts 'Using fallback backend' if ENV['DEBUG']
        backend_detect @fallback, input
      end

      def backend_detect backend, input
        return backend.detect input unless @timeout
        Timeout.timeout @timeout do
          backend.detect input
        end
      end

    end
  end
end
