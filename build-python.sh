#!/bin/bash

# Define the architectures we want to build for
ARCHITECTURES=("aarch64" "arm" "i686" "x86_64")

# Define the fake user directories
FAKE_USER_PREFIX=/data/youtubedl-android/usr
FAKE_USER_HOME=/data/youtubedl-android/home

# Define the output directory base
OUTPUT_BASE_DIR=$(pwd)/output

# Loop over each architecture and build Python
for ARCH in "${ARCHITECTURES[@]}"; do
    echo "Building Python for architecture: $ARCH"

    # Set the environment variables for the current architecture
    export TERMUX_ARCH=$ARCH
    export TERMUX_PREFIX=$FAKE_USER_PREFIX
    export TERMUX_ANDROID_HOME=$FAKE_USER_HOME

    # Create a separate output folder for each architecture
    OUTPUT_DIR=${OUTPUT_BASE_DIR}/${ARCH}
    mkdir -p $OUTPUT_DIR

    # Run the build script for Python
    ./build-package.sh -a $ARCH -o $OUTPUT_DIR python

    if [ $? -ne 0 ]; then
        echo "Build failed for architecture: $ARCH"
        exit 1
    fi

    # Move files containing the architecture name or "all" to the OUTPUT_DIR
    echo "Moving files for architecture: $ARCH to $OUTPUT_DIR"
    find $OUTPUT_BASE_DIR -maxdepth 1 -type f \( -name "*$ARCH*" -o -name "*all*" \) -exec mv {} $OUTPUT_DIR/ \;

    echo "Build completed for architecture: $ARCH. Output is in $OUTPUT_DIR."
done

echo "Python build completed for all architectures."