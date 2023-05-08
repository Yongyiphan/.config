#!/bin/bash
#Test1
#Sudo update
sudo apt-get update -y
#Sudo upgrade
sudo apt-get upgrade -y
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

#Install Sudo apt packages
apt_packages=(
	zip
)

sudo apt-get install -y "${apt_packages[@]}" 2> apt_error.log

c_process="General apt-get"

if [ $? -ne 0 ]
then
    echo "Error: $c_process Installation"
else
    echo "Success: $c_process Installation completed successfully."
    rm apt_error.log
fi

cpp_packages=(
	build-essential 
	gcc
	g++
	clang
	valgrind
	doxygen 
	graphviz
)

sudo apt-get install -y "${cpp_packages[@]}" 2> cpp_error.log
c_process="CPP"
if [ $? -ne 0 ]
then
    echo "Error: $c_process Installation"
else
    echo "Success: $c_process Installation completed successfully."
    rm cpp_error.log
fi

sudo add-apt-repository ppa:deadsnakes/ppa
python_packages=(
	python3.8
	python3-pip
	python3.8-venv
)

pip3_packages=(
	virtualenv
)

sudo apt-get install -y "${python_packages[@]}" 2> python_error.log

c_process="Python apt-get"
if [ $? -ne 0 ]
then
    echo "Error: $c_process Installation"
else
    echo "Success: $c_process Installation completed successfully."
		pip3 install "${pip3_packages[@]}" 2>pip3_error.log
		c_process="Pip3"
		if [ $? -ne 0 ]
		then
				echo "Error: $c_process Installation"
		else
				echo "Success: $c_process Installation completed successfully."
				rm pip3_error.log
		fi
    rm python_error.log
fi

#Adding to .bashrc
#reroute bash.aliases	
reroute_aliases="if [ -f ~/.config/.bash_aliases ]; then\n    . ~/.config/.bash_aliases\nfi"
echo -e "$reroute_aliases" >> ~/.bashrc
source ~/.bashrc
echo "Updated bashrc"
