#!/bin/bash
# use i686 for x86
export TERMUX_ARCH=arm
export TERMUX_PREFIX=/data/youtubedl-android/usr
export TERMUX_ANDROID_HOME=/data/youtubedl-android/home
./build-package.sh python