require_relative '../../lib/opener/language_identifier'
require 'rspec/expectations'
require 'tempfile'
require 'pry'

def kernel_root
  File.expand_path("../../../", __FILE__)
end

def kernel
  Opener::LanguageIdentifier.new
end
