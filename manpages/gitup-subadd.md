% GITUP-SUBADD(1) gitup 1.0.0
% Sean Mayo
% December 2022

# NAME
gitup-subadd - add a submodule and checkout its branch in one command

# SYNOPSIS
**gitup** *subadd* \[<URL\>|-\-help|-h\]

# DESCRIPTION
this command starts by adding a repository via its URL as a submodule to the existing git project. Next, it recursively updates and initializes ALL submodules (even nested ones). Last, it checks out the relevant branch in each submodule cooresponding to the HEAD commit.

# EXAMPLES
$ gitup subadd git@github.com:shatteredsword/testsubmodule1.git

# OPTIONS
**-h**, **\-\-help**
: Displays this Manual page.