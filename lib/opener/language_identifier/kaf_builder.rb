require 'builder'

module Opener
  class LanguageIdentifier
    class KafBuilder

      attr_reader :xml, :original_text, :language

      def initialize(text, language)
        @original_text = text
        @language = language.strip
        @xml = Builder::XmlMarkup.new
      end

      def build
        xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8", :standalone=>"yes"
        xml.KAF(:'xml:lang'=>language){|k| k.raw(original_text)}
      end

      def to_s
        xml.to_s
      end

    end
  end
end
