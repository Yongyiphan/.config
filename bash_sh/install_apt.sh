#!/bin/bash

error_log(){

	if [ $? -ne 0 ]
	then
			echo "Error: $1 Installation"
	else
			echo "Success: $1 Installation completed successfully."
			rm apt_error.log
	fi
}


g_apt_packages=(
	zip
	nodejs
	npm
)
