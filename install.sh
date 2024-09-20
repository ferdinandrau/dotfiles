#!/bin/sh

__rm() {
    rm -Rf "$1" || exit
}

__mkdir() {
    mkdir -p "$1" || exit
}

__cp() {
    cp -R "$1" "$2" || exit
}

__ln() {
    ln -s "$1" "$2" || exit
}

__script_dir="$(pwd)"

__xdg_config_dir="${XDG_CONFIG_HOME:-$HOME/.config}"
__xdg_data_dir="${XDG_DATA_HOME:-$HOME/.local/share}"
__xdg_state_dir="${XDG_STATE_HOME:-$HOME/.local/state}"
__xdg_cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}"

for arg; do
    case "$arg" in
        zsh)
            __rm "$HOME/.zshenv"
            __rm "$__xdg_config_dir/zsh"
            __rm "$__xdg_data_dir/zsh"
            __rm "$__xdg_state_dir/zsh"
            __rm "$__xdg_cache_dir/zsh"
            __mkdir "$__xdg_config_dir/zsh"
            __ln "$__script_dir/zsh/zshenv" "$__xdg_config_dir/zsh/.zshenv"
            __ln "$__script_dir/zsh/zprofile" "$__xdg_config_dir/zsh/.zprofile"
            __ln "$__script_dir/zsh/zshrc" "$__xdg_config_dir/zsh/.zshrc"
            __ln "$__script_dir/zsh/zlogin" "$__xdg_config_dir/zsh/.zlogin"
            __ln "$__script_dir/zsh/functions" "$__xdg_config_dir/zsh/."
            __ln "$__xdg_config_dir/zsh/.zshenv" "$HOME/."
            ;;
        tmux)
            __rm "$HOME/.tmux.conf"
            __rm "$__xdg_config_dir/tmux"
            __mkdir "$__xdg_config_dir/tmux"
            __ln "$__script_dir/tmux/tmux.conf" "$__xdg_config_dir/tmux/."
            ;;
        kitty)
            __rm "$__xdg_config_dir/kitty"
            __rm "$__xdg_cache_dir/kitty"
            __rm "$HOME/Library/Caches/kitty"
            __rm "$HOME/Library/Saved Application State/net.kovidgoyal.kitty.savedState"
            __mkdir "$__xdg_config_dir/kitty"
            __ln "$__script_dir/kitty/kitty.conf" "$__xdg_config_dir/kitty/."
            ;;
        nvim)
            __rm "$__xdg_config_dir/nvim"
            __rm "$__xdg_data_dir/nvim"
            __rm "$__xdg_state_dir/nvim"
            __rm "$__xdg_cache_dir/nvim"
            __mkdir "$__xdg_config_dir/nvim/lua"
            __ln "$__script_dir/nvim/init.lua" "$__xdg_config_dir/nvim/."
            __ln "$__script_dir/nvim/lazy_plugins" "$__xdg_config_dir/nvim/lua/."
            __ln "$__script_dir/nvim/lazy-lock.json" "$__xdg_config_dir/nvim/."
            ;;
    esac
done
