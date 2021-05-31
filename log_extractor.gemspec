# frozen_string_literal: true

require_relative "lib/log_extractor/version"

Gem::Specification.new do |spec|
  spec.name          = "log_extractor"
  spec.version       = LogExtractor::VERSION
  spec.authors       = ["Sergio Gómez"]
  spec.email         = ["hola@sergio-gomez.com"]

  spec.summary       = "Simple tool to extract and parse logs from ELK syslog_messages"
  spec.description   = "Abstraction layers for ElasticSearch and for parsing logs"
  spec.homepage      = "https://github.com/sergiogomez/log_extractor"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.5"

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata["documentation_uri"] = "#{spec.homepage}/blob/main/README.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  # spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "attr_extras", "~> 6.2"
  spec.add_runtime_dependency "elasticsearch", "~> 7.12"

  spec.add_development_dependency "bundler", "~> 2.2"
  spec.add_development_dependency "pry", "~> 0.13"
  spec.add_development_dependency "pry-byebug", "~> 3.9"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.10"
  spec.add_development_dependency "rubocop", "~> 1.15"
end
