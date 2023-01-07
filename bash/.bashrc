# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
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

# Include ~/Scripts in the path
PATH="$PATH:$HOME/Scripts"
export PATH

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

unset rc
