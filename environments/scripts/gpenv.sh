#!/usr/bin/env bash

program_name=$(basename $0)
subcommand=$1

if [ -z "$stdenv" ]; then
    echo "Please use ${program_name} in 'nix develop'."
    exit 1
fi

# source stdenv to use it's functons
export NIX_BUILD_TOP=$(pwd)/build
source $stdenv/setup

help() {
    echo "Usage: ${program_name} [subcommand] [options]"
}

sub_phase() {
    local name=$1
    "$name"Phase
}

sub_hook() {
    local name=$1
    runHook $name
}

case "$subcommand" in
    "" | "-h" | "--help")
        help
        ;;
    *)
        shift
        sub_${subcommand} $@
        if [ $? = 127 ]; then
            echo "Error: '$subcommand' is not a known subcommand." >&2
            echo "Run '$program_name --help' for a list of known subcommands." >&2
            exit 1
        fi
        ;;
esac
