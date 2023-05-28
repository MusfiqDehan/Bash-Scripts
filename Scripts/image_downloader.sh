#!/bin/bash

# User inputs
read -p "Enter Unsplash API access key: " access_key
read -p "Enter search tag: " search_tag
read -p "Enter image size (format: <width>x<height>): " size
read -p "Enter destination folder name: " destination
read -p "Enter the number of images to download: " img_count

# Validating user inputs
if [[ -z $access_key ]]; then
  echo "Error: Access key is required."
  exit 1
fi

if ! [[ $img_count =~ ^[1-9][0-9]*$ ]]; then
  echo "Error: Image count must be a positive integer."
  exit 1
fi

# Create destination folders if they don't exist
mkdir -p "$destination/raw"
mkdir -p "$destination/resized"

# Make API request to Unsplash
response=$(curl -s "https://api.unsplash.com/photos/random?client_id=$access_key&count=$img_count&query=$search_tag")

# Download, resize, and rename images
cd "$destination/raw" || exit
for ((count = 1; count <= img_count; count++)); do
  url=$(echo "$response" | jq -r ".[$((count - 1))].urls.raw")
  filename="raw$count.jpg"
  wget -O "$filename" "$url"
done

cd ../resized || exit
for ((count = 1; count <= img_count; count++)); do
  file="../raw/raw$count.jpg"
  if [[ -f $file ]]; then
    filename="resized$count.jpg"
    convert "$file" -resize "$size^" -gravity center -crop "$size+0+0" "$filename"
  fi
done

echo "Image downloading and resizing completed. Raw images are stored in '$destination/raw' folder, and resized images are stored in '$destination/resized' folder."

