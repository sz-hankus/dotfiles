# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
# if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
#     PATH="$HOME/.local/bin:$HOME/bin:$PATH"
# fi

# Include ~/Scripts in the path
if ! [[ "$PATH" =~ "$HOME/Scripts" ]]; then
	PATH="$HOME/Scripts:$PATH"
fi

export PATH

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

# PROMPT configuration
PS1="[\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;36m\]\W\[\033[00m\]]\$ "

# less (pager) colors
export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;32m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;36m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# Set the EDITOR
# First try check if editor exists and try to set it in the following hierarchy
# nvim => vim => vi
if type nvim &>/dev/null; then
	EDITOR=$(which nvim)
elif type vim &>/dev/null; then
	EDITOR=$(which vim)
else
	EDITOR=$(which vi)
fi
export EDITOR

# fzf keybindings
[ -f /usr/share/fzf/shell/key-bindings.bash ] && source /usr/share/fzf/shell/key-bindings.bash

unset rc
