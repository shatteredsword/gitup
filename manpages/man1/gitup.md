% GITUP(1) gitup 0.1.0 | Gitup Manual
% Sean Mayo https://github.com/shatteredsword
% January 2023

# NAME

gitup - a wrapper for git with advanced options

# SYNOPSIS

**gitup** [*OPTION*]

**gitup** *PATTERN*

# DESCRIPTION

**gitup** is a bash-based wrapper for git primarily designed to make working with 
submodules and multiple remotes a much more streamlined process.

# GITUP COMMANDS
	
gitup-pending(1)

: Show unpulled and unpushed commits in all submodules, from all remotes.

gitup-subadd(1)

: Add a submodule and checkout its branch in one command.

gitup-subcheckout(1)

: Checkout a specific branch on a top level repo AND all of its submodules recursively.

gitup-subcommit(1)

: Create a commit with a specific message on the top level repo AND all of its submodules recursively.

gitup-subrm(1)

: Remove a submodule and all traces of its existance from your repo.

gitup-substatus(1)

: Gets the working tree status of the top level repo AND all of its submodules recursively.

gitup-subtag(1)

: Add, remove, or list local AND remote tags.

## General options

`-h, --help`

: Displays a friendly help message.