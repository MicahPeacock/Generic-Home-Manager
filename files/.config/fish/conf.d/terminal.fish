if test -z "$XDG_CONFIG_HOME"
    set -gx XDG_CONFIG_HOME "$HOME/.config"
end

if test -z "$XDG_DATA_HOME"
    set -gx XDG_DATA_HOME "$HOME/.local/share"
end

if test -z "$XDG_DATA_DIRS"
    set -gx XDG_DATA_DIRS "$XDG_DATA_HOME:/usr/local/share:/usr/share"
end

if test -z "$XDG_STATE_HOME"
    set -gx XDG_STATE_HOME "$HOME/.local/state"
end

if test -z "$XDG_CACHE_HOME"
    set -gx XDG_CACHE_HOME "$HOME/.cache"
end

if test -z "$XDG_DESKTOP_DIR"
    set -gx XDG_DESKTOP_DIR "$HOME/Desktop"
end

if test -z "$XDG_DOWNLOAD_DIR"
    set -gx XDG_DOWNLOAD_DIR "$HOME/Downloads"
end

if test -z "$XDG_TEMPLATES_DIR"
    set -gx XDG_TEMPLATES_DIR "$HOME/Templates"
end

if test -z "$XDG_PUBLICSHARE_DIR"
    set -gx XDG_PUBLICSHARE_DIR "$HOME/Public"
end

if test -z "$XDG_DOCUMENTS_DIR"
    set -gx XDG_DOCUMENTS_DIR "$HOME/Documents"
end

if test -z "$XDG_MUSIC_DIR"
    set -gx XDG_MUSIC_DIR "$HOME/Music"
end

if test -z "$XDG_PICTURES_DIR"
    set -gx XDG_PICTURES_DIR "$HOME/Pictures"
end

if test -z "$XDG_VIDEOS_DIR"
    set -gx XDG_VIDEOS_DIR "$HOME/Videos"
end

set -gx PATH $HOME/.local/bin:$PATH


if type -q starship
    starship init fish | source
    set -gx STARSHIP_CACHE $XDG_CACHE_HOME/starship
    set -gx STARSHIP_CONFIG $XDG_CONFIG_HOME/starship/starship.toml
end


if type -q duf
    function df -d "Run duf with last argument if valid, else run duf"
    if set -q argv[-1] && test -e $argv[-1]
        duf $argv[-1]
    else
        duf
    end
end
end

set fish_pager_color_prefix cyan
set fish_color_autosuggestion brblack

# List Directory
alias c='clear'
alias l='eza -lh --icons=auto'
alias ls='eza -1 --icons=auto'
alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
alias ld='eza -lhD --icons=auto'
alias lt='eza --icons=auto --tree'
alias fastfetch='fastfetch --logo-type kitty'

# Directory navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

alias vc='code'

abbr mkdir 'mkdir -p'

set -g fish_greeting
