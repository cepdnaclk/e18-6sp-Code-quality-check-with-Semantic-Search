#!/bin/bash

# Directory containing Python files
directory="python_files"

# Output file to store the score
output_file="score.txt"

# Directory for high-quality code
high_quality_dir="HighQualityCodes"

# Directory for low-quality code
low_quality_dir="LowQualityCodes"

# Directory for not-rated code
null_values_dir="NullRatedCodes"

# Remove the existing score file if it exists
if [ -f "$output_file" ]; then
    rm "$output_file"
fi

# Create the high-quality code directory if it doesn't exist
if [ ! -d "$high_quality_dir" ]; then
    mkdir "$high_quality_dir"
fi

# Create the low-quality code directory if it doesn't exist
if [ ! -d "$low_quality_dir" ]; then
    mkdir "$low_quality_dir"
fi

# Create the not-rated code directory if it doesn't exist
if [ ! -d "$null_values_dir" ]; then
    mkdir "$null_values_dir"
fi

# Iterate over Python files in the directory
for file in "$directory"/*.py; do
    echo "Processing file: $file"

    # Run pylint on each file and store the output in a temporary file
    pylint --disable=import-error "$file" > temp_output.txt

    # Extract the score from the output using grep and store it in the output file
    score=$(grep -oE '[0-9]+\.[0-9]' temp_output.txt | head -n 1)
    # echo "Score = $score"

    echo "$score" >> "$output_file"

    # Check the score and move the file to the appropriate directory
    if [[ -z "$score" ]]; then
        mv "$file" "$null_values_dir"
    elif (( $(echo "$score > 8.0" | bc -l) )); then
        mv "$file" "$high_quality_dir"
    elif (( $(echo "$score < 2.0" | bc -l) )); then
        mv "$file" "$low_quality_dir"
    fi

    # Remove the temporary output file
    rm temp_output.txt
done
