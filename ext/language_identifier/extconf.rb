require 'mkmf'
require 'fileutils'

find_executable('perl')
find_executable('make')

vendor   = File.expand_path('../../../core/vendor', __FILE__)
perl_lib = File.expand_path('../../../core/lib', __FILE__)
sanity   = File.join(Dir.pwd, 'language_identifier.so')

FileUtils.touch(sanity)

Dir.glob(File.join(vendor, '*')).each do |dir|
  Dir.chdir(dir) do
    puts "Building Perl for #{File.basename(dir)}"

    system("perl Makefile.PL PREFIX=#{perl_lib} LIB=#{perl_lib}")
    system("make")
    system("make install")
  end
end

$makefile_created = true
