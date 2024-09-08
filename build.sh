#!/bin/bash

git clone --depth 1 https://github.com/termux/termux-packages.git && echo "cloned"

cd termux-packages
mkdir output
cd ..

echo "copy sh file"
cp -f build-python.sh -f /termux-packages/
cp -f move_accordingto_arch.sh /termux-packages/output/
cp -f deb-unpackage.sh /termux-packages/output/

echo "create dir"
chmod 777 termux-packages

chmod 777 output

echo "run docker1"
./scripts/run-docker.sh ./clean.sh
echo "run docker2"
./scripts/run-docker.sh ./build-python.sh

echo "move"
cd output
./move_accordingto_arch.sh

echo "unpackage"
./deb-unpackage.sh -d ./aarch64
./deb-unpackage.sh -d ./arm
./deb-unpackage.sh -d ./i686
./deb-unpackage.sh -d ./x86_64

ls
ll