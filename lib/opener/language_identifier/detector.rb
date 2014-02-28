require 'singleton'

import 'org.vicomtech.opennlp.LanguageDetection.CybozuDetector'

module Opener
  class LanguageIdentifier
    class Detector
      include Singleton

      def initialize
        @detector = CybozuDetector.new("core/target/classes/profiles")
        @semaphore = Mutex.new
      end

      def detect(input)
        @semaphore.synchronize do
          @detector.detect(input)
        end
      end

    end
  end
end

