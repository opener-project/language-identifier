module Opener
  class LanguageIdentifier
    ##
    # Class for building basic KAF documents that contain the correct language
    # tag and the raw input that was anaylzed.
    #
    # @!attribute [r] xml
    #  @return [Builder::XmlMarkup]
    #
    # @!attribute [r] original_text
    #  @return [String]
    #
    # @!attribute [r] language
    #  @return [String]
    #
    class KafBuilder
      attr_reader :xml, :original_text, :language

      ##
      # @param [String] text The input text that was analyzed.
      # @param [String] language The language of the text.
      #
      def initialize(text, language)
        @xml           = Builder::XmlMarkup.new(:indent => 2)
        @language      = language.strip
        @original_text = text
      end

      ##
      # Builds the KAF document.
      #
      def build
        xml.instruct!(
          :xml,
          :version    => '1.0',
          :encoding   => 'UTF-8',
          :standalone => 'yes'
        )

        xml.KAF('xml:lang' => language, 'version' => version) do |node|
          node.raw(original_text)
        end
      end

      ##
      # Returns the XML document as a String.
      #
      # @return [String]
      #
      def to_s
        return xml.target!
      end

      ##
      # @return [String]
      #
      def version
        return "2.1"
      end
    end # KafBuilder
  end # LanguageIdentifier
end # Opener
