#!/bin/bash

# エラー用 echo [赤・太字]
function echo_error_ { echo -e "\e[1;31m$*\e[m"; }
function echo_success_ { echo -e "\e[1;32m$*\e[m"; }

# Link
DOT_FILES=( \
    vim \
    vimrc \
)

for file in ${DOT_FILES[@]}
do
  if [ ! -e ~/.${file} ]; then
    ln -s $(pwd)/${file} ~/.${file}
  fi
done

./update_plugin.sh

if [ ! -e ~/.clang_complete ]; then
    cp clang_complete_template ~/.clang_complete
fi

if [ ! -e ~/.vimrc.local ]; then
    cp vimrc.local.template ~/.vimrc.local
fi

echo_success_ "success to setup"
