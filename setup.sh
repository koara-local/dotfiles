#!/bin/bash

function echo_error_ { echo -e "\e[1;31m$*\e[m"; }

# [Vim] NeoBundle
if [ ! -d ~/.vim/bundle/neobundle.vim ]; then
    # Check ~/.vim/bundle
    [ ! -d ~/.vim/bundle] && mkdir -p ~/.vim/bundle
    # Install NeoBundle
    git clone https://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
    if [ $? -ne 0 ]; then
        echo_error_ " ----------------------------------------------------------------------- "
        echo_error_ "  Install NeoBundle failed."
        echo_error_ "  Please check .gitconfig.local(proxy setting) or your network settings"
        echo_error_ " ----------------------------------------------------------------------- "
        # Exit shell
        exit 0
    fi
fi

# Link
DOT_FILES=( \
    .vimrc \
    .gitconfig \
    .bashrc \
    .gdbinit \
    .tmux.conf \
)

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done

# Copy
if [ ! -e ~/.gitconfig.local ]; then
    cp $HOME/dotfiles/.gitconfig.local $HOME/.gitconfig.local
fi
