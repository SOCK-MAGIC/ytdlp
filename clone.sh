#!/bin/bash

git clone https://github.com/termux/termux-packages.git
cp ./build-python.sh termux-packages/
cd termux-packages

./scripts/run-docker.sh ./clean.sh
./scripts/run-docker.sh ./build-python.sh

cd debs/
ls
echo 11111111111111111111
cd data/data/com.termux/files
ls
echo 11111111111111111111
cd usr/bin/
ls

