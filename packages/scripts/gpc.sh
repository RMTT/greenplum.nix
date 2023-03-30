#!/bin/env bash

usage() {
    echo "usage: gpc {original greenplum command and args}"
    echo "for example: gpc gpstart -a"
}

if [ "$#" -eq "0" ]; then
    usage
    exit 1
fi

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
GPHOME=$(realpath "$SCRIPT_DIR"/..)

. "$GPHOME"/greenplum_path.sh

binary="$1"
shift

"$binary" $@
