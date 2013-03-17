# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'asana_digest/version'

Gem::Specification.new do |spec|
  spec.name          = "asana_digest"
  spec.version       = AsanaDigest::VERSION
  spec.authors       = ["Tatsuhiko Miyagawa"]
  spec.email         = ["miyagawa@bulknews.net"]
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "hipchat"
  spec.add_dependency "active_support"
  spec.add_dependency "tzinfo"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
