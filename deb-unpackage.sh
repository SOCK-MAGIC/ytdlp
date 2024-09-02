#!/bin/bash

# Define an array with the base names of the packages you want to match.
packages=(
    "python"
    "libandroid-support"
    "libffi"
    "zlib"
    "openssl"
    "ca-certificates"
)

# Flag to include "static" packages
include_static=false  # Set to true if you want to include "static" packages

# Variable to store the directory where .deb files are located
deb_dir=""

# Function to display usage information
usage() {
    echo "Usage: $0 [-s] -d <directory>"
    echo "  -s            Include 'static' packages"
    echo "  -d <directory>  Specify the directory where the .deb files are located"
    exit 1
}

# Process command-line arguments
while getopts "sd:" opt; do
    case $opt in
        s)
            include_static=true
            ;;
        d)
            deb_dir="$OPTARG"
            ;;
        \?)
            usage
            ;;
    esac
done

# Check if the deb_dir variable is empty (i.e., the directory wasn't provided)
if [ -z "$deb_dir" ]; then
    echo "Error: Directory not specified."
    usage
fi

# Loop through the array and match the filenames
for package in "${packages[@]}"; do
    if $include_static; then
        # Match both regular and static packages
        pattern="${deb_dir}/${package}*.deb"
    else
        # Match only non-static packages
        pattern="${deb_dir}/${package}[^-static]*.deb"
    fi

    for deb_file in $pattern; do
        if [[ -f $deb_file ]]; then
            echo "Extracting $deb_file"
            dpkg-deb -xv "$deb_file" .
        fi
    done
done