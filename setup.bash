#!/usr/bin/env bash

menu() {
	if [ "$1" = "global" ]; then
		echo "global installation"
		echo "install to /usr/local/bin"
	else
		echo "local installation"
		echo "install to $HOME/.local/bin"
		echo "test of setup script"
		echo "checking dependencies"
		echo "downloading content"
		echo "installing script"
		echo "installing bash completions"
		echo "reloading environment"
	fi
}

menu $@