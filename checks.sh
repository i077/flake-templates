#! /usr/bin/env bash

for i in *; do
    if [[ -d $i ]] && [[ -e $i/flake.nix ]]; then
        echo "testing $i"
        nix develop $i/ -c echo "ok" || FAILED=true
    fi
done

$FAILED && exit 1
