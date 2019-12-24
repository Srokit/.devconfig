# Configuration for dev work. 

Rename .devconfig and placing under home dir.

## Setup

Running setup.sh will create both of the symlinks mentioned below.
Warning: The ~/.bashrc and ~/.vim directories will be deleted if
they already exist before running the script.

## Vim

$ ln -s ./.vim ~/.vim

## Bash

$ ln -s ./.bashrc ~/.bashrc

or

In ~/.bashrc...
source ~/.devconfig/.bashrc
