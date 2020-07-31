#!/bin/bash

# Exit on error
set -e

. ~/.devconfig/helpers.sh

pmInstall() {
  if osIsMac; then
    brew install $@
  else
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -qq $@ < /dev/null > /dev/null
  fi
}

# Change package manager prefix for install commands based on OS
if osIsMac; then
  echo "Recognized OS as mac"
else
  # Assume linux
  echo "Recognized OS as linux"
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

# Git
pmInstall git

# Vim
rm -rf ~/.vim
ln -s ~/.devconfig/vim ~/.vim

# Vundle for vim plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# Tmux
pmInstall tmux
rm -f ~/.tmux.conf
ln -s ~/.devconfig/tmux.conf ~/.tmux.conf

# ZSH
pmInstall zsh

# Remove workstation doesn't have ability
if ! isWorkRemote; then
  echo "Attempting to change the shell to zsh"
  chsh -s "$(which zsh)"
fi

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


# YCM
# https://github.com/ycm-core/YouCompleteMe

# ONLY SUPPORTED ON WORK REMOTE FOR NOW
if isWorkRemote; then

  # Build prereqs
  pmInstall build-essential cmake vim python3-dev

  # Prereqs
  pmInstall mono-complete nodejs npm

  if ! dirExists ~/.vim/bundle/YouCompleteMe; then
    echo "YouCompleteMe vim plugin not installed yet. Install first."
    exit 1
  fi

  # Compile YCM
  cd ~/.vim/bundle/YouCompleteMe
  python3 install.py --all

  # Install go
  if ! cmdExists go; then
    FN=go1.14.6.linux-amd64.tar.gz
    curl https://dl.google.com/go/$FN -o /tmp/$FN
    sudo tar -C /usr/local -xzf /tmp/$FN
    export PATH=$PATH:/usr/local/go/bin
  fi
fi # isWorkRemote

# Finally install actual npm
