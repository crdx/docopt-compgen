# docopt-compgen

**docopt-compgen** is a program that parses [docopt](https://github.com/docopt/docopt.rb) help text and generates shell completions for it.

It uses docopt itself to do the parsing and generates the completions directly from docopt's internal representation.

The only supported shell at the moment is Bash.

## Installation

Install from [rubygems.org](https://rubygems.org/gems/docopt-compgen).

```
gem install docopt-compgen
```

The binary is called `docopt-compgen`.

## Usage

```
Usage:
    docopt-compgen [options] [<command>]

Options:
    --command-name NAME    Command name
                           If not specified then the slugified basename of <command> will be used
    --namespace NAME       Prefix for generated functions [default: cmd]
    -h, --help             Show help
```

## Examples

### Pass a command name to run

If a command name is passed as an argument then it will be run with `--help` and the result will be used as help text.

```bash
docopt-compgen example
```

### Pass in help text via stdin

Input can also be passed in via stdin. The `--command-name` flag is mandatory in that case to specify the command name that should be completed. A future version will extract the command name from the help text itself.

```bash
echo -e "Usage:\n    example --flag" | docopt-compgen --command-name example
```

## Bugs or contributions

Open an [issue](https://github.com/crdx/docopt-compgen/issues) or send a [pull request](https://github.com/crdx/docopt-compgen/pulls).

## Licence

[MIT](LICENCE.md).
