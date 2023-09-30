BIN := 'bundle exec ruby -Ilib bin/docopt-compgen'

[private]
@help:
    just --list --unsorted

# build gem
build:
    bundle exec rake build

# remove built gems
clean:
    rm -vf pkg/*

# build and install the gem globally to the system
install:
    bundle exec rake install

# deploy the gem to rubygems.org
release:
    bundle exec rake release

# run the gem's binary
run +args:
    {{ BIN }} "{{ args }}"

# run linter
lint:
    rubocop

# fix lint errors
fix:
    rubocop -a
