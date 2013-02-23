# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'empireavenue/version'

Gem::Specification.new do |spec|
  spec.add_dependency 'faraday', ['~> 0.8', '< 0.10']
  spec.add_dependency 'multi_json', '~> 1.0'
  spec.add_development_dependency 'bundler', '~> 1.0'
  spec.authors = ["Ralph Janke"]
  #spec.cert_chain  = ['public_cert.pem']
  spec.description = %q{A Ruby interface to the Empire Avenue API.}
  spec.email = ['txwikinger@ubuntu.com']
  spec.files = %w(LICENSE.md README.md Rakefile empireavenue.gemspec)
  spec.files += Dir.glob("lib/**/*.rb")
  spec.files += Dir.glob("spec/**/*")
  spec.homepage = 'http://txwinger.github.com/empireavenue/'
  spec.licenses = ['AGPL']
  spec.name = 'empireavenue'
  spec.require_paths = ['lib']
  spec.required_rubygems_version = '>= 1.3.6'
  #spec.signing_key = File.expand_path("~/.gem/private_key.pem") if $0 =~ /gem\z/
  spec.summary = spec.description
  spec.test_files = Dir.glob("spec/**/*")
  spec.version = EmpireAvenue::Version
end
