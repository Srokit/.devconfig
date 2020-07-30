#!/bin/bash
# Helpers functions used by devconfig scripts

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
  [[ "$(hostname)" = *srok-macbook* ]]
}

isWorkRemote() {
  [[ $(hostname) = *srok.mtv* ]]
}

isPersonalMacbook() {
  [[ $(hostname) = *Stanleys-MBP* ]]
}

inTmuxSession() {
  [[ -n $TMUX ]]
}

inZshSession() {
  [[ $SHELL = *zsh* ]]
}
