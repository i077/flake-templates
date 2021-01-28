#! /usr/bin/env bash

failed=()

for i in *; do
    if [[ -d $i ]] && [[ -e $i/flake.nix ]]; then
        nix develop $i/ -c echo "PASSED: $i" || (echo "FAILED: $i" && failed+=($i))
    fi
done

if [[ ${#failed[@]} -eq 0 ]]; then
    echo "all checks passed"
else
    echo "Checks Failed:"
    printf '%s\n' ${failed[@]}
    exit 1
fi

