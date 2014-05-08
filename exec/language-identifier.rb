#!/usr/bin/env ruby
#
require 'rubygems'
require 'opener/daemons'
require 'opener/language_identifier'

options = Opener::Daemons::OptParser.parse!(ARGV)
daemon = Opener::Daemons::Daemon.new(Opener::LanguageIdentifier, options)
daemon.start
