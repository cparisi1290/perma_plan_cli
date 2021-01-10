require_relative 'lib/perma_plan_cli/version'

Gem::Specification.new do |spec|
  spec.name          = "perma_plan_cli"
  spec.version       = PermacultureResources::VERSION
  spec.authors       = ["Cassandra Parisi"]
  spec.email         = ["cparisi1290@gmail.com"]

  spec.summary       = %q{Learn about permaculture.}
  spec.description   = %q{Pick a book to learn more information about permaculture.}
  spec.homepage      = "http://www.github.comm/cparisi1290"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "http://www.github.comm/cparisi1290"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://www.github.comm/cparisi1290"
  spec.metadata["changelog_uri"] = "http://www.github.comm/cparisi1290"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~>2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_dependency "nokogiri"
  spec.add_dependency "rainbow"
  
end
