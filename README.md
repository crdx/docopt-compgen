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
    -o, --out PATH         Output completion to PATH instead of stdout
    --complete-short       Complete short options (long options are always completed)
    --command-name NAME    Command name
                           If not specified then the slugified basename of <command> will be used
    --namespace NAME       Prefix for generated bash functions [default: cmd]
    --header TEXT          Header to insert at the start of the completion script
    -v, --version          Show version
    -h, --help             Show help
```

## Examples

### Pass a command name to run

If a command name is passed as an argument then it will be run with `--help` and the result will be used as help text.

```bash
docopt-compgen example
```

### Pass in help text via stdin

Input can also be passed in via stdin.

```bash
echo -e "Usage:\n    example --flag" | docopt-compgen
```

The name of the command will be extracted from the help text but can be overridden with `--command-name` if desired.

## Contributions

Open an [issue](https://github.com/crdx/docopt-compgen/issues) or send a [pull request](https://github.com/crdx/docopt-compgen/pulls).

## Licence

[GPLv3](LICENCE).
