require File.expand_path('../lib/opener/language_identifier', __FILE__)

Gem::Specification.new do |gem|
  gem.name                  = 'opener-language-identifier'
  gem.version               = Opener::LanguageIdentifier::VERSION
  gem.authors               = ['development@olery.com']
  gem.summary               = 'Language identifier for human readable text.'
  gem.description           = gem.summary
  gem.homepage              = "http://opener-project.github.com/"
  gem.extensions            = ['ext/hack/extconf.rb']
  gem.has_rdoc              = 'yard'
  gem.required_ruby_version = '>= 1.9.2'

  gem.files       = `git ls-files`.split("\n")
  gem.executables = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files  = gem.files.grep(%r{^(test|spec|features)/})

  gem.add_dependency 'builder', '~>3.1'
  gem.add_dependency 'sinatra', '~>1.4.2'
  gem.add_dependency 'httpclient'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'cucumber'
  gem.add_development_dependency 'pry'
end
