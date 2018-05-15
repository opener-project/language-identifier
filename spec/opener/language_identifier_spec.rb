require 'spec_helper'

describe Opener::LanguageIdentifier do
  before do
    @input = 'Hello world, how are you doing today?'
  end

  context '#initialize' do
    example 'store the options' do
      instance = described_class.new(:kaf => false)

      instance.options[:kaf].should == false
    end
  end

  context 'text output' do
    example 'return the code for an English text' do
      described_class.new(:kaf => false).run(@input).should == 'en'
    end

    example 'return "unknown" when a language could not be detected' do
      described_class.new(:kaf => false).run('123').should == 'unknown'
    end
  end

  context 'KAF output' do
    before do
      @document = Nokogiri::XML(described_class.new.run(@input))
    end

    example 'set the language as an attribute' do
      @document.xpath('//KAF/@xml:lang')[0].value.should == 'en'
    end

    example 'include the raw language in the document' do
      @document.xpath('//KAF/raw')[0].text.should == @input
    end
  end
end
