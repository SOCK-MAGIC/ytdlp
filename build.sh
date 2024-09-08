#!/bin/bash

git clone --depth 1 https://github.com/termux/termux-packages.git

cp build-python /termux-packages
cp move_accordingto_arch.sh /termux-packages/output
cp deb-unpackage.sh /termux-packages/output

chmod 777 termux-packages
cd termux-packages
mkdir output
chmod 777 output

./scripts/run-docker.sh ./clean.sh
./scripts/run-docker.sh ./build-python.sh

cd output
./move_accordingto_arch.sh

./deb-unpackage.sh -d ./aarch64
./deb-unpackage.sh -d ./arm
./deb-unpackage.sh -d ./i686
./deb-unpackage.sh -d ./x86_64

ls
ll