module Opener
  class LanguageIdentifier
    ##
    # CLI wrapper around {Opener::LanguageIdentifier} using OptionParser.
    #
    # @!attribute [r] options
    #  @return [Hash]
    #
    # @!attribute [r] option_parser
    #  @return [OptionParser]
    #
    class CLI
      attr_reader :options, :option_parser

      ##
      # @param [Hash] options
      #
      def initialize(options = {})
        @options = DEFAULT_OPTIONS.merge(options)

        @option_parser = OptionParser.new do |opts|
          opts.program_name   = 'language-identifier'
          opts.summary_indent = '  '

          opts.on('-v', '--version', 'Shows the current version') do
            show_version
          end

          opts.on('-k', '--[no-]kaf', 'Output the language as KAF') do |v|
            @options[:kaf] = v
          end

          opts.separator <<-EOF

Examples:

  cat example_text.txt | #{opts.program_name}    # Basic detection

Languages:

  * ar	Arabic
  * bg	Bulgarian
  * bn	Bengali
  * cs	Czech
  * da	Danish
  * de	German
  * el	Greek
  * en	English
  * es	Spanish
  * et	Estonian
  * fa	Persian
  * fi	Finnish
  * fr	French
  * gu	Gujarati
  * he	Hebrew
  * hi	Hindi
  * hr	Croatian
  * hu	Hungarian
  * id	Indonesian
  * it	Italian
  * ja	Japanese
  * kn	Kannada
  * ko	Korean
  * lt	Lithuanian
  * lv	Latvian
  * mk	Macedonian
  * ml	Malayalam
  * mr	Marathi
  * ne	Nepali
  * nl	Dutch
  * no	Norwegian
  * pa	Punjabi
  * pl	Polish
  * pt	Portuguese
  * ro	Romanian
  * ru	Russian
  * sk	Slovak
  * sl	Slovene
  * so	Somali
  * sq	Albanian
  * sv	Swedish
  * sw	Swahili
  * ta	Tamil
  * te	Telugu
  * th	Thai
  * tl	Tagalog
  * tr	Turkish
  * uk	Ukrainian
  * ur	Urdu
  * vi	Vietnamese
  * zh-cn	Simplified Chinese
  * zh-tw	Traditional Chinese
          EOF

          opts.separator ""
          opts.separator "Common options:"
          # No argument, shows at tail.  This will print an options summary.
          # Try it and see!
          opts.on_tail("-h", "--help", "Show this message.") do
            puts opts
            exit
          end
        end
      end

      ##
      # @param [String] input
      #
      def run(input)
        option_parser.parse!(options[:args])
        identifier = LanguageIdentifier.new(options)

        output = identifier.run(input)
        puts output
      end

      private

      ##
      # Shows the help message and exits the program.
      #
      def show_help
        abort option_parser.to_s
      end

      ##
      # Shows the version and exits the program.
      #
      def show_version
        abort "#{option_parser.program_name} v#{VERSION} on #{RUBY_DESCRIPTION}"
      end
    end # CLI
  end # LanguageIdentifier
end # Opener
