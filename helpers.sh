#!/bin/bash
# Helpers functions used by devconfig scripts

if [[ -z "$REMOTE_WORK_HOST" || -z "$REMOTE_WORK_USER" ]]; then
  export REMOTE_WORK_HOST="nomatch"
  export REMOTE_WORK_USER="nomatch"
fi

scpToRemoteWork() {
  echo "Running: scp $1 $REMOTE_WORK_USER@$REMOTE_WORK_HOST:$2"
  scp $1 $REMOTE_WORK_USER@$REMOTE_WORK_HOST:$2
}

scpFromRemoteWork() {
  echo "Running: scp $REMOTE_WORK_USER@$REMOTE_WORK_HOST:$1 $2"
  scp $REMOTE_WORK_USER@$REMOTE_WORK_HOST:$1 $2
}

cmdExists() {
  [[ -n $(which $@) ]]
}

dirExists() {
  [[ -d $1 ]]
}

fileExists() {
  [[ -f $1 ]]
}

osIsMac() {
  [[ $OSTYPE = darwin* ]]
}

isWorkMacbook() {
  [[ $(hostname) = *$REMOTE_WORK_USER-macbook* ]]
}

isWorkRemote() {
  [[ $(hostname) = *$REMOTE_WORK_HOST* ]]
}

isPersonalMacbook() {
  [[ $(hostname) = *Stanleys-MacBook-Pro* ]]
}

inTmuxSession() {
  [[ -n $TMUX ]]
}

inZshSession() {
  [[ $SHELL = *zsh* ]]
}
