module Opener
  class LanguageIdentifier
    module Backend
      class LanguageDetection

        ##
        # Path to the directory containing the default profiles.
        #
        # @return [String]
        #
        DEFAULT_PROFILES_PATH = File.expand_path(
          '../../../../../core/target/classes/profiles',
          __FILE__
        )

        ##
        # Path to the directory containing the default short profiles.
        #
        # @return [String]
        #
        DEFAULT_SHORT_PROFILES_PATH = File.expand_path(
          '../../../../../core/target/classes/short_profiles',
          __FILE__
        )

        ##
        # Prioritize OpeNER languages over the rest. Languages not covered by this
        # list are automatically given a default priority.
        #
        # @return [Hash]
        #
        PRIORITIES = {
          'en' => 1.0,
          'es' => 0.9,
          'it' => 0.9,
          'fr' => 0.9,
          'de' => 0.9,
          'nl' => 0.9,

          # These languages are disabled (for the time being) due to conflicting
          # with other (OpeNER) languages too often.
          'af' => 0.0, # conflicts with Dutch
        }

        ##
        # The default priority for non OpeNER languages.
        #
        # @return [Float]
        #
        DEFAULT_PRIORITY = 0.5

        ##
        # The amount of characters after which the detector should switch to using
        # the longer profiles set.
        #
        # @return [Fixnum]
        #
        SHORT_THRESHOLD = 15

        def initialize
          @factory = com.cybozu.labs.langdetect.DetectorFactory.new
        end

        def new_detector input
          @factory.load_profile determine_profiles input
          @factory.set_seed 1

          priorities = build_priorities input, @factory.langlist
          detector   = com.cybozu.labs.langdetect.Detector.new @factory

          detector.set_prior_map priorities
          detector.append input.downcase
          detector
        end

        ##
        # @return [String]
        #
        def detect input
          detector = new_detector input
          detector.detect

        # The core Java code raise an exception when it can't detect a language.
        # Since this isn't actually something fatal we'll capture this and return
        # "unknown" instead.
        rescue com.cybozu.labs.langdetect.LangDetectException
          return 'unknown'
        end

        protected

        ##
        # Builds a Java Hash mapping the priorities for all OpeNER and non OpeNER
        # languages.
        #
        # If the input size is smaller than the short profiles threshold non
        # OpeNER languages are _disabled_. This is to ensure that these languages
        # are detected properly when analysing only 1-2 words.
        #
        # @param [String] input
        # @param [Array<String>] languages
        # @return [java.util.HashMap]
        #
        def build_priorities input, languages
          priorities = java.util.HashMap.new
          priority   = if short_input? input then 0.0 else DEFAULT_PRIORITY end

          PRIORITIES.each do |lang, val|
            priorities.put(lang, val)
          end

          languages.each do |language|
            unless priorities.contains_key(language)
              priorities.put(language, priority)
            end
          end

          priorities
        end

        ##
        # @param [String] input
        # @return [String]
        #
        def determine_profiles input
          if short_input? input then DEFAULT_SHORT_PROFILES_PATH else DEFAULT_PROFILES_PATH end
        end

        ##
        # @param [String] input
        # @return [TrueClass|FalseClass]
        #
        def short_input? input
          input.length <= SHORT_THRESHOLD
        end

      end
    end
  end
end
