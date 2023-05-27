organize_files() {
  echo "Enter directory path to organize:"
  read directory
  echo "Organizing files in $directory ..."
  
  # Create the necessary folders
  mkdir -p "$directory/images" "$directory/text" "$directory/documents" "$directory/other"
  
  # Move files to the appropriate folders
  find "$directory" -type f -iname "*.jpg" -exec mv {} "$directory/images/" \;
  find "$directory" -type f -iname "*.png" -exec mv {} "$directory/images/" \;
  find "$directory" -type f -iname "*.txt" -exec mv {} "$directory/text/" \;
  find "$directory" -type f -iname "*.pdf" -exec mv {} "$directory/documents/" \;
  find "$directory" -type f -iname "*.docx" -exec mv {} "$directory/documents/" \;
  find "$directory" -type f -iname "*.xlsx" -exec mv {} "$directory/documents/" \;
  find "$directory" -type f -iname "*.pptx" -exec mv {} "$directory/documents/" \;
  find "$directory" -type f ! \
    -iname "*.jpg" \
    -o -iname "*.png" \
    -o -iname "*.txt" \
    -o -iname "*.pdf"\
    -o -iname "*.docx"\
    -o -iname "*.xlsx"\
    -o -iname "*.pptx" \
    -exec mv {} "$directory/other/" \;
  
  echo "Files organized successfully!"
}

restore_files() {
  echo "Enter directory path to restore:"
  read directory
  echo "Restoring files in $directory ..."
  
  # Move files from the organized folders back to their original locations
  find "$directory/images" -type f -iname "*.jpg" -exec mv {} "$directory/" \;
  find "$directory/images" -type f -iname "*.png" -exec mv {} "$directory/" \;
  find "$directory/text" -type f -iname "*.txt" -exec mv {} "$directory/" \;
  find "$directory/documents" -type f -iname "*.pdf" -exec mv {} "$directory/" \;
  find "$directory/documents" -type f -iname "*.docx" -exec mv {} "$directory/" \;
  find "$directory/documents" -type f -iname "*.xlsx" -exec mv {} "$directory/" \;
  find "$directory/documents" -type f -iname "*.pptx" -exec mv {} "$directory/" \;
  
  # Move files from the "other" folder back to their original locations
  find "$directory/other" -type f -exec mv {} "$directory/" \;
  
  echo "Files restored successfully!"
}

print_menu() {
  echo "Select an option:"
  echo "1. Organize files"
  echo "2. Restore files"
  echo "3. Quit"
}

while true; do
  print_menu
  read -p "Enter your choice: " choice
  
  case $choice in
    1) organize_files ;;
    2) restore_files ;;
    3) break ;;
    *) echo "Invalid choice. Please try again." ;;
  esac
  
  echo
done

