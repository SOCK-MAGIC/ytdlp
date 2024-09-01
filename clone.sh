#!/bin/bash

chmod +x ./build-python.sh

git clone https://github.com/termux/termux-packages.git
cd termux-packages

./scripts/run-docker.sh ./clean.sh
./scripts/run-docker.sh ../build-python.sh

cd data/data/com.termux/files
ls

cd usr/bin/python3.11
ls