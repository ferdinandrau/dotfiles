#!/bin/sh

script_dir="$(pwd)"

for arg; do
    case "$arg" in
        zsh)
            ln -s "$script_dir/zsh/.zshenv" "$HOME/."
            ;;
        *)
            echo "skipping '$arg'"
            ;;
    esac
done
