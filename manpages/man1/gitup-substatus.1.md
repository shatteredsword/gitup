% GITUP-SUBSTATUS(1) gitup [VERSION] | Gitup Manual
% Sean Mayo https://github.com/shatteredsword
% [DATE]

# NAME

gitup-substatus - Gets the working tree status of the top level repo AND all of its submodules recursively

# SYNOPSIS

**gitup** *substatus* [\<options\>...] [-\-] [\<pathspec\>...]

# DESCRIPTION

this command simply runs git status at the top level, and again (with the same parameters you entered) for each submodule recursively.

# EXAMPLES

`$ gitup substatus -sb`

`$ gitup substatus`

# SEE ALSO

git-status(1)