#!/bin/bash

# {{{

CURRENT=$($(cd $(dirname $0)) && pwd)

function link() {
  SRC=$1
  DEST=$2
  if [ $# == 1 ]; then
    DEST=$1
  fi
  ln -snf "$CURRENT/$SRC" $HOME/$DEST
}

# }}}

link '.vimrc'
link '.gvimrc'
link '.vim'
link '.config/nvim' '.config/nvim'

link '.ideavimrc'

link '.tmux.conf'

link '.bashrc'
link '.zshrc'

link '.inputrc'

link '.gitconfig'
link '.gitignore-global', '.gitignore'

link '.eslintrc.json'
