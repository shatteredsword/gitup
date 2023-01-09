% GITUP-SUBCOMMIT(1) gitup [VERSION] | Gitup Manual
% Sean Mayo https://github.com/shatteredsword
% [DATE]

# NAME

gitup-subcommit - Create a commit with a specific message on the top level repo AND all of its submodules recursively.

# SYNOPSIS

**gitup** *subcommit* [-a | -\-interactive | -\-patch] [-s] [-v] [-u\<mode\>] [-\-amend]\
[-\-dry-run] [(-c | -C | -\-squash) \<commit\> | --fixup [(amend|reword):]\<commit\>)]\
[-F \<file\> | -m \<msg\>] [-\-reset-author] [-\-allow-empty]\
[-\-allow-empty-message] [-\-no-verify] [-e] [-\-author=\<author\>]\
[-\-date=\<date\>] [-\-cleanup=\<mode\>] [--[no-]status]\
[-i | -o] [-\-pathspec-from-file=\<file\> [-\-pathspec-file-nul]]\
[(-\-trailer \<token\>[(=|:)\<value\>])...] [-S[\<keyid\>]]\
[-\-] [\<pathspec\>...]

# DESCRIPTION

This command simply runs git commit at the top level, and again (with the same parameters you entered) for each submodule recursively.

# EXAMPLES

`$ gitup subcommit -S -m "added stuff"`

`$ gitup subcommit`

# SEE ALSO

git-commit(1)