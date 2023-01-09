% GITUP-SUBTAG(1) gitup [VERSION] | Gitup Manual
% Sean Mayo https://github.com/shatteredsword
% [DATE]

# NAME

gitup-subtag - Add, remove, or list local AND remote tags.

# SYNOPSIS

**gitup** *subtag* [\<options\>] \[<TAGNAME\>\]

# DESCRIPTION

Manage tags in your main repo, all remotes, all submodules, and all submodule remotes recursively with the same tag name all at once.

# EXAMPLES

`$ gitup subtag v1.1`

`$ gitup subtag --list`

`$ gitup subtag -d v1.1`

# OPTIONS

`-d, --delete`

: Delete existing tags with the given names.

`-l, --list`

: List tags. Running "gitup subtag" without arguments also lists all tags.

`-h, --help`

: Displays this Manual page.