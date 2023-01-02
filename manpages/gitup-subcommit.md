% GITUP-SUBCOMMIT(1) gitup 1.0.0
% Sean Mayo
% January 2023

# NAME
gitup-subcommit - create a commit with a specific message on the top level repo AND all of its submodules recursively

# SYNOPSIS
**gitup** *subcommit* [-a | -\-interactive | -\-patch] [-s] [-v] [-u\<mode\>] [-\-amend]\
[-\-dry-run] [(-c | -C | -\-squash) \<commit\> | --fixup [(amend|reword):]\<commit\>)]\
[-F \<file\> | -m \<msg\>] [-\-reset-author] [-\-allow-empty]\
[-\-allow-empty-message] [-\-no-verify] [-e] [-\-author=\<author\>]\
[-\-date=\<date\>] [-\-cleanup=\<mode\>] [--[no-]status]\
[-i | -o] [-\-pathspec-from-file=\<file\> [-\-pathspec-file-nul]]\
[(-\-trailer \<token\>[(=|:)\<value\>])...] [-S[\<keyid\>]]\
[-\-] [\<pathspec\>...]\

# DESCRIPTION
this command simply runs git commit at the top level, and again (with the same parameters you entered) for each submodule recursively.

# EXAMPLES
$ gitup subcommit -S -m "added stuff"\
$ gitup subcommit\

# SEE ALSO
git-commit(1)