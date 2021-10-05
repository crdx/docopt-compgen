module DocoptCompgen
    class Parser
        def initialize(help)
            @help = help
        end

        def to_node
            build(parse_docopt, Node.new)
        end

        private

        def parse_docopt
            options = Docopt.parse_defaults(@help)

            pattern = Docopt.parse_pattern(
                Docopt.formal_usage(Docopt.printable_usage(@help)),
                options,
            )

            # Options explicitly specified in subcommands cannot be used for a
            # general [options] placeholder. This is necessary so that options
            # can be restricted to specific subcommands while still allowing the
            # remaining to be used in place of [options].
            used_options = pattern.flat(Docopt::Option).uniq
            pattern.flat(Docopt::AnyOptions).each do |any_options|
                any_options.children = options.reject do |option|
                    used_options.include?(option)
                end.uniq
            end

            return pattern
        end

        def build(pattern, node)
            wrappers = [
                Docopt::Either,
                Docopt::Optional,
                Docopt::OneOrMore,
                Docopt::AnyOptions,
            ]

            if wrappers.include?(pattern.class)
                pattern.children.each do |child|
                    build(child, node)
                end
            end

            if [Docopt::Required].include?(pattern.class)
                pattern.children.each do |child|
                    new_node = build(child, node)
                    if child.is_a?(Docopt::Command)
                        node = new_node
                    end
                end
            end

            # rubocop:disable Style/SoleNestedConditional
            if [Docopt::Option].include?(pattern.class)
                # if pattern.short
                #     node.add_option(pattern.short)
                # end

                if pattern.long
                    node.add_option(pattern.long)
                end
            end
            # rubocop:enable Style/SoleNestedConditional

            if [Docopt::Argument].include?(pattern.class)
                node.add_argument(pattern.name)
            end

            if [Docopt::Command].include?(pattern.class)
                node = node.add_subcommand(pattern.name)
            end

            return node
        end
    end
end
