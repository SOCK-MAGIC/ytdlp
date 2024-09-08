#!/bin/bash

# Create directories for each architecture if they don't exist
mkdir -p aarch64 arm i686 x86_64

# Move files to their respective directories based on architecture
for arch in aarch64 arm i686 x86_64; do
    # Find and move files that end with the architecture type
    find . -type f -name "*_$arch.deb" -exec mv {} ./$arch/ \;
done

echo "Files have been moved to their respective folders."