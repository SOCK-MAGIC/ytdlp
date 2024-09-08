#!/bin/bash

git clone --depth 1 https://github.com/termux/termux-packages.git
cd termux-packages
./build-package.sh -a all aria2
