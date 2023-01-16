#!/usr/bin/env bash

#any time gitup needs to add to a user's bash profile loading script, the code
#will be wrapped in between 2 copies of the $ENV_STRING
ENV_STRING="##################ENTRIES BETWEEN THESE LINES MANAGED BY GITUP##################"

check_dependencies() {
	echo "checking dependencies"
	#add any new command line dependencies to this array
	local deps=(cat git grep man mandb mkdir rm sed tr wget)
	for i in "${deps[@]}"; do
		if ! command -v "$i" &> /dev/null; then
			echo "Gitup requires $i as a prerequisite."
			exit 0
		fi
	done
	echo "all dependencies met"
}

global_install() {
	echo "running global installation"
	sudo mkdir -p /usr/local/bin
	local temp_file=$(mktemp)
	echo "downloading latest version of gitup"
	wget -q https://raw.githubusercontent.com/shatteredsword/gitup/main/gitup -O $temp_file
	echo "setting file ownership for gitup"
	sudo chown root:root $temp_file
	echo "setting file permissions for gitup"
	sudo chmod 755 $temp_file
	echo "installing gitup to /usr/local/bin"
	sudo mv $temp_file /usr/local/bin/gitup
	local temp_file=$(mktemp)
	echo "downloading manpages tarball"
	wget -q https://github.com/shatteredsword/gitup/releases/latest/download/manpages.tar.gz -O $temp_file
	echo "installing manpages to /usr/local/man"
	tar -xf $temp_file -C /usr/local/man
	echo "regenerating manpages database"
	sudo mandb
	sudo mkdir -p /usr/local/share/bash-completion/completions
	local temp_file=$(mktemp)
	echo "downloading latest version of bash completions"
	wget -q https://raw.githubusercontent.com/shatteredsword/gitup/main/gitup-completion.bash -O $temp_file
	echo "setting file ownership for bash completions"
	sudo chown root:root $temp_file
	echo "setting file permissions for bash completions"
	sudo chmod 755 $temp_file
	echo "installing bash completions to /usr/local/share/bash-completion/completions/gitup-completion.bash"
	sudo mv $temp_file /usr/local/share/bash-completion/completions/gitup-completion.bash
	local temp_file=$(mktemp)
	echo "downloading latest version of bash completions source script"
	wget -q https://raw.githubusercontent.com/shatteredsword/gitup/main/source-gitup-completion.sh -O $temp_file
	echo "setting file ownership for bash completions source script"
	sudo chown root:root $temp_file
	echo "setting file ownership for bash completions source script"
	sudo chmod 755 $temp_file
	echo "installing bash completions source script to /etc/profile.d/source-gitup-completion.sh"
	sudo mv $temp_file /etc/profile.d/source-gitup-completion.sh
	echo "please log out and back in to finish installation"
	exit 0
}

global_uninstall() {
	echo "removing global install of gitup"
	echo "removing /usr/local/bin/gitup"
	sudo rm -f /usr/local/bin/gitup
	echo "removing manpages from /usr/local/man"
	sudo rm -f /usr/local/man/*/gitup*.gz
	echo "regenerating manpages database"
	sudo mandb
	echo "removing bash completions from /usr/local/share"
	sudo rm -f /usr/local/share/bash-completion/completions/gitup-completion.bash
	echo "removing bash completions source script from /etc/profile.d"
	sudo rm -f /etc/profile.d/source-gitup-completion.sh
	echo "please log out and back in to remove any residual shell references"
	exit 0
}

local_install() {
	echo "running local installation"
	mkdir -p $HOME/.local/bin
	echo "installing gitup to \$HOME/.local/bin"
	wget -q https://raw.githubusercontent.com/shatteredsword/gitup/main/gitup -O $HOME/.local/bin/gitup
	chmod +x $HOME/.local/bin/gitup
	echo "downloading manpages tarball"
	local temp_file=$(mktemp)
	wget -q https://github.com/shatteredsword/gitup/releases/latest/download/manpages.tar.gz -O $temp_file
	mkdir -p $HOME/.local/share/man
	echo "installing manpages to $HOME/.local/share/man"
	tar -xf $temp_file -C $HOME/.local/share/man
	local envs=(.bashrc .profile .bash_login .bash_profile)
	for i in "${envs[@]}"; do
		if [ -f "$HOME/$i" ]; then
			if grep -q -F "$ENV_STRING" "$HOME/$i"; then
				echo "gitup wasn't properly uninstalled last time. run ./setup.bash --uninstall and rerun this script"
				exit 0
			else
				local env_file="$HOME/$i"
			fi
		fi
	done
	if ! [ "$env_file" ]; then
		echo "setup could not find a login shell profile"
		exit 126
	else
		echo "installing login shell hook to $env_file"
		cat <<- EOF >> $env_file
				$ENV_STRING
				MANPATH="\$HOME/.local/share/man:/usr/local/man:/usr/local/share/man:/usr/share/man"
				source \$HOME/.local/share/bash-completion/completions/gitup-completion.bash
		$ENV_STRING
		EOF
	fi
	echo "regenerating manpages database"
	mandb -csp
	echo "installing bash completions"
	mkdir -p $HOME/.local/share/bash-completion/completions
	echo "installing bash completions to $HOME/.local/share/bash-completion/completions/gitup-completion.bash"
	wget -q https://raw.githubusercontent.com/shatteredsword/gitup/main/gitup-completion.bash -O $HOME/.local/share/bash-completion/completions/gitup-completion.bash
	echo "please log out and back in to finish installation"
	exit 0
}

local_uninstall() {
	echo "removing local install of gitup"
	echo "removing $HOME/.local/bin/gitup"
	rm -f $HOME/.local/bin/gitup
	echo "removing manpages from $HOME/.local/share/man"
	[ -e "$HOME/.local/share/man/*/gitup*.gz" ] && rm $HOME/.local/share/man/*/gitup*.gz
	echo "checking login profiles for manpath"
	echo "removing manpath and bash completions from .bash_profile"
	[ -e "$HOME/.bash_profile" ] && sed -i "/$ENV_STRING/,/$ENV_STRING/d" $HOME/.bash_profile
	echo "removing manpath and bash completions from .bash_login"
	[ -e "$HOME/.bash_login" ] && sed -i "/$ENV_STRING/,/$ENV_STRING/d" $HOME/.bash_login
	echo "removing manpath and bash completions from .profile"
	[ -e "$HOME/.profile" ] && sed -i "/$ENV_STRING/,/$ENV_STRING/d" $HOME/.profile
	echo "removing manpath and bash completions from .bashrc"
	[ -e "$HOME/.bashrc" ] && sed -i "/$ENV_STRING/,/$ENV_STRING/d" $HOME/.bashrc
	echo "regenerating manpages database"
	mandb -cs
	echo "removing bash completions from $HOME/.local/share/bash-completion/completions/gitup-completion.bash"
	rm -f $HOME/.local/share/bash-completion/completions/gitup-completion.bash
	echo "please log out and back in to remove any residual shell references"
	exit 0
}

sudo_prompt() {
	if [ "$GITUP_GLOBAL" != "1" ] && [ "$GITUP_UNINSTALL" != "1" ]; then
		read -p "this option requires sudo permissions, would you like to continue? y/n " RESPONSE
		if [ "$RESPONSE" != "y" ] && [ "$RESPONSE" != "Y" ]; then
			echo "exiting script..."
			exit 0
		fi
	fi
}

menu() {
	if [ "$1" = "--global" ] || [ "$GITUP_GLOBAL" = "1" ]; then
		if [ "$2" = "--uninstall" ] || [ "$GITUP_UNINSTALL" = "1" ]; then
			echo "global uninstall"
			sudo_prompt
			global_uninstall
		else
			echo "global installation"
			sudo_prompt
			check_dependencies
			global_install
		fi
	elif [ "$1" = "--uninstall" ] || [ "$GITUP_UNINSTALL" = "1" ]; then
		if [ "$2" = "--global" ]; then
			echo "global uninstall"
			sudo_prompt
			global_uninstall
		else
			local_uninstall
		fi
	elif [ "$1" = "--generate-release" ]; then
		local gitup_version=$(./gitup --version | sed 's/gitup version /v/')
		echo "version: $gitup_version"
		local latest_tag=$(git describe --tags --abbrev=0)
		echo "latest_tag: $latest_tag"
		if [ "$gitup_version" != "$latest_tag" ]; then
			git config --global user.name "Release Bot"
			git config --global user.email "kq2t7uxqp@mozmail.com"
			git tag "$gitup_version"
			git push origin "$gitup_version"
			local current_date=$(date "+%B %Y")
			sudo apt update
			local is_pandoc_installed=$(command -v pandoc)
			if [ "$is_pandoc_installed" = "" ]; then
				sudo apt install -y pandoc
			fi
			local is_jq_installed=$(command -v jq)
			if [ "$is_jq_installed" = "" ]; then
				sudo apt install -y jq
			fi
			cd manpages
			declare -a dirs
			i=1
			for d in */; do
				dirs[i++]="${d%/}"
			done
			for j in "${dirs[@]}"; do
				echo $j
				for f in $j/*.md; do
					sed -i "s/\[DATE\]/${current_date}/" "$f"
					sed -i "s/\[VERSION\]/${gitup_version}/" "$f"
					local base
					base=${f%.md}
					echo "generating $base from $f"
					pandoc "$f" -s -t man -o "$base"
					echo "zipping $base"
					gzip -f "$base"
				done
			done
			tar -czf manpages.tar.gz **/*.gz
			tar -tvf manpages.tar.gz
			local release_description=$(git log -1 --pretty=%B | cat)
			local release_response=$(
			curl -X POST \
			-H "Accept: application/vnd.github+json" \
			-H "Authorization: Bearer $2" \
			-H "X-GitHub-Api-Version: 2022-11-28" \
			https://api.github.com/repos/shatteredsword/gitup/releases \
			-d '{"tag_name":"'"$gitup_version"'","target_commitish":"main","name":"'"$gitup_version"'","body":"'"$release_description"'","draft":false,"prerelease":false,"generate_release_notes":false}'
			)
			release_id=$(echo "$release_response" | jq '.id')
			
			local asset_response=$(
			curl -X POST \
			--data-binary @manpages.tar.gz \
			-H "Accept: application/vnd.github+json" \
			-H "Authorization: Bearer $2" \
			-H "X-GitHub-Api-Version: 2022-11-28" \
			-H "Content-Type: application/x-gtar" \
			"https://uploads.github.com/repos/shatteredsword/gitup/releases/$release_id/assets?name=manpages.tar.gz"
			)
		fi
	elif [ "$1" = "" ] || [ "$1" = "--install" ]; then
		check_dependencies
		if [ "$2" = "--global" ]; then
			global_install
		else
			local_install
		fi
	else
		echo "$1 is not a recognized option"
	fi
}

menu $@