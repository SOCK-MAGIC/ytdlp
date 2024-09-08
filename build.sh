#!/bin/bash

git clone https://github.com/termux/termux-packages.git

ls
echo "copy sh file"
cp build-python.sh /termux-packages/
cp move_accordingto_arch.sh /termux-packages/output/
cp deb-unpackage.sh /termux-packages/output/

echo "create dir"
chmod 777 termux-packages
cd termux-packages
ls
mkdir output
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