#!/bin/bash -exu

git clone https://github.com/tkengo/highway.git

cd highway

./tools/build.sh

sudo make install
