module DocoptCompgen
    def self.root_dir
        File.expand_path('..', __dir__)
    end
end

require_relative 'docopt_compgen/version'
require_relative 'docopt_compgen/util'
require_relative 'docopt_compgen/node'
require_relative 'docopt_compgen/parser'
require_relative 'docopt_compgen/generator'
