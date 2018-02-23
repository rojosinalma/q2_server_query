
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "q2_server_query/version"

Gem::Specification.new do |spec|
  spec.name          = "q2_server_query"
  spec.version       = Q2ServerQuery::VERSION
  spec.authors       = ["Feña Agar"]
  spec.email         = ["ferliagno@gmail.com"]

  spec.summary       = %q{Simple gem to do status queries to quake 2 servers.}
  spec.description   = %q{Simple gem to do status queries to quake 2 servers.}
  spec.homepage      = "https://github.com/elfenars/q2_server_query"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
