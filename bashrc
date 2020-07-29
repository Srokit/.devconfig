# Startup shell script.
# Either have existing ~/.bashrc source this file or symlink it.

# Function shortcuts

gacan() {
    git add -u && git commit --amend --no-edit
}

gad() {
    git add .
}

gitConfGlobAlias() {
  git config --global alias.$1 $2
}

# Initial commands
gitConfGlobAlias co checkout
gitConfGlobAlias st status
gitConfGlobAlias ci checkout
gitConfGlobAlias br checkout
gitConfGlobAlias re rebase
