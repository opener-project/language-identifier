require 'bundler/gem_tasks'
require 'opener/build-tools'
require 'opener/build-tools/tasks/java'

include Opener::BuildTools::Requirements
include Opener::BuildTools::Java

CORE_DIRECTORY = File.expand_path('../core', __FILE__)

desc 'Verifies the requirements'
task :requirements do
  require_executable('java')
  require_version('java', java_version, '1.7.0')
  require_executable('mvn')
end

desc 'Alias for java:compile'
task :compile => [:requirements, 'java:compile']

desc 'Runs the tests'
task :test => :compile do
  sh 'cucumber features'
end

desc 'Cleans the repository'
task :clean => ['java:clean:packages']

task :build   => :compile
task :default => :test
