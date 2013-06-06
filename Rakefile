require 'rubygems/package_task'
require 'rake/extensiontask'

GEMSPEC = Gem::Specification.load('Vicom-language-identifier-lite_kernel.gemspec')

Rake::ExtensionTask.new('language_identifier', GEMSPEC)

Gem::PackageTask.new(GEMSPEC) do |pkg|
  pkg.need_tar = false
  pkg.need_zip = false
end
