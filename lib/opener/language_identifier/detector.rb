module Opener
  class LanguageIdentifier
    ##
    # Singleton class wrapped around the Cybozu detector. The Cybozu code uses
    # the factory pattern and stores a bunch of things on class level. As such
    # the Cybozu code is *not* thread-safe.
    #
    class Detector
      attr_reader :options

      include Singleton

      ##
      # Path to the directory containing the default profiles.
      #
      # @return [String]
      #
      DEFAULT_PATH = File.expand_path(
        '../../../../core/target/classes/profiles',
        __FILE__
      )

      def initialize(options = {})
        @options   = options
        @semaphore = Mutex.new

        com.cybozu.labs.langdetect.DetectorFactory.load_profile(profiles_path)
      end

      def detect(input)
        @semaphore.synchronize do
          new_detector(input).detect
        end
      end

      def probabilities(input)
        @semaphore.synchronize do
          new_detector(input).get_probabilities
        end
      end

      ##
      # Returns a new detector with the profiles set based on the input.
      #
      # @param [String] input
      # @return [CybozuDetector]
      #
      def new_detector(input)
        detector = com.cybozu.labs.langdetect.DetectorFactory.create

        detector.append(input)

        return detector
      end

      ##
      # @return [String]
      #
      def profiles_path
        return options[:profiles_path] || DEFAULT_PATH
      end
    end # Detector
  end # LanguageIdentifier
end # Opener
