require 'singleton'

import 'org.vicomtech.opennlp.LanguageDetection.CybozuDetector'

module Opener
  class LanguageIdentifier
    class Detector
      include Singleton

      def initialize
        @detector = CybozuDetector.new(profiles_path)
        @semaphore = Mutex.new
      end

      def detect(input)
        @semaphore.synchronize do
          @detector.detect(input)
        end
      end

      def profiles_path
        File.expand_path("../../../../core/target/classes/profiles", __FILE__)
      end

    end
  end
end

