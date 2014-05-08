#!/bin/sh

# エラー用 echo [赤・太字]
function echo_error_ { echo -e "\e[1;31m$*\e[m"; }
function echo_success_ { echo -e "\e[1;32m$*\e[m"; }

sudo yum -y install \
ncurses-libs \
ncurses-devel \
gnome-libs-devel \
libgnomeui-devel \
gtk2-devel \
libbonoboui-devel \
libX11-devel \
libXpm-devel \
libXt-devel \
perl-ExtUtils-Embed \
python-devel \
python3-devel \
ruby-devel \
lua-devel \
luajit-devel \
cairo-devel

git clone https://github.com/vim-jp/vim.git

cd ./vim

./configure \
--with-features=huge \
--enable-gui=gnome2 \
--enable-pythoninterp \
--enable-python3interp \
--enable-rubyinterp \
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
