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

findFilenameInCwd() {
  find . -name $@
}

# Initial commands
gitConfGlobAlias co checkout
gitConfGlobAlias st status
gitConfGlobAlias ci checkout
gitConfGlobAlias br checkout
gitConfGlobAlias re rebase

if isWorkMacbook; then
  if ! fileExists ~/.goog-envsetup-macbook.sh; then
    echo "cannot source env vars from ~/.goog-envsetup-macbook.sh.\
No such file exists"
  else
    . ~/.goog-envsetup-macbook.sh
  fi
elif isWorkRemote; then
  if ! fileExists ~/.goog-envsetup-remote.sh; then
    echo "Cannot source env vars from ~/.goog-envsetup-remote.sh.\
No such file exists"
  else
    . ~/.goog-envsetup-remote.sh
  fi
fi

if ! isPersonalMacbook; then
  # macros shared by remote and local workstations
  if ! fileExists ~/.goog-common-setup.sh; then
    echo "Cannot find ~/.goog-common-setup.sh."
    if isWorkMacbook; then
      if scpFromRemoteWork "~/.goog-common-setup.sh" ~; then
        . ~/.goog-common-setup.sh
      fi
    fi
  else
    . ~/.goog-common-setup.sh
  fi
  if isWorkMacbook; then
    if ! fileExists ~/.goog-macbook-setup.sh; then
      echo "Cannot find ~/.goog-macbook-setup.sh"
      # Might keep a copy on the remote for backup
      if scpFromRemoteWork "~/.goog-macbook-setup.sh" ~; then
        . ~/.goog-macbook-setup.sh
      fi
    else
      . ~/.goog-macbook-setup.sh
    fi
  else #isWorkRemote
    if ! fileExists ~/.goog-remote-setup.sh; then
      echo "Cannot find ~/.goog-remote-setup.sh"
    else
      . ~/.goog-remote-setup.sh
    fi
  fi
fi

if isPersonalMacbook && ! inTmuxSession; then
  # automatically start up tmux which will start. The conditional will ensure
  # that we do not enter a loop
  tmux
elif isWorkMacbook && ! inZshSession; then
  # tmux would normall start a nested zsh instance, but if we do not start
  #  that then we must start ourselves here
  zsh
  exit
fi
