module DocoptCompgen
    def self.root_dir
        File.expand_path('../..', __FILE__)
    end
end

require_relative 'docopt-compgen/version'
require_relative 'docopt-compgen/util'
require_relative 'docopt-compgen/node'
require_relative 'docopt-compgen/parser'
require_relative 'docopt-compgen/generator'
