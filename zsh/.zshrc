# zsh configuration, Author: Szymon Hankus

platform="$(uname)"
if [[ "$platform" == "Darwin" ]]; then
	# Add homebrew installations and vscode binaries
	export PATH="/opt/homebrew/bin:$PATH"
	export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
fi
export PATH="$HOME/.scripts:$PATH"

# PROMPT (and vcs) setup
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats $'%F{red}(\ue725 %b)%f'
precmd () {
	vcs_info
	[[ ! -z $vcs_info_msg_0_ ]] && vcs_info_msg_0_+=' '
	# prompt on the right (pwd)
	[[ "$(tput cols)" -ge 90 ]] && RPROMPT=$'%F{8}%~%f' # c+8 is bright c (e.g. 0=black => 8=bright black) 
	# add a directory icon if shell was spawned by ranger
	[[ ! -z "$RANGER_LEVEL" ]] && RPROMPT+=$' %F{blue}\ue5ff%f'
}

# Main prompt
setopt PROMPT_SUBST
PROMPT=$'%(?.%F{green}.%F{red})\uf111%f %F{cyan}%1~%f '
PROMPT+='$vcs_info_msg_0_' # add git info

# Bindings
bindkey -e
bindkey '^R' history-incremental-search-backward

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

# less (pager) colors
export LESS=-R
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

