#!/usr/bin/env jruby
#
require 'opener/daemons'
require 'opener/language_identifier'

options = Opener::Daemons::OptParser.parse!(ARGV)
daemon = Opener::Daemons::Daemon.new(Opener::LanguageIdentifier, options)
$0 = "OpeNER Language Identifier Daemon"
daemon.start
