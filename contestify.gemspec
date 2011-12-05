# -*- encoding: utf-8 -*-
require File.expand_path('../lib/contestify/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nicolás Hock Isaza"]
  gem.email         = ["nhocki@gmail.com"]
  gem.description   = %q{Gem to prepare internal programming contests taking problems from the COCI contests.}
  gem.summary       = %q{Gem to prepare internal programming contests taking problems from the COCI contests.}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "contestify"
  gem.require_paths = ["lib"]
  gem.version       = Contestify::VERSION
end
