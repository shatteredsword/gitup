#!/usr/bin/env bash

global_install() {
	echo "global install"
	echo "install to /usr/local/bin"
}

global_uninstall() {
	echo "removing global install of gitup"
}

local_install() {
	echo "local installation"
	echo "install to $HOME/.local/bin"
	echo "test of setup script"
	echo "checking dependencies"
	echo "downloading content"
	echo "installing script"
	echo "installing bash completions"
	echo "reloading environment"
}

local_uninstall() {
	echo "local uninstall"
}

sudo_prompt() {
	if [ "$GITUP_GLOBAL" = "1" ] || [ "$GITUP_UNINSTALL" = "1" ]; then
		SUDO_ACCEPTED=1
	else
		read -p "this option requires sudo permissions, would you like to continue? y/n " RESPONSE
		if [ "$RESPONSE" = "y" ] || [ "$RESPONSE" = "Y" ]; then
			SUDO_ACCEPTED=1
		else
			echo "exiting script..."
			exit 0
		fi
	fi
}

menu() {
	SUDO_ACCEPTED=0
	if [ "$1" = "--global" ] || [ "$GITUP_GLOBAL" = "1" ]; then
		if [ "$2" = "--uninstall" ] || [ "$GITUP_UNINSTALL" = "1" ]; then
			echo "global uninstall"
			sudo_prompt
			if [ $SUDO_ACCEPTED = "1" ]; then
				global_uninstall
			else
				exit 0
			fi
		else
			echo "global installation"
			sudo_prompt
			if [ $SUDO_ACCEPTED = "1" ]; then
				global_install
			else
				exit 0
			fi
		fi
	elif [ "$1" = "--uninstall" ] || [ "$GITUP_UNINSTALL" = "1" ]; then
		if [ "$2" = "--global" ]; then
			echo "global uninstall"
			sudo_prompt
			if [ $SUDO_ACCEPTED = "1" ]; then
				global_uninstall
			else
				exit 0
			fi
		else
			local_uninstall
		fi
	else
		local_install
	fi
}

menu $@