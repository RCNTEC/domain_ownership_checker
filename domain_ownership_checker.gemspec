# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = 'domain_ownership_checker'
  gem.version       = '0.0.3'
  gem.date          = '2017-12-4'
  gem.summary       = 'Domain Ownership Checker'
  gem.description   = 'Checks domain ownership through a text file and DNS CNAME-record'
  gem.authors       = ['Alexander Kadyrov', 'Pavel Kosykh']
  gem.email         = ['gruz0.mail@gmail.com', 'pavkosykh@gmail.com']
  gem.homepage      = 'https://github.com/RCNTEC/domain_ownership_checker'
  gem.license       = 'GPL-3.0'
  gem.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|images)/}) }
  gem.require_paths = ['lib']

  gem.add_development_dependency 'rake', '~> 0'
  gem.add_development_dependency 'minitest', '~> 5.0', '>= 5.0.7'
end
