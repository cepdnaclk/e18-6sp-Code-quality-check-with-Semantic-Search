import os
import pandas as pd

def read_file(filename):
    with open(filename, 'r') as file:
        content = file.read()
    return content

def read_directory(directory):
    file_contents = []
    for filename in os.listdir(directory):
        if filename.endswith('.py'):
            file_path = os.path.join(directory, filename)
            content = read_file(file_path)
            file_contents.append(content)
    return file_contents

def create_csv(file_contents, labels, output_file):
    df = pd.DataFrame({'Code': file_contents, 'Label': labels})
    df.to_csv(output_file, index=False)

low_quality_dir = 'LowQualityCode'  # Directory path for low-quality code files
high_quality_dir = 'HighQualityCode'  # Directory path for high-quality code files

low_quality_contents = read_directory(low_quality_dir)
high_quality_contents = read_directory(high_quality_dir)

low_quality_labels = ['0'] * len(low_quality_contents)
high_quality_labels = ['1'] * len(high_quality_contents)

file_contents = low_quality_contents + high_quality_contents
labels = low_quality_labels + high_quality_labels

output_file = 'code_samples.csv'  # Name of the output CSV file

create_csv(file_contents, labels, output_file)

print("CSV file created successfully.")
