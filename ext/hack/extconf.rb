require 'mkmf'
require_relative 'support'

find_executable('perl')
find_executable('make')

# RubyGems won't install the extension if there's no corresponding file for it
# (e.g. hack.so for Linux).
sanity = File.join(Dir.pwd, 'hack.' + RbConfig::CONFIG['DLEXT'])

FileUtils.touch(sanity)

perl_extensions.each do |directory|
  compile_perl_extension(directory)
end

# Without this RubyGems assumes the Makefile was not generated and will abort
# the process of building/installing the Gem.
$makefile_created = true
