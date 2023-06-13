#!/bin/bash

# Destination directory
destination="public_repos"

# Path to the file containing the repository URLs
file="temp/highest_starred.txt"
# file="temp/lowest_starred.txt"

# Check if the destination folder exists, create it if necessary
if [ ! -d "$destination" ]; then
  echo "Destination folder '$destination' not found. Creating it..."
  mkdir "$destination"
fi

# Check if the file exists
if [ ! -f "$file" ]; then
  echo "Repository file '$file' not found."
  exit 1
fi

# Read the repository URLs from the file into an array
repositories=()
while IFS= read -r line || [[ -n "$line" ]]; do
  repositories+=("$line")
done < "$file"

# Loop through the repositories and clone them
for repo in "${repositories[@]}"; do
  # Extract the repository name from the URL
  repo_name=$(basename "$repo" .git)

  # Clone the repository
  echo "Cloning $repo_name..."
  git clone "$repo" "$destination/$repo_name"
done

echo "Cloning complete!"
