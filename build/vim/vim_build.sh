#!/bin/sh

# エラー用 echo [赤・太字]
function echo_error_ { echo -e "\e[1;31m$*\e[m"; }
function echo_success_ { echo -e "\e[1;32m$*\e[m"; }

sudo yum -y install \
ncurses-devel \
lua-devel \
luajit-devel

git clone https://github.com/vim-jp/vim.git

cd ./vim

./configure \
--enable-luainterp \
--with-luajit \
--enable-fail-if-missing

if [ $? -ne 0 ]; then
  exit 0
fi

make clean
make

if [ $? -ne 0 ]; then
  exit 0
fi

sudo make install

echo_success_ "success to install vim"
