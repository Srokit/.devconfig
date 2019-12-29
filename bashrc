# Startup shell script.
# Either have existing ~/.bashrc source this file or symlink it.

# Environemnt variables

# TODO: Fill in

# Function shortcuts

gacan() {
    git add -u && git commit --amend --no-edit
}

gad() {
    git add .
}

# Startup commands below

# always work in tmux session
tmux

# exit whole terminal session after tmux exits
exit
