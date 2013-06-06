require 'mkmf'
require 'fileutils'

find_executable('perl')
find_executable('make')

ext       = File.expand_path('../../../core/ext', __FILE__)
perl_lib  = File.expand_path('../../../core/lib', __FILE__)
extension = RbConfig::CONFIG['DLEXT']
sanity    = File.join(Dir.pwd, 'hack.' + extension)

FileUtils.touch(sanity)

Dir.glob(File.join(ext, '*')).each do |dir|
  Dir.chdir(dir) do
    puts "Building Perl for #{File.basename(dir)}"

    system("perl Makefile.PL PREFIX=#{perl_lib} LIB=#{perl_lib}")
    system("make")
    system("make install")
  end
end

$makefile_created = true
