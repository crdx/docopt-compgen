set quiet := true
set shell := ["bash", "-cu", "-o", "pipefail"]

BIN := 'bundle exec ruby -Ilib bin/docopt-compgen'

import? 'local.just'

[private]
help:
    just --list --unsorted

init:
    bundle install

build:
    bundle exec rake build

clean:
    rm -vf pkg/*

install:
    bundle exec rake install

run +args:
    {{ BIN }} {{ args }}

lint:
    rubocop

fix:
    rubocop -A

fmt:
    echo 'Nothing to format'
