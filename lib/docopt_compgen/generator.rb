module DocoptCompgen
    class Generator
        def initialize(command, node, command_name: nil, namespace: nil, header: nil)
            @command = command ? File.basename(command) : command_name
            @node = node
            @command_name = command_name || Util.slugify(@command)
            @namespace = '_' + namespace
            @header = header
        end

        def indent(str, level)
            "\n" + str.strip.lines.map { |s| (' ' * level) + s }.join
        end

        def get_op(node)
            if node.subcommands.length > 0
                'eq'
            else
                'ge'
            end
        end

        def path_arguments?(arguments)
            arguments.any? { |a| %w[<file> <dir> <path>].include?(a) }
        end

        def path_options?(options)
            options.any? { |a| %w[--file --dir --path].include?(a) }
        end

        def include_files?(node)
            return path_arguments?(node.arguments) || path_options?(node.options)
        end

        def make_compreply(node)
            words = []

            if node.options.length > 0
                words << node.options
            end

            words << node.subcommands.keys

            return [include_files?(node), words.flatten.join(' ')]
        end

        def make(command_name, node, level)
            subcommand_switch = make_subcommand_switch(
                command_name,
                level,
                node.subcommands,
            )

            op = get_op(node)
            include_files, words = make_compreply(node)

            functions = [
                make_function(
                    command_name,
                    op,
                    level,
                    words,
                    include_files,
                    subcommand_switch,
                ),
            ]

            node.subcommands.each do |subcommand_name, subcommand_node|
                functions << make(
                    '%s_%s' % [command_name, subcommand_name],
                    subcommand_node,
                    level + 1,
                )
            end

            return functions.join("\n")
        end

        def make_function(command_name, op, level, words, include_files, subcommand_switch) # rubocop:disable Metrics/ParameterLists
            files = ''
            if include_files
                files = indent(<<~EOF, 8)
                    local IFS=$'\\n' # Handle filenames with spaces.
                    COMPREPLY+=($(compgen -f -- "$cur"))
                EOF
            end

            return <<~EOF
                function #{@namespace}_#{command_name} {
                    local cur
                    cur="${COMP_WORDS[COMP_CWORD]}"

                    if [ "$COMP_CWORD" -#{op} #{level} ]; then
                        COMPREPLY=($(compgen -W '#{words}' -- "$cur"))#{files}#{subcommand_switch}
                    fi
                }
            EOF
        end

        def make_subcommand_switch(command_name, level, subcommands)
            if subcommands.length == 0
                return ''
            end

            cases = subcommands.map do |subcommand_name, _node|
                "#{subcommand_name}) #{@namespace}_#{command_name}_#{subcommand_name} ;;"
            end.join("\n        ")

            return indent(<<~EOF, 4)
                else
                    case ${COMP_WORDS[#{level}]} in
                        #{cases}
                    esac
            EOF
        end

        def to_s
            content = make(@command_name, @node, 1)

            return <<~EOF
                #!/bin/bash
                # shellcheck disable=SC2207
                #{@header ? @header + "\n" : ''}
                #{content}
                complete -o bashdefault -o default -o filenames -F #{@namespace}_#{@command_name} #{@command}
            EOF
        end
    end
end
