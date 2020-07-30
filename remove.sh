#!/bin/bash
# Remove all the modules installed by setup.sh
# Can use this to test setup.sh

. ~/.devconfig/helpers.sh

# Change package manager prefix for install commands based on OS


pmRemove() {
  if osIsMac; then
    brew remove $@
  else
    sudo DEBIAN_FRONTEND=noninteractive apt-get remove -qq $@ < /dev/null > /dev/null
  fi
}

echo "removing package manager modules..."

echo "vim"
pmRemove vim

echo "tmux"
pmRemove tmux

echo "zsh"
pmRemove zsh

echo "removing oh-my-zsh dir"
rm -rf ~/.oh-my-zsh

echo "removing .vim folder"
rm -rf ~/.vim

echo "removing .zshrc"
rm -f ~/.zshrc

if isWorkMacbook; then
  echo "removing .goog-common-setup.sh"
  rm -f ~/.goog-common-setup.sh
  echo "removing .goog-macbook-setup.sh"
  rm -f ~/.goog-macbook-setup.sh
fi
