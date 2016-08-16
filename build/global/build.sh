#!/bin/bash -xeu

if [ ! -d global ]; then
    wget http://tamacom.com/global/global-6.5.4.tar.gz -O global.tar.gz
fi

tar xvf global.tar.gz

cd global-6.5.4/

sudo apt-get install cscope libncurses5-dev

./configure && make

sudo make install

cp gtags.vim ../

cd ../

cp gtags.vim ~/.vim/autoload/
