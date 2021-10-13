#!/bin/bash

. ~/.devconfig/helpers.sh

pmInstall() {
  if osIsMac; then
    brew install $@ < /dev/null > /dev/null
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
    echo "homebrew already installed"
  fi
fi

# Python
pmInstall python3

# Git
pmInstall git

# Install neovim
pmInstall neovim
alias vim=nvim

# Vim
rm -rf ~/.vim
ln -s ~/.devconfig/vim ~/.vim

# Nvim config
rm -f ~/.config/nvim/init.vim
mkdir -p ~/.config/nvim/
ln -s ~/.devconfig/nvim_init.vim ~/.config/nvim/init.vim

# VimPlug for vim plugins
if ! fileExists ~/.vim/autoload/plug.vim; then
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

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
