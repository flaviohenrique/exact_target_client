# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'exact_target_client/version'

Gem::Specification.new do |spec|
  spec.name          = "exact_target_client"
  spec.version       = ExactTargetClient::VERSION
  spec.authors       = ["Flavio Andrade"]
  spec.email         = ["flavio.henrique85@gmail.com"]

  spec.summary       = 'Client do use exact target integration'
  spec.description   = 'Client do use exact target integration'
  spec.homepage      = 'http://www.eduk.com.br'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'configurations', '~> 2.2.0'
  spec.add_dependency 'rest-client', '~> 2.0.0'

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency 'redis', '~> 3.3.3'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency "simplecov"
end
