# aliases for common git commands
alias g='git'
#alias st='git status'
alias push='git push'
#alias commit='git commit'
#alias log='git log'
#alias stash='git stash'
#alias checkout='git checkout'
#alias branch='git branch'
#alias fetch='git fetch'
#alias merge='git merge'
#alias cherry-pick='git cherry-pick'
#alias rebase='git rebase'

# 'git pull' with a short log of the latest changes
pull () { local HEADHASH=`git describe --always --abbrev=40`; git pull $*; git submodule update --init --recursive; echo; PAGER='cat -B' git log --format="%C(yellow)%h %C(green)%an%C(reset): %s" $HEADHASH.. | sed -nr 's/([^:]+)\:/\1\t/;p'; }

# 'git pull --rebase' with a short log of the latest changes
rebase () { local HEADHASH=`git describe --always --abbrev=40`; git pull --rebase $*; git submodule update --init --recursive; echo; PAGER='cat -B' git log --format="%C(yellow)%h %C(green)%an%C(reset): %s" $HEADHASH.. | sed -nr 's/([^:]+)\:/\1\t/;p'; }

# 'git pull --ff-only' with a short log of the latest changes
# 'git pull --ff-only' with a short log of the latest changes
ff () { local HEADHASH=`git describe --always --abbrev=40`; git pull --ff-only $*; echo; PAGER='cat -B' git log --format="%C(yellow)%h %C(green)%an%C(reset): %s" $HEADHASH.. | sed -nr 's/([^:]+)\:/\1\t/;p'; }

# verbose add
add () { git add -v $*; git status; }

# verbose reset
#reset () { git reset $*; git status; }

# 'git add' with 'git ls-files' and grep
# usage like grep - example: gadd 'readme.txt'
gadd () { git ls-files -co --exclude-standard | grep $* | xargs git add -v; git status; }

# 'git reset' with 'git ls-files' and grep
greset () { git ls-files | grep $* | xargs git reset; git status; }

# 'git diff' with 'git ls-files' and grep
gdiff () { git ls-files | grep $* | xargs git diff; }

# 'git rm' with 'git ls-files' and grep
grm () { git ls-files | grep $* | xargs git rm; }

# Enable auto-completion for aliased 'git' command

# no longer working:
# complete -o default -o nospace -F _git g

# Git branch bash completion
# To Setup:
# Save the .git-completion.bash file found here:
#   https://github.com/git/git/blob/master/contrib/completion/git-completion.bash
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
  
  # Add git completion to aliases
  __git_complete g __git_main
fi
