require 'opener/build-tools'

include Opener::BuildTools::Requirements
include Opener::BuildTools::Perl

# Directory that contains all the Perl modules that have to be compiled.
PERL_EXT = File.expand_path('../../../core/ext', __FILE__)

# Directory to store the built files in.
PERL_PREFIX = File.expand_path('../../../core/lib/built', __FILE__)

##
# Compiles and installs a Perl module.
#
# @param [String] directory The directory containing the Perl module.
# @param [String] prefix The path to use for the installation directory and
#  library path.
#
def compile_perl_extension(directory, prefix = PERL_PREFIX)
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

##
# Checks if the various requirements are met and bails out if this is not the
# case.
#
def verify_requirements
  require_executable('make')
  require_executable('perl')

  require_perl_module('ExtUtils::MakeMaker')
  require_perl_module('FindBin')
end
