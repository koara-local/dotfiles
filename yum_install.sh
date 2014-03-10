#!/bin/bash

PACKAGES=( \
  meld \
  git  \
  gitg \
  tree \
  terminator \
  gcc \
  g++ \
  kernel-devel \
)

for package in ${PACKAGES[@]}
do
  sudo yum install -y $package
done
