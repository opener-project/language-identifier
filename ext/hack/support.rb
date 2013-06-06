# Directory that contains all the Perl modules that have to be compiled.
PERL_EXT = File.expand_path('../../../core/ext', __FILE__)

# Directory containing all the installed Perl modules.
PERL_LIB = File.expand_path('../../../core/lib/built', __FILE__)

##
# Compiles and installs a Perl module.
#
# @param [String] directory The directory containing the Perl module.
# @param [String] prefix The path to use for the installation directory and
#  library path.
#
def compile_perl_extension(directory, prefix = PERL_LIB)
  Dir.chdir(directory) do
    puts "Building Perl module #{File.basename(directory)}"

    sh "perl Makefile.PL PREFIX=#{prefix} LIB=#{prefix}"
    sh 'make'
    sh 'make install'
    sh 'make clean'
    sh 'rm Makefile.old'
  end
end

##
# Returns an Array containing all the Perl extensions that have to be compiled.
#
# @return [Array]
#
def perl_extensions
  return Dir.glob(File.join(PERL_EXT, '*'))
end
