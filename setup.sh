#!/bin/bash

# Exit on error
set -e

. ~/.devconfig/helpers.sh

# Change package manager prefix for install commands based on OS
if osIsMac; then
  echo "Recognized OS as mac"
  PM=brew
else
  # Assume linux
  echo "Recognized OS as linux"
  PM=apt
fi

# package manager (NOTE: cannot install linux apt)
if osIsMac; then
  # homebrew needs access to these files
  sudo chown -R $(whoami) /usr/local/bin /usr/local/etc /usr/local/sbin\
    /usr/local/share /usr/local/share/doc
  chmod u+w /usr/local/bin /usr/local/etc /usr/local/sbin /usr/local/share\
    /usr/local/share/doc
  if ! cmdExists brew; then
    echo "installing homebrew"
    /bin/sh -c \
      "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" 
  else
    echo "homebrew already installed, upgrading..."
    brew upgrade
  fi
fi

# Vim
if ! cmdExists vim; then
  echo "installing vim"
  "$PM" install vim
else
  echo "vim already installed"
fi
rm -rf ~/.vim
ln -s ~/.devconfig/vim ~/.vim

# Tmux
if ! cmdExists tmux; then
  echo "installing tmux"
  "$PM" install tmux
else
  echo "tmux already good"
fi
rm -f ~/.tmux.conf
ln -s ~/.devconfig/tmux.conf ~/.tmux.conf

# ZSH
if ! cmdExists zsh; then
  echo "installing zsh"
  "$PM" install zsh
else
  echo "zsh already installed"
fi
echo "Attempting to change the shell to zsh"
chsh -s "$(which zsh)"

# OhMyZsh
if ! dirExists ~/.oh-my-zsh; then
  echo "installing oh-my-zsh"
  # insert n to say no to setting zsh as default
  echo 'n' | /bin/sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "oh-my-zsh already installed"
fi
rm -f ~/.zshrc
ln -s ~/.devconfig/zshrc ~/.zshrc
