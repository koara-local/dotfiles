#!/bin/bash

# Link
DOT_FILES=( \
    .gitconfig \
    .bashrc \
    .vimrc \
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

# [Vim] NeoBundle
if [ ! -d ~/.vim/bundle/neobundle.vim ]; then

    [ ! -d ~/.vim/bundle] && mkdir -p ~/.vim/bundle

    git clone https://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
    if [ $? -ne 0 ]; then
        echo "------------------------------------------------------------------ "
        echo " Install NeoBundle failed."
        echo " Please check .gitconfig.local(proxy setting) or your network settings"
        echo "------------------------------------------------------------------ "
    fi
fi
