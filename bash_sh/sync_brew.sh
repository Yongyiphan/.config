#!/bin/bash

# Define the directory where your Brewfile will be stored
BREWFILE_DIR="$HOME/.config/brew-config"
BREWFILE_PATH="$BREWFILE_DIR/Brewfile"

export_brew(){
	# Navigate to the directory
	mkdir -p $BREWFILE_DIR
	cd $BREWFILE_DIR

	# Dump the current Brew setup into the Brewfile
	brew bundle dump --force --describe --file=$BREWFILE_PATH

	# Check for changes
	if git status --porcelain | grep -q "Brewfile"; then
			# Commit and push changes
			git add $BREWFILE_PATH
			git commit -m "Update Brewfile with latest Homebrew packages"
			git push origin master
	else
			echo "No changes in Homebrew setup."
	fi
}

import_brew(){
	# Ensure you are in the correct directory
	cd $BREWFILE_DIR

	# Install or update packages according to the Brewfile
	brew bundle --file="$BREWFILE_PATH"
}
