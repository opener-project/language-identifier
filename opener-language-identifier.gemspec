require File.expand_path('../lib/opener/language_identifier/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name                  = 'opener-language-identifier'
  gem.version               = Opener::LanguageIdentifier::VERSION
  gem.authors               = ['development@olery.com']
  gem.summary               = 'Language identifier for human readable text.'
  gem.description           = gem.summary
  gem.homepage              = "http://opener-project.github.com/"
  gem.has_rdoc              = 'yard'
  gem.required_ruby_version = '>= 1.9.2'

  gem.files = Dir.glob([
    'core/target/LanguageDetection-*.jar',
    'core/target/classes/**/*.*',
    'exec/**/*',
    'lib/**/*',
    'config.ru',
    '*.gemspec',
    'README.md'
  ]).select { |file| File.file?(file) }

  gem.executables = Dir.glob('bin/*').map { |file| File.basename(file) }

  gem.add_dependency 'builder'
  gem.add_dependency 'puma'
  gem.add_dependency 'sinatra', '~>1.4.2'
  gem.add_dependency 'httpclient'
  gem.add_dependency 'uuidtools'
  gem.add_dependency 'opener-build-tools'
  gem.add_dependency 'opener-webservice'
  gem.add_dependency 'opener-daemons'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'cucumber'
  gem.add_development_dependency 'rake'
end
