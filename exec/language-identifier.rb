#!/usr/bin/env ruby

require 'opener/daemons'

require_relative '../lib/opener/language_identifier'

daemon = Opener::Daemons::Daemon.new(Opener::LanguageIdentifier)

daemon.start
