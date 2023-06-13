#!/bin/bash

folder_path="$1"
destination_dir="$2"

# Create destination directory if it doesn't exist
mkdir -p "$destination_dir"

# Recursively find .py files and copy them to the destination directory
find "$folder_path" -name "*.py" -type f -exec cp {} "$destination_dir" \;