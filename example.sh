#!/bin/sh

BIN=$(cabal exec -- which hs-base64-decode-lines)

test -e "${BIN}" || exec sh -c '
    echo binary "${BIN}" missing
    exit 1
'

test -f "${BIN}" || exec sh -c '
    echo binary "${BIN}" is not a file
    exit 1
'

test -x "${BIN}" || exec sh -c '
    echo binary "${BIN}" is not an executable
    exit 1
'

printf '%s\n' \
    helo \
    wrld |
    while read line; do
        echo "${line}" | base64
    done |
    "${BIN}"
