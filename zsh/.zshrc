# +---------+
# | Options |
# +---------+

setopt ALWAYS_TO_END
setopt AUTO_CD
setopt GLOB_DOTS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt LIST_ROWS_FIRST
setopt MENU_COMPLETE
setopt NO_BEEP
setopt PROMPT_SUBST

# +------+
# | Mode |
# +------+

bindkey -e

# +---------+
# | History |
# +---------+

HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
HISTSIZE=3000
SAVEHIST=3000

# +------------+
# | Completion |
# +------------+

autoload -U compinit && compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compdump"

zstyle ':completion:*' menu select
zstyle ':completion:*' completer _extensions _expand_alias _complete _approximate
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' complete-options true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compcache"

# +--------+
# | Prompt |
# +--------+

autoload -U colors && colors

PROMPT='(%F{blue}%n%f in %F{cyan}%~%f) %F{green}%#%f '

autoload -Uz vcs_info

precmd() {
    vcs_info
}

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '(%F{magenta}%b%f)'

RPROMPT='${vcs_info_msg_0_}'

# +-------------+
# | Environment |
# +-------------+

[[ -x /opt/homebrew/bin/brew ]] &&
    eval "$(/opt/homebrew/bin/brew shellenv)"

[[ "$(command -v nvim)" ]] &>/dev/null &&
    export VISUAL=nvim

# +---------+
# | Aliases |
# +---------+

if [[ "$(command -v exa)" ]] &>/dev/null; then
    alias ls=exa
    alias la='exa -a'
    alias ll='exa -la'
else
    alias la='ls -A'
    alias ll='ls -lA'
fi

# +---------+
# | Plugins |
# +---------+

[[ "$(command -v git)" ]] &>/dev/null || exit

root="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins"
timestamp=$(date +%s)

function use_plugin() {
    local dir="$root/${1//[:.\/]/_}"
    local name=${1:t}
    if ! [[ -d "$dir/repo" ]]; then
        git clone --depth 1 $1 "$dir/repo" || return
        echo $timestamp >"$dir/store"
        use_plugin $1
    else
        local store
        read -r store <"$dir/store"
        if ((timestamp - store > 864000)); then
            git -C "$dir/repo" pull || return
            echo $timestamp >"$dir/store"
        fi
    fi
    [[ -f "$dir/repo/$name.plugin.zsh" ]] &&
        source "$dir/repo/$name.plugin.zsh"
}

use_plugin 'https://github.com/zsh-users/zsh-autosuggestions'
use_plugin 'https://github.com/zsh-users/zsh-syntax-highlighting'
use_plugin 'https://github.com/zsh-users/zsh-history-substring-search'

bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

unfunction use_plugin

unset root
unset timestamp
