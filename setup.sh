#!/bin/bash

# エラー用 echo [赤・太字]
function echo_error_ { echo -e "\e[1;31m$*\e[m"; }

# Git
if [ ! -e ~/.gitconfig ]; then
    # 既存の設定をバックアップ
    mv -v $HOME/.gitconfig $HOME/.gitconfig~
fi

if [ ! -e ~/.gitconfig.local ]; then
    # ローカル設定がなければテンプレート配置
    cp -v $HOME/dotfiles/.gitconfig.local $HOME/.gitconfig.local
fi

# Link
DOT_FILES=( \
    gitconfig \
    gitattributes_global \
    bashrc \
    zshrc  \
    gdbinit \
    tmux.conf \
)

for file in ${DOT_FILES[@]}
do
    ln -si ${HOME}/dotfiles/${file} ${HOME}/.${file}
done
