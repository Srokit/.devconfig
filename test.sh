# Remove all the modules installed by setup.sh
. ~/.devconfig/helpers.sh

# Change package manager prefix for install commands based on OS
if osIsMac; then
  PM=brew
else
  # Assume linux
  PM=apt
fi

echo "removing package manager modules..."

echo "vim"
"$PM" remove vim

echo "tmux"
"$PM" remove tmux

echo "zsn"
"$PM" remove zsh

echo "removing oh-my-zsh dir"
rm $ZSH
