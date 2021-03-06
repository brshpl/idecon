# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'idecon/version'

Gem::Specification.new do |spec|
  spec.name          = 'idecon'
  spec.version       = Idecon::VERSION
  spec.authors       = ['Igor']
  spec.email         = ['igor_barishpol@mail.ru']

  spec.summary       = 'Generating an identicon for a Level.travel\'s task'
  spec.homepage      = 'https://github.com/brshpl/idecon'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/brshpl/idecon'
  spec.metadata['changelog_uri'] = 'https://github.com/brshpl/idecon/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'chunky_png'
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '>= 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
