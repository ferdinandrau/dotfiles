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

install_zsh
