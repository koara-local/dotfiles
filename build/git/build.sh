#!/bin/bash -xeu

if [ ! -d git-master ]; then
  wget https://github.com/git/git/archive/master.zip
  unzip master.zip
fi

cd git-master/

make prefix=/usr/local all
sudo make prefix=/usr/local install
