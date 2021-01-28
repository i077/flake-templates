#! /usr/bin/env bash

for i in *; do
    if [[ -d $i ]]; then
        nix develop $i/ -c echo "test" || exit 1
    fi
done


