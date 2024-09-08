#!/bin/bash

# Define the path to the original directory
original_dir=$(pwd)

# Define an array of architectures
architectures=("aarch64" "armv7" "x86_64" "i686")

# Clean up the /tmp directory
echo "Cleaning up /tmp directory..."
rm -f /tmp/python3_11_*.zip /tmp/libpython_*.so


# Loop through each architecture
for arch in "${architectures[@]}"; do
    # Create and change to the architecture-specific directory
    mkdir -p "${arch}"
    cd "${arch}" || exit

    # Print the current directory for debugging
    echo "Processing architecture: ${arch}"
    echo "In directory: $(pwd)"

    # Run the deb-unpackage.sh script using the original directory path
    if [ -f "${original_dir}/deb-unpackage.sh" ]; then
        echo "Found deb-unpackage.sh"
        "${original_dir}/deb-unpackage.sh" -d .
    else
        echo "Error: deb-unpackage.sh not found in the original directory"
        exit 1
    fi

    # Copy the Python executable
    cp -r data/data/com.termux/files/usr/bin/python3.11 /tmp/libpython_${arch}.so

    # Create a zip archive
    zip --symlinks -r /tmp/python3_11_${arch}.zip . -i usr/lib usr/etc

    # Create the jniLibs directory if it doesn't exist
    mkdir -p "${original_dir}/jniLibs/${arch}"

    # Move the renamed files to the corresponding jniLibs subfolder
    mv /tmp/python3_11_${arch}.zip "${original_dir}/jniLibs/${arch}/libpython.zip.so"
    mv /tmp/libpython_${arch}.so "${original_dir}/jniLibs/${arch}/libpython.so"

    # Return to the original directory
    cd "${original_dir}" || exit
done
