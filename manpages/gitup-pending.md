% GITUP-PENDING(1) gitup 1.0.0 | Gitup Manual
% Sean Mayo
% January 2023

# NAME

gitup-pending - Show unpulled and unpushed commits in all submodules, from all remotes.

# SYNOPSIS

**gitup** *pending* [-\-help]

# DESCRIPTION

This command starts by getting a list of remotes and submodules of the repo it is called in. In the top level repo, it iterates through each remote that is found, and gets the name of the HEAD branch in that remote. The command then uses git log to retrieve a list of commits that make up the difference between the local HEAD and the remote. After finishing the main repo, the command then does this entire process again for every submodule and submodule's submodule that it can find.

# OPTIONS

`-h, --help`

: Displays this Manual page.