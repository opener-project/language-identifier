require 'mkmf'
require 'fileutils'

source = File.expand_path('../Makefile_hack', __FILE__)
target = File.join(Dir.pwd, 'Makefile')
dummy  = File.join(Dir.pwd, 'language_identifier.so')

FileUtils.cp(source, target)
FileUtils.touch(dummy)

$makefile_created = true
