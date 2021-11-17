require_relative 'lib/docopt_compgen/version'

Gem::Specification.new do |spec|
    spec.homepage = 'https://github.com/crdx/docopt-compgen'
    spec.summary = 'docopt completion generator'
    spec.name = 'docopt-compgen'
    spec.version = DocoptCompgen::VERSION
    spec.author = 'crdx'
    spec.license = 'MIT'
    spec.metadata['rubygems_mfa_required'] = 'true'

    spec.required_ruby_version = '>= 3.0'

    spec.files = Dir['lib/**/*']
    spec.executables = ['docopt-compgen']

    spec.add_runtime_dependency 'colorize', '~> 0.8.1'
    spec.add_runtime_dependency 'docopt', '~> 0.6.1'

    spec.add_development_dependency 'rake', '~> 13.0'
end
