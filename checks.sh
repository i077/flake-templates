#! /usr/bin/env bash

failed=()

for i in *; do
    if [[ -d $i ]] && [[ -e $i/flake.nix ]]; then
        echo "testing $i"
        nix develop $i/ -c echo "PASSED: $i" || echo "FAILED: $i" && failed+=($i)
    fi
done

[[ ${#failed[@]} -eq 0 ]] || (echo "Checks Failed:" && printf '%s\n' ${failed[@]} && exit 1)
