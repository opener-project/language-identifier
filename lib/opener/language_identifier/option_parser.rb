require 'optparse'

module Opener
  class LanguageIdentifier
    class OptionParser

      def self.parse(options_array)
        options = {}
        ::OptionParser.new do |opts|
          opts.banner = "\nUsage: cat some_text.txt | language-detector [options]\n\n"

          opts.on("-d", "Use extended language list") do |v|
            options[:extended] = v
          end

          opts.on("-k", "--kaf", "Output a KAF file with the xml:lang attribute set") do |v|
            options[:kaf] = v
          end

          opts.separator "\n"
          opts.separator <<-EOF.strip

      Default languages detected:

      without the -d flag it detects:

        english (en), french (fr), spanish (es), italian (it) german (de) and dutch (nl)

      with the -d flag it detects:

        english (en), french (fr), spanish (es), portugese (pt) italian (it),
        german (de), dutch (nl), swedish (sv), norwegian (no) and danish (da)

      Why the -d flag?

        By limiting the set of languages you want to detect, you increase the
        certainty levels of the languages you do detect.




          EOF

        end.parse!(options_array)
        return options
      end
    end
  end
end
