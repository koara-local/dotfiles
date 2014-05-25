#!/bin/bash

# エラー用 echo [赤・太字]
function echo_error_ { echo -e "\e[1;31m$*\e[m"; }
function echo_success_ { echo -e "\e[1;32m$*\e[m"; }

sudo apt-get build-dep vim
sudo apt-get install \
python-dev \
lua5.2 \
liblua5.2-dev \
luajit \
libluajit-5.1

git clone https://github.com/vim-jp/vim.git

cd ./vim

./configure \
--enable-pythoninterp \
--with-python-config-dir=/usr/lib/python2.7/config \
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
