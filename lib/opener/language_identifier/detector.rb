module Opener
  class LanguageIdentifier
    ##
    # Ruby wrapper around the Cybozu DetectorFactory and Detector classes. This
    # class automatically handles switching of profiles based on input sizes,
    # assigning priorities to languages, etc.
    #
    class Detector
      attr_reader :profiles_path, :short_profiles_path

      ##
      # Path to the directory containing the default profiles.
      #
      # @return [String]
      #
      DEFAULT_PROFILES_PATH = File.expand_path(
        '../../../../core/target/classes/profiles',
        __FILE__
      )

      ##
      # Path to the directory containing the default short profiles.
      #
      # @return [String]
      #
      DEFAULT_SHORT_PROFILES_PATH = File.expand_path(
        '../../../../core/target/classes/short_profiles',
        __FILE__
      )

      ##
      # The amount of characters after which the detector should switch to using
      # the longer profiles set.
      #
      # @return [Fixnum]
      #
      SHORT_THRESHOLD = 15

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
      # @param [Hash] options
      #
      # @option options [String] :profiles_path
      # @option options [String] :short_profiles_path
      #
      def initialize(options = {})
        options.each do |key, value|
          instance_variable_set("@#{key}", value) if respond_to?(key)
        end

        @profiles_path       ||= DEFAULT_PROFILES_PATH
        @short_profiles_path ||= DEFAULT_SHORT_PROFILES_PATH
      end

      ##
      # @return [String]
      #
      def detect(input)
        return new_detector(input).detect

      # The core Java code raise an exception when it can't detect a language.
      # Since this isn't actually something fatal we'll capture this and return
      # "unknown" instead.
      rescue com.cybozu.labs.langdetect.LangDetectException
        return 'unknown'
      end

      ##
      # @return [Array]
      #
      def probabilities(input)
        return new_detector(input).get_probabilities.to_array
      end

      ##
      # Returns a new detector with the profiles set based on the input.
      #
      # This method analyses a lowercased version of the input as this yields
      # better results for short text.
      #
      # @param [String] input
      # @return [CybozuDetector]
      #
      def new_detector(input)
        factory = com.cybozu.labs.langdetect.DetectorFactory.new

        factory.load_profile(determine_profiles(input))
        factory.set_seed(1)

        priorities = build_priorities(input, factory.langlist)
        detector   = com.cybozu.labs.langdetect.Detector.new(factory)

        detector.set_prior_map(priorities)
        detector.append(input.downcase)

        return detector
      end

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
      def build_priorities(input, languages)
        priorities = java.util.HashMap.new
        priority   = short_input?(input) ? 0.0 : DEFAULT_PRIORITY

        PRIORITIES.each do |lang, val|
          priorities.put(lang, val)
        end

        languages.each do |language|
          unless priorities.contains_key(language)
            priorities.put(language, priority)
          end
        end

        return priorities
      end

      ##
      # @param [String] input
      # @return [String]
      #
      def determine_profiles(input)
        return short_input?(input) ? short_profiles_path : profiles_path
      end

      ##
      # @param [String] input
      # @return [TrueClass|FalseClass]
      #
      def short_input?(input)
        return input.length <= SHORT_THRESHOLD
      end
    end # Detector
  end # LanguageIdentifier
end # Opener
