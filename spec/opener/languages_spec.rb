require 'spec_helper'

describe Opener::LanguageIdentifier do
  language_directories.each do |directory|
    language = File.basename(directory)

    context "when detecting #{language}" do
      language_files(directory).each do |file|
        filename = File.basename(file)

        example "detect #{filename} as language #{language}" do
          input      = File.read(file).strip
          identifier = described_class.new(:kaf => false)

          identifier.run(input).should == language
        end
      end
    end
  end
end
