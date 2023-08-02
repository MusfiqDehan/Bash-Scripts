#!/bin/bash

# Function to rename files in the folder
rename_files() {
  for filename in *; do
    if [ "$filename" != "${filename,,}" ]; then
      # Check if the filename contains "Zone.Identifier"
      if [[ "$filename" == *"Zone.Identifier"* ]]; then
        echo "Deleting file: $filename"
        rm "$filename"
      else
        # Convert filename to lowercase and replace spaces with hyphens
        new_filename="${filename,,}"
        new_filename="${new_filename// /-}"
        
        # Check if the new filename already exists
        if [ -e "$new_filename" ]; then
          echo "Skipping renaming, file already exists: $new_filename"
        else
          echo "Renaming $filename to $new_filename"
          mv "$filename" "$new_filename"
        fi
      fi
    fi
  done
}

# Get the current directory
current_dir=$(pwd)

# Navigate to the folder containing the files
cd /path/to/your/folder

# Call the rename_files function
rename_files

# Navigate back to the original directory
cd "$current_dir"

# run script
bash rename_files_script.sh
