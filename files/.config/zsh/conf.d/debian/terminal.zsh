#!/usr/bin/env zsh

function _load_functions() {
    # Load all custom function files // Directories are ignored
    for file in "${ZDOTDIR:-$HOME/.config/zsh}/functions/"*.zsh; do
        [ -r "$file" ] && source "$file"
    done
}

function _load_completions() {
    for file in "${ZDOTDIR:-$HOME/.config/zsh}/completions/"*.zsh; do
        [ -r "$file" ] && source "$file"
    done
}

function _dedup_zsh_plugins {
    unset -f _dedup_zsh_plugins
    zsh_paths=(
        "$HOME/.oh-my-zsh"
        "/usr/local/share/oh-my-zsh"
        "/usr/share/oh-my-zsh"
    )
    for zsh_path in "${zsh_paths[@]}"; do [[ -d $zsh_path ]] && export ZSH=$zsh_path && break; done
    zsh_plugins=(git zsh-256color zsh-autosuggestions zsh-syntax-highlighting)
    plugins+=("${plugins[@]}" "${zsh_plugins[@]}")
    plugins=("${plugins[@]}")
    plugins=($(printf "%s\n" "${plugins[@]}" | sort -u))
    typeset -g DEFER_OMZ_LOAD=1
}

function _defer_omz_after_prompt_before_input() {
    [[ -r $ZSH/oh-my-zsh.sh ]] && source $ZSH/oh-my-zsh.sh

    fpath=($ZDOTDIR/completions "${fpath[@]}")

    _load_compinit
    _load_functions
    _load_completions

    if typeset -f _zsh_autosuggest_start >/dev/null; then
        _zsh_autosuggest_start
    fi

    chmod +r $ZDOTDIR/.zshrc
    [[ -r $ZDOTDIR/.zshrc ]] && source $ZDOTDIR/.zshrc
}

function _load_deferred_plugin_system_by_debian() {
    if [[ -n $DEFER_OMZ_LOAD ]]; then
        unset DEFER_OMZ_LOAD
        [[ ${VSCODE_INJECTION} == 1 ]] || chmod -r $ZDOTDIR/.zshrc
        zle -N zle-line-init _defer_omz_after_prompt_before_input
    fi
    
    if typeset -f _zsh_autosuggest_start >/dev/null; then
        _zsh_autosuggest_start
    fi

    bindkey '\e[H' beginning-of-line
    bindkey '\e[F' end-of-line

}

function do_render {
    local type="${1:-image}"
    TERMINAL_IMAGE_SUPPORT=(kitty konsole ghostty WezTerm)
    local terminal_no_art=(vscode code codium)
    TERMINAL_NO_ART="${TERMINAL_NO_ART:-${terminal_no_art[@]}}"
    CURRENT_TERMINAL="${TERM_PROGRAM:-$(ps -o comm= -p $(ps -o ppid= -p $$))}"

    case "${type}" in
    image)
        if [[ " ${TERMINAL_IMAGE_SUPPORT[@]} " =~ " ${CURRENT_TERMINAL} " ]]; then
            return 0
        else
            return 1
        fi
        ;;
    art)
        if [[ " ${TERMINAL_NO_ART[@]} " =~ " ${CURRENT_TERMINAL} " ]]; then
            return 1
        else
            return 0
        fi
        ;;
    *)
        return 1
        ;;
    esac
}

function _load_compinit() {
    autoload -Uz compinit

    setopt EXTENDED_GLOB

    if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+${ZSH_COMPINIT_CHECK:-1}) ]]; then
        compinit
    else
        compinit -C
    fi

    _comp_options+=(globdots) # tab complete hidden files
}

function _load_prompt() {
    # Try to load prompts immediately
    if ! source ${ZDOTDIR}/prompt.zsh >/dev/null 2>&1; then
        [[ -f $ZDOTDIR/conf.d/debian/prompt.zsh ]] && source $ZDOTDIR/conf.d/debian/prompt.zsh
    fi
}

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# # History configuration
HISTFILE=${HISTFILE:-$ZDOTDIR/.zsh_history}
if [[ -f $HOME/.zsh_history ]] && [[ ! -f $HISTFILE ]]; then
    echo "Please manually move $HOME/.zsh_history to $HISTFILE"
    echo "Or move it somewhere else to avoid conflicts"
fi
HISTSIZE=10000
SAVEHIST=10000


export HISTFILE ZSH_AUTOSUGGEST_STRATEGY HISTSIZE SAVEHIST

if [[ $- == *i* ]]; then
    if command -v fastfetch >/dev/null; then
        if do_render "image"; then
            fastfetch --logo-type kitty
        fi
    fi
fi

_load_compinit
_dedup_zsh_plugins
if [[ "$ZSH_OMZ_DEFER" == "1" ]] && [[ -r $ZSH/oh-my-zsh.sh ]]; then
    _load_deferred_plugin_system_by_debian
    _load_prompt
elif [[ -r $ZSH/oh-my-zsh.sh ]]; then
    source $ZSH/oh-my-zsh.sh
    _load_prompt
    _load_functions
    _load_completions
fi

alias c='clear' \
    fastfetch='fastfetch --logo-type kitty' \
    ..='cd ..' \
    ...='cd ../..' \
    .3='cd ../../..' \
    .4='cd ../../../..' \
    .5='cd ../../../../..' \
    mkdir='mkdir -p'
    

