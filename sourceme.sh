#!/bin/bash

. ~/.devconfig/helpers.sh

# Source this file for shortcuts in the shell of your choice

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

if isWorkMacbook; then
  if ! fileExists ~/.setupworkmacbook.sh; then
    echo "cannot source env vars from ~/.setupworkmacbook.sh.\
No such file exists"
  else
    . ~/.setupworkmacbook.sh
  fi
elif isWorkRemote; then
  if ! fileExists ~/.setupworkremote.sh; then
    echo "Cannot source env vars from ~/.setupworkremote.sh.\
No such file exists"
  else
    . ~/.setupworkremote.sh
  fi
fi

if ! isPersonalMacbook; then
  # macros shared by remote and local workstations
  if ! fileExists ~/.goog-common-setup.sh; then
    echo "Cannot find ~/.goog-common-setup.sh."
    if isWorkMacbook; then
      scpFromRemoteWork "~/.goog-common-setup.sh" ~
      . ~/.goog-common-setup.sh
    fi
  else
    . ~/.goog-common-setup.sh
  fi
  if isWorkMacbook; then
    echo "Cannot find ~/.goog-macbook-setup.sh"
    if ! fileExists ~/.goog-macbook-setup.sh; then
      # Might keep a copy on the remote for backup
      scpFromRemoteWork "~/.goog-macbook-setup.sh" ~
      . ~/.goog-macbook-setup.sh
    else
      . ~/.goog-macbook-setup.sh
    fi
  else #isWorkRemote
    if ! fileExists ~/.goog-remote-setup.sh; then
      echo "Cannot find ~/.goog-remote-setup.sh"
    fi
  fi
fi

if ! isWorkRemote && ! inTmuxSession; then
  # automatically start up tmux which will start. The conditional will ensure
  # that we do not enter a loop
  tmux
fi
