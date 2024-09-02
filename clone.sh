#!/bin/bash

git clone https://github.com/termux/termux-packages.git
cp ./build-python.sh ./deb-unpackage.sh termux-packages/
cd termux-packages

chmod +x ./build-python.sh
chmod +x ./deb-unpackage.sh

./scripts/run-docker.sh ./clean.sh
./scripts/run-docker.sh ./build-python.sh

cd output/
ls

