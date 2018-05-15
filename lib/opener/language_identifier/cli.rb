module Opener
  class LanguageIdentifier
    ##
    # CLI wrapper around {Opener::LanguageIdentifier} using Slop.
    #
    # @!attribute [r] parser
    #  @return [Slop]
    #
    class CLI
      attr_reader :parser

      def initialize
        @parser = configure_slop
      end

      ##
      # @param [Array] argv
      #
      def run(argv = ARGV)
        parser.parse(argv)
      end

      ##
      # @return [Slop]
      #
      def configure_slop
        return Slop.new(:strict => false, :indent => 2, :help => true) do
          banner 'Usage: language-identifier [OPTIONS]'

          separator <<-EOF.chomp

About:

    Language detection for various languages such as English and Dutch. This
    command reads input from STDIN. Output can be a language code as plain text,
    a KAF document containing the input text and language code, or a list of
    probabilities.

Example:

    cat some_file.kaf | language-identifier
          EOF

          separator "\nOptions:\n"

          on :v, :version, 'Shows the current version' do
            abort "language-identifier v#{VERSION} on #{RUBY_DESCRIPTION}"
          end

          on :'no-kaf', 'Disables KAF output'

          run do |opts, args|
            enable_kaf   = true

            if opts[:'no-kaf']
              enable_kaf = false
            end

            identifier = LanguageIdentifier.new(
              args:  args,
              kaf:   enable_kaf,
              probs: false,
            )

            input = STDIN.tty? ? nil : STDIN.read

            puts identifier.run(input)
          end
        end
      end
    end # CLI
  end # LanguageIdentifier
end # Opener
