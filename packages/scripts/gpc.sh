#!/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
GPHOME=$(realpath "$SCRIPT_DIR"/..)

. "$GPHOME"/greenplum_path.sh

binary="$1"
shift

"$binary" $@
