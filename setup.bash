#!/usr/bin/env bash

check_dependencies() {
	echo "checking dependencies"
	local is_cat_installed=$(command -v cat)
	if [ "$is_cat_installed" = "" ]; then
		echo "Gitup requires cat as a prerequisite."
		exit 0
	fi
	local is_curl_installed=$(command -v curl)
	if [ "$is_curl_installed" = "" ]; then
		echo "Gitup requires curl as a prerequisite."
		exit 0
	fi
	local is_git_installed=$(command -v git)
	if [ "$is_git_installed" = "" ]; then
		echo "Gitup requires git as a prerequisite."
		echo "see https://git-scm.com/book/en/v2/Getting-Started-Installing-Git"
		exit 0
	fi
	local is_grep_installed=$(command -v grep)
	if [ "$is_grep_installed" = "" ]; then
		echo "Gitup requires grep as a prerequisite."
		echo "see https://www.gnu.org/software/grep/"
		exit 0
	fi
	local is_man_installed=$(command -v man)
	if [ "$is_man_installed" = "" ]; then
		echo "Gitup requires man as a prerequisite."
		exit 0
	fi
	local is_mandb_installed=$(command -v mandb)
	if [ "$is_mandb_installed" = "" ]; then
		echo "Gitup requires mandb as a prerequisite."
		exit 0
	fi
	local is_mkdir_installed=$(command -v mkdir)
	if [ "$is_mkdir_installed" = "" ]; then
		echo "Gitup requires mkdir as a prerequisite."
		exit 0
	fi
	local is_rm_installed=$(command -v rm)
	if [ "$is_rm_installed" = "" ]; then
		echo "Gitup requires rm as a prerequisite."
		exit 0
	fi
	local is_sed_installed=$(command -v sed)
	if [ "$is_sed_installed" = "" ]; then
		echo "Gitup requires sed as a prerequisite."
		echo "see https://sed.sourceforge.io/#download"
		exit 0
	fi
	echo "all dependencies met"
}

global_install() {
	check_dependencies
	echo "running global installation"
	sudo mkdir -p /usr/local/bin
	echo "installing gitup to /usr/local/bin"
	local temp_file=$(mktemp)
	curl -s https://raw.githubusercontent.com/shatteredsword/gitup/main/gitup > $temp_file
	sudo chown root:root $temp_file
	sudo chmod 755 $temp_file
	sudo mv $temp_file /usr/local/bin/gitup
	echo "installing manpages"
	echo "TODO"
	echo "installing bash completions"
	echo "TODO"
}

global_uninstall() {
	echo "removing global install of gitup"
	echo "removing /usr/local/bin/gitup"
	sudo rm /usr/local/bin/gitup
	echo "removing bash completions"
	echo "TODO"
	echo "please log out and back in to remove any residual shell references"
}

local_install() {
	check_dependencies
	echo "running local installation"
	mkdir -p $HOME/.local/bin
	echo "installing gitup to \$HOME/.local/bin"
	curl -s https://raw.githubusercontent.com/shatteredsword/gitup/main/gitup > $HOME/.local/bin/gitup
	chmod +x $HOME/.local/bin/gitup
	echo "installing manpages"
	echo "TODO"
	echo "installing bash completions"
	if [ -f "$HOME/.profile" ]; then
		echo "reloading environment"
		source $HOME/.profile
	fi
}

local_uninstall() {
	echo "removing local install of gitup"
	echo "removing \$HOME/.local/bin/gitup"
	rm $HOME/.local/bin/gitup
	echo "removing bash completions"
	echo "TODO"
	if [ -f "$HOME/.profile" ]; then
		echo "reloading environment"
		source $HOME/.profile
	fi
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
					sed -i "s/[DATE]/${current_date}/" "$f"
					sed -i "s/[VERSION]/${gitup_version}/" "$f"
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
			-H "Accept: application/vnd.github+json" 
			-H "Authorization: Bearer $2" \
			-H "X-GitHub-Api-Version: 2022-11-28" \
			-H "Content-Type: application/x-gtar" \
			https://uploads.github.com/repos/shatteredsword/gitup/releases/$release_id/assets?name=manpages.tar.gz
			)
		fi
	else
		local_install
	fi
}

menu $@