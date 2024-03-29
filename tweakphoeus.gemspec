# frozen_string_literal: true

require_relative 'lib/tweakphoeus/version'

Gem::Specification.new do |spec|
  spec.name          = 'tweakphoeus'
  spec.version       = Tweakphoeus::VERSION
  spec.authors       = ['David Martin Garcia']
  spec.email         = ['davidmartingarcia@gmail.com']

  spec.summary       = 'Typhoeus on steroids.'
  spec.description   = 'Typhoeus wrapper with some extras.'
  spec.homepage      = 'https://github.com/basestylo/Tweakphoeus/'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/dmartingarcia/Tweakphoeus'
  spec.metadata['changelog_uri'] = 'https://github.com/dmartingarcia/Tweakphoeus/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'typhoeus', '~> 1.4'
  spec.add_development_dependency 'bundler', '~> 2.2'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.10'
end
