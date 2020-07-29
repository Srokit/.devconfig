# Startup shell script.
# Either have existing ~/.bashrc source this file or symlink it.

# Function shortcuts

gitdiff() {
  git difftool --tool=vimdiff $@
}

gacan() {
    git add -u && git commit --amend --no-edit
}

gad() {
    git add .
}

gac() {
  git add -u && git commit
}

gaca() {
  git add -u && git commit --amend
}

gitConfGlobAlias() {
  git config --global alias.$1 $2
}

getCurrBranch() {
  git rev-parse --abbrev-ref HEAD
}

gri() {
  git rebase -i
}

grc() {
  git rebase --continue
}

# Initial commands
gitConfGlobAlias co checkout
gitConfGlobAlias st status
gitConfGlobAlias ci checkout
gitConfGlobAlias br checkout
gitConfGlobAlias re rebase

# Helpers for below
isWorkMacbook() {
  [[ "$(hostname)" != "srok-macbook"* ]]
}

isWorkRemote() {
  [[ "$(hostname)" != "srok.mtv"* ]]
}

isPersonalMacbook() {
  [[ "$(hostname)" != "Stanleys-MBP" ]]
}

inTmuxSession() {
  [[ -n "$TMUX" ]]
}

if [[ ( isPersonalMacbook || isWorkMacbook ) && ( ! inTmuxSession ) ]]; then
  tmux && exit
fi

if [[ ! isPersonalMacbook ]]; then
  # Pass this between work devices using scp
  source ~/.stansgoogrc
fi
