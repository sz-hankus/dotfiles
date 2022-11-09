#!/bin/bash

set -e

yes_no_prompt() {
	read -r -p "Do you wish to continue? [y/n]: " answer
	if ! [[ $answer =~ ^[yY][eE][sS]|[yY]$ ]]
	then
		exit 1
	fi
	echo
}

DOTFILES_PATHS=$(find $PWD \( -name ".*" -o -name "Brewfile" \) -not -name ".DS_Store" -not -name ".gitignore" -not -name ".git" -mindepth 1)
TARGET_DIR='' # where to put the links

if [[ -d $1 ]]
then
	TARGET_DIR="$1"
	echo "Setting $1 as the target directory."
else
	if [[ -z "$1" ]]
	then
		echo "Path not provided. "
	else
		echo "$1 is not a valid path. "
	fi
	
	echo "Setting home ($HOME) as the target directory."

	yes_no_prompt
	
	TARGET_DIR="$HOME"
fi


for path in $DOTFILES_PATHS
do
	FILENAME=$(basename $path)
	TARGET_PATH="$TARGET_DIR/$FILENAME"

	if [[ -h "$TARGET_PATH" || -f "$TARGET_PATH" ]]; then
		echo "$TARGET_PATH already exists. It will be removed."
		yes_no_prompt
		rm $TARGET_PATH
	fi

	echo "linking $path to $TARGET_PATH"
	ln -s $path $TARGET_PATH
	echo
done
