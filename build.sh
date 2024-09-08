#!/bin/bash

git clone --depth 1 https://github.com/termux/termux-packages.git && echo "cloned"

echo "create dir"
chmod 777 termux-packages
cd termux-packages
mkdir output
chmod 777 output
cd ..

echo "copy sh file"
cp ./build-python.sh -f termux-packages/
cp ./move_accordingto_arch.sh termux-packages/output/
cp ./deb-unpackage.sh termux-packages/output/

cd termux-packages

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

cp aarch64/data/data/com.termux/files/usr/bin/python3.11 /tmp/libpython_aarch64.so
zip --symlinks -r /tmp/python3_11_aarch64.zip usr/lib usr/etc

cp arm/data/data/com.termux/files/usr/bin/python3.11 /tmp/libpython_arm.so
zip --symlinks -r /tmp/python3_11_arm.zip usr/lib usr/etc

cp i686/data/data/com.termux/files/usr/bin/python3.11 /tmp/libpython_i686.so
zip --symlinks -r /tmp/python3_11_i686.zip usr/lib usr/etc

cp x86_64/data/data/com.termux/files/usr/bin/python3.11 /tmp/libpython_x86_64.so
zip --symlinks -r /tmp/python3_11_x86_64.zip usr/lib usr/etc
