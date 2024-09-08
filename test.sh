#!/bin/bash

git clone --depth 1 https://github.com/termux/termux-packages.git
cd termux-packages
./scripts/run-docker.sh ./build-package.sh -a all aria2
