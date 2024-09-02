#!/bin/bash

git clone https://github.com/termux/termux-packages.git
cp ./build-python.sh ./deb-unpackage.sh termux-packages/
cd termux-packages

chmod +x ./build-python.sh
chmod +x ./deb-unpackage.sh

./scripts/run-docker.sh ./clean.sh
./scripts/run-docker.sh ./build-python.sh

cd output/
./deb-unpackage.sh -d ./arm

cd data/data/com.termux/files
cp usr/bin/python3.11 /tmp/libpython_arm.so
zip --symlinks -r /tmp/python3_11_arm.zip usr/lib usr/etc

cd /tmp

