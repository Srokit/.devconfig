#!/bin/bash
# Remove all the modules installed by setup.sh
# Can use this to test setup.sh

. ~/.devconfig/helpers.sh

# Change package manager prefix for install commands based on OS
if osIsMac; then
  PM=brew
else
  PM=apt
fi

echo "removing package manager modules..."

echo "vim"
"$PM" remove vim

echo "tmux"
"$PM" remove tmux

echo "zsh"
"$PM" remove zsh

echo "removing oh-my-zsh dir"
rm -rf $ZSH

echo "removing .vim folder"
rm -rf ~/.vim

echo "removing .zshrc"
rm ~/.zshrc

if isWorkMacbook; then
  echo "removing .stansgoogrc.sh"
  rm ~/.stansgoogrc
fi
