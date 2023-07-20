#!/bin/bash

#Install Brew
if ! command -v brew &> /dev/null
then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> $HOME/.profile
		eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
#Install Brew Packages
brew_packages=(
	neovim
	gcc
	fd
	fzf
	tmux
	lazygit
	ripgrep
	python
	pipenv
	jesseduffield/lazygit/lazygit
	gh
	navi
)

brew update
brew install "${brew_packages[@]}" 2>brew_error.log

if [ $? -ne 0 ]
then
    echo "Error with brew package installation"
else
    echo "Success: Brew package Installation completed successfully."
    rm brew_error.log
fi
