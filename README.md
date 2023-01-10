# Gitup
a wrapper for git with advanced submodule options

Usage:

`gitup <command> [OPTION]`

# Dependencies

awk\
cat\
curl\
git\
grep\
man\
mandb\
mkdir\
rm\
sed\
tr

# User Installation
```
curl -s https://raw.githubusercontent.com/shatteredsword/gitup/main/setup.bash | bash`
```
or
```
curl -s https://raw.githubusercontent.com/shatteredsword/gitup/main/setup.bash > setup.bash
chmod +x setup.bash
./setup.bash
```
# Global Installation
```
curl -s https://raw.githubusercontent.com/shatteredsword/gitup/main/setup.bash | GITUP_GLOBAL=1 bash
```
or
```
curl -s https://raw.githubusercontent.com/shatteredsword/gitup/main/setup.bash > setup.bash
chmod +x setup.bash
./setup.bash --global
```
# Local Uninstall via Script
```
curl -s https://raw.githubusercontent.com/shatteredsword/gitup/main/setup.bash | GITUP_UNINSTALL=1 bash
```
or
```
curl -s https://raw.githubusercontent.com/shatteredsword/gitup/main/setup.bash > setup.bash
chmod +x setup.bash
./setup.bash --uninstall
rm setup.bash
```

# Global Uninstall via Script
```
curl -s https://raw.githubusercontent.com/shatteredsword/gitup/main/setup.bash | GITUP_GLOBAL=1 GITUP_UNINSTALL=1 bash
```
or
```
curl -s https://raw.githubusercontent.com/shatteredsword/gitup/main/setup.bash > setup.bash
chmod +x setup.bash
./setup.bash --uninstall --global
rm setup.bash
```

# Manual Uninstallation
Binaries:
```
$HOME/.local/bin/gitup
/usr/local/bin/gitup
```
Manpages:
```
$HOME/.local/share/man/*/gitup*.gz
/usr/local/man/*/gitup*.gz
```
Remove this section from the end of $HOME/.profile:
```
##################ENTRIES BETWEEN THESE LINES MANAGED BY GITUP##################
MANPATH="$HOME/.local/share/man:/usr/local/man:/usr/local/share/man:/usr/share/man"
##################ENTRIES BETWEEN THESE LINES MANAGED BY GITUP##################
```


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