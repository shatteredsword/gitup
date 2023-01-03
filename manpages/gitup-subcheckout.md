% GITUP-SUBCHECKOUT(1) gitup 1.0.0 | Gitup Manual
% Sean Mayo
% January 2023

# NAME

gitup-subcheckout - Checkout a specific branch on a top level repo AND all of its submodules recursively.

# SYNOPSIS

**gitup** *subcheckout* \[-b\] \[<BRANCH\>\]

# DESCRIPTION

Running this command with no arguments will try to find the branch associated with the HEAD commit on a top level repo AND all of its submodules recursively and check that branch out. This means that each submodule may end up checking out a branch of a different name, specific to that submodule. running this command while specifying a branch ignores this smart behavior and simply checks out a branch with the specified name in the top level repo and all of its submodules recursively. Use the -b flag if you want to also create the branch with the specified name.

# EXAMPLES

`$ gitup subcheckout main`

`$ gitup subcheckout -b newbranch`

`$ gitup subcheckout`

# OPTIONS

`-h, --help`

: Displays this Manual page.

`-b`

: Creates a branch and switches to it.