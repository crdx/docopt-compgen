module DocoptCompgen
    class Node
        attr_reader :arguments
        attr_reader :subcommands
        attr_reader :parent

        def initialize(parent = nil)
            @parent = parent
            @subcommands = {}
            @options = []
            @arguments = []
        end

        def add_argument(argument)
            @arguments << argument
        end

        def add_option(option)
            @options << option
        end

        def options
            options = @options
            if @parent
                options += @parent.options
            end
            options.uniq
        end

        def add_subcommand(name)
            if @subcommands[name].nil?
                @subcommands[name] = Node.new(self)
            end
            @subcommands[name]
        end
    end
end
