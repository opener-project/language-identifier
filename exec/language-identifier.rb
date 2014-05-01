require_relative '../lib/opener/daemon'
require_relative '../lib/opener/opt_parser'
require_relative '../lib/opener/language_identifier'

options = Opener::OptParser.parse!(ARGV)
daemon = Opener::Daemon.new(Opener::LanguageIdentifier, options)
daemon.start
