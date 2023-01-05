# Gitup
a wrapper for git with advanced submodule options

Usage:

`gitup <command> [OPTION]`

# User Installation
`curl -s https://raw.githubusercontent.com/shatteredsword/gitup/main/setup.bash | bash`

# Global Installation
`curl -s https://raw.githubusercontent.com/shatteredsword/gitup/main/setup.bash | bash global`

# Description

gitup is a bash-based wrapper for git primarily designed to make working with 
submodules and multiple remotes a much more streamlined process.

# Recommended Git Config

submodule.recurse=true

submodule.propagatebranches=true

push.autosetupremote=true

push.recursesubmodules=on-demand

status.submodulesummary=true

# Gitup Commands
	
**gitup pending** - Show unpulled and unpushed commits in all submodules, from all remotes.

**gitup subadd** - Add a submodule and checkout its branch in one command.

**gitup-subcheckout** - Checkout a specific branch on a top level repo AND all of its submodules recursively.

**gitup subcommit** - Create a commit with a specific message on the top level repo AND all of its submodules recursively.

**gitup subrm** - Remove a submodule and all traces of its existance from your repo.

**gitup substatus** - Gets the working tree status of the top level repo AND all of its submodules recursively.

**gitup subtag** - Add, remove, or list local AND remote tags.