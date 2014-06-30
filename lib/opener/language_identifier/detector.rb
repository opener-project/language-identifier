require 'singleton'

import 'org.vicomtech.opennlp.LanguageDetection.CybozuDetector'

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

      def initialize(options={})
        @options = options
        @detector = CybozuDetector.new(profiles_path)
        @semaphore = Mutex.new
      end

      def detect(input)
        @semaphore.synchronize do
          @detector.detect(input)
        end
      end

      def probabilities(input)
        @semaphore.synchronize do
          result = @detector.detect_langs(input)
        end
      end

      def profiles_path
        default_path = File.expand_path("../../../../core/target/classes/profiles", __FILE__)
        options.fetch(:profiles_path, default_path)
      end
    end
  end
end
