#!/usr/bin/env bash
_gitup()
{
	local cur prev
	cur=${COMP_WORDS[COMP_CWORD]}
	prev=${COMP_WORDS[COMP_CWORD-1]}
	case ${COMP_CWORD} in
		1)
			COMPREPLY=($(compgen -W "pending subadd subcheckout subcommit subrm substatus subtag" -- ${cur}))
			;;
		2)
			case ${prev} in
				pending)
					COMPREPLY=($(compgen -W "--help" -- ${cur}))
					;;
				subadd)
					COMPREPLY=($(compgen -W "--help" -- ${cur}))
					;;
				subcheckout)
					local list=$(git branch -l --format='%(refname:short)' | tr '\n' ' ')
					COMPREPLY=($(compgen -W "-b $list" -- ${cur}))
					;;
				subcommit)
					local list=$(git diff --name-only | tr '\n' ' ')
					COMPREPLY=($(compgen -W "$list" -- ${cur}))
					;;
				subrm)
					local list=$(git config --file .gitmodules --get-regexp path | sed 's/.* //' | tr '\n' ' ')
					COMPREPLY=($(compgen -W "$list" -- ${cur}))
					;;
				substatus)
					local list=$(ls -A -p -I .git --color=never)
					COMPREPLY=($(compgen -W "$list" -- ${cur}))
					;;
				subtag)
					local list=$(ls -A -p --color=never)
					COMPREPLY=($(compgen -W "$list" -- ${cur}))
					;;
			esac
			;;
		*)
			COMPREPLY=()
			;;
	esac
}

complete -F _gitup gitup