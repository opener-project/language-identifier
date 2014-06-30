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

  context 'probabilities' do
    before do
      @probs = described_class.new(:probs => true).run(@input)
    end

    example 'return the probabilities' do
      @probs.empty?.should == false
    end

    example 'return the language of the first probability' do
      @probs[0].lang.should == 'en'
    end

    example 'return the probability score' do
      @probs[0].prob.should > 0
    end
  end

  context 'text output' do
    example 'return the code for an English text' do
      described_class.new(:kaf => false).run(@input).should == 'en'
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

  context 'error handling' do
    before do
      detector = described_class.new

      detector.stub(:options).and_raise('Foobar')

      @document = Nokogiri::XML(detector.run(@input))
    end

    example 'add the error message to the KAF document' do
      @document.xpath('//KAF/errors/error')[0].text.should == 'Foobar'
    end

    example 'add the component class to the error node' do
      @document.xpath('//KAF/errors/error')[0].attr('class') \
        .should == described_class.to_s
    end

    example 'add the component version to the error node' do
      @document.xpath('//KAF/errors/error')[0].attr('version') \
        .should == Opener::LanguageIdentifier::VERSION
    end
  end
end
