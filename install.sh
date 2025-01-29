#!/bin/bash

POSIXLY_CORRECT=1

'unset' '-f' 'unset' 'unalias' 'read' 'declare'
'unalias' '-a'

unset POSIXLY_CORRECT

while read _ _ n; do
    unset -f "$n"
done < <(declare -F)

set -u

script_dir="$(pwd)"
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}"

function install_zsh
{
    ln -s "$script_dir/zsh/.zshenv" "$HOME/."
}

function install_ghostty
{
    mkdir -p "$config_dir/ghostty"
    ln -s "$script_dir/ghostty/config" "$config_dir/ghostty/."
    ln -s "$script_dir/ghostty/themes" "$config_dir/ghostty/."
}

function install_aerospace
{
    mkdir -p "$config_dir/aerospace"
    ln -s "$script_dir/aerospace/aerospace.toml" "$config_dir/aerospace/."
}

install_zsh
install_ghostty
install_aerospace
