#!/bin/bash -xu

readonly DOTDIR="$(cd $(dirname "${BASH_SOURCE}"); pwd)"

_bash() {
    pushd ${DOTDIR}/bash

    ln -si $(pwd)/bashrc4ubuntu ~/.bashrc

    popd
}

_git() {
    pushd ${DOTDIR}/git

    if [ ! -e ~/.gitconfig ]; then
        # 既存の設定をバックアップ
        mv -v ~/.gitconfig{,_bk}
    fi

    if [ ! -e ~/.gitconfig.local ]; then
        # ローカル設定がなければテンプレート配置
        cp -v $(pwd)/gitconfig.local ~/.gitconfig.local
    fi

    ln -si $(pwd)/gitconfig ~/.gitconfig
    ln -si $(pwd)/gitattributes_global ~/.gitattributes_global

    popd
}

_gdb() {
    pushd ${DOTDIR}/gdb

    ln -si $(pwd)/gdbinit ~/.gdbinit

    popd
}

_tmux() {
    pushd ${DOTDIR}/tmux

    ln -si $(pwd)/tmux.conf ~/.tmux.conf

    popd
}

_zsh() {
    pushd ${DOTDIR}/zsh

    ln -si $(pwd)/zshrc ~/.zshrc

    popd
}

_install() {
    _bash
    _git
    _gdb
    _tmux
    _zsh
}

_install
