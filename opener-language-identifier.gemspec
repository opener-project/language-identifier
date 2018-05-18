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

  gem.license = 'Apache 2.0'

  gem.files = Dir.glob([
    'core/target/LanguageDetection-*.jar',
    'core/target/classes/**/*',
    'exec/**/*',
    'lib/**/*',
    'config.ru',
    '*.gemspec',
    'README.md',
    'LICENSE.txt'
  ]).select { |file| File.file?(file) }

  gem.executables = Dir.glob('bin/*').map { |file| File.basename(file) }

  gem.add_dependency 'newrelic_rpm', '~> 3.0'

  gem.add_dependency 'opener-daemons', ['~> 2.5', '>= 2.5.6']
  gem.add_dependency 'opener-webservice', '~> 2.1'

  gem.add_dependency 'builder'
  gem.add_dependency 'nokogiri'
  gem.add_dependency 'slop', '~> 3.5'
  gem.add_dependency 'detect_language'

  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'cliver'
end
