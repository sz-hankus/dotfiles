# zsh configuration, Author: Szymon Hankus

platform="$(uname)"
if [[ "$platform" == "Darwin" ]]; then
	# Add homebrew installations and vscode binaries
	export PATH="/opt/homebrew/bin:$PATH"
	export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
fi
export PATH="$HOME/.scripts:$PATH"

# XDG environment variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.local/cache"
export XDG_STATE_HOME="$HOME/.local/state"

# Source aliases and functions
source "$XDG_CONFIG_HOME"/zsh/aliases.zsh
fpath=( "$XDG_CONFIG_HOME/zsh/functions" $fpath )
autoload -Uz "$XDG_CONFIG_HOME/zsh/functions"/*

# Enable autocompletion
autoload -Uz compinit
compinit

# PROMPT (and vcs) setup
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats $'%F{red}(\ue725 %b)%f'
precmd () {
	vcs_info
	[[ ! -z $vcs_info_msg_0_ ]] && vcs_info_msg_0_+=' '
}

# Main prompt
setopt PROMPT_SUBST
PROMPT=$'%(?.%F{green}.%F{red})\uf111%f %F{cyan}%1~%f '
PROMPT+='$vcs_info_msg_0_' # add git info

# prompt on the right (pwd)
[[ "$(tput cols)" -ge 90 ]] && RPROMPT=$'%F{8}%~%f' # c+8 is bright c (e.g. 0=black => 8=bright black) 
[[ ! -z "$RANGER_LEVEL" ]] && RPROMPT+=$' %F{blue}\ue5ff%f' # add a directory icon if shell was spawned by ranger

# Bindings
bindkey -e
bindkey '^R' history-incremental-search-backward

# Enable editing of the currently typed command in the $EDITOR
autoload edit-command-line
zle -N edit-command-line
bindkey '^XE' edit-command-line
bindkey '^X^E' edit-command-line

# Turn off the annoying beeps
unsetopt BEEP

# PLUGINS
if [[ ! -d "$HOME/.local/share/zsh/zsh-syntax-highlighting" ]]; then
	location="$HOME/.local/share/zsh/zsh-syntax-highlighting"
	mkdir -p "$location"
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$location"
fi
if [[ ! -d "$HOME/.local/share/zsh/zsh-autosuggestions" ]]; then
	location="$HOME/.local/share/zsh/zsh-autosuggestions"
	mkdir -p "$location"
	git clone https://github.com/zsh-users/zsh-autosuggestions.git "$location"
fi

source "$HOME/.local/share/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$HOME/.local/share/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"

# History
HISTSIZE=10000
HIST_STAMPS="yyyy-mm-dd"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# LESS (pager) customization
export LESS='--ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;32m'     # begin blink
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\e[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\e[1;36m'     # begin underline
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline

# Set the EDITOR
# First try check if editor exists and try to set it in the following hierarchy
# nvim => vim => vi
if which nvim &>/dev/null; then
	EDITOR="$(which nvim)"
elif which vim &>/dev/null; then
	EDITOR="$(which vim)"
else
	EDITOR="$(which vi)"
fi
export EDITOR

