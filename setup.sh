#!/bin/bash
# Setup.sh

# Log commands as they are run
set -x

# Setup links for config files
rm -rf ~/.vim
ln -s ~/.devconfig/vim ~/.vim
rm -f ~/.bashrc
ln -s ~/.devconfig/bashrc ~/.bashrc
rm -f ~/.tmux.conf
ln -s ~/.devconfig/tmux.conf ~/.tmux.conf

# Change package manager prefix for install commands based on OS
if [[ $OSTYPE == "darwin"* ]]; then
  PM=brew
else
  # Assume linux
  PM=apt
fi

# Get package manger bc Mac might not have brew yet
if [ "$PM" = brew ]; then
  which brew > /dev/null
  if [ "$?" != 0 ]; then
    sudo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" 
  fi
fi

# Tmux install if needed
which tmux
if [ "$?" != 0 ]; then
  sudo "$PM" install tmux
fi

which zsh 
if [ "$?" != 0 ]; then
  sudo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  # Append theme and onto end of generated zshrc
  cat ~/.zshrc ./zsh_theme >> ~/.zshrc
  # Append command to source bashrc
  echo 'source ~/.bashrc' >> ~/.zshrc
fi

sudo chsh -s "$(which zsh)"
