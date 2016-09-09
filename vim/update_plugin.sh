#!/bin/bash

echo "update vim plugins..."

if [ ! -e ~/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

_plug_add_do() {
    if [[ -p /dev/stdin  ]]; then
        cat -
    else
        echo -n
    fi | sed -e "s/\(^.*$1.*$\)/\1 { 'do' : '$2' }/"
}

_plug_decode() {
    echo "let g:plug_window = ''"
    echo "call plug#begin('~/.vim/bundle')"
    if [[ -p /dev/stdin  ]]; then
        cat -
    else
        echo -n
    fi
    echo "call plug#end()"
}

_pluglist() {
    cat neobundle.toml | grep -P "^repository" | awk '{ print "Plug " $3 }' | \
        _plug_add_do 'Shougo\/vimproc.vim' 'make' | \
        _plug_add_do 'davidhalter\/jedi-vim' 'git submodule update --init --depth=1' | \
        _plug_decode
}

yes | vim -N -u <(_pluglist) -c "try | PlugUpdate | finally | qall! | endtry" 2> /dev/null

echo "success to update!"
