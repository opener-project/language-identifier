#!/usr/bin/env ruby

require 'opener/daemons'
require_relative '../lib/opener/language_identifier'

options = Opener::Daemons::OptParser.parse!(ARGV)
daemon  = Opener::Daemons::Daemon.new(Opener::LanguageIdentifier, options)

daemon.start
