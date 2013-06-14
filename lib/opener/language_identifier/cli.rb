module Opener
  class LanguageIdentifier
    ##
    # CLI wrapper around {Opener::LanguageIdentifier} using OptionParser.
    #
    # @!attribute [r] options
    #  @return [Hash]
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

          opts.on('-h', '--help', 'Shows this help message') do
            show_help
          end

          opts.on('-v', '--version', 'Shows the current version') do
            show_version
          end

          opts.on('-d', 'Use extended language detection') do
            @options[:extended] = true
          end

          opts.on('-k', '--kaf', 'Output the language as KAF') do
            @options[:kaf] = true
          end

          opts.separator <<-EOF

Examples:

  cat example_text.txt | #{opts.program_name}    # Basic detection
  cat example_text.txt | #{opts.program_name} -d # Extended detection

Languages:

  * Dutch (nl)
  * English (en)
  * French (fr)
  * German (de)
  * Italian (it)
  * Spanish (es)

Extended Languages:

  When turning on extended language detection the following languages are also
  supported:

  * Danish (da)
  * Norwegian (no)
  * Portugese (pt)
  * Swedish (sv)

  Extended language detection is turned off by default to increase the
  detection accuracy.
          EOF
        end
      end

      ##
      # @param [String] input
      #
      def run(input)
        option_parser.parse!(options[:args])

        identifier = LanguageIdentifier.new(options)

        stdout, stderr, process = identifier.run(input)

        if process.success?
          puts stdout

          STDERR.puts(stderr) unless stderr.empty?
        else
          abort stderr
        end
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
