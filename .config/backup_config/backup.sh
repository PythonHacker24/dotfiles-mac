#!/bin/bash
#  __  __                      _      _    
# |  \/  | __ ___   _____ _ __(_) ___| | __
# | |\/| |/ _` \ \ / / _ \ '__| |/ __| |/ /
# | |  | | (_| |\ V /  __/ |  | | (__|   < 
# |_|  |_|\__,_| \_/ \___|_|  |_|\___|_|\_\

# Backup Script by Aditya Patil 
# Note: Provide absolute paths to the directories

# Backup folder with git initialised and remote repository setup
backup_folder="/Users/adityapatil/backup_space"

# Clear buffer cache option (yes/no)
clear_buffer_option="yes"

# Function to display program generated messages
display_message() {
  echo 
  echo "$1" 
  echo
}

# Checking for .git files in the buffer directory
if [ -d "$backup_folder/.git" ]; then 
  display_message "[+] Git found, continuing to backup"
else 
  display_message "[-] .git file not found, exiting"
  exit 1 
fi

# Directories to backup
declare -a directories=(
  [0]="/Users/adityapatil/.config/nvim"
  [1]="/Users/adityapatil/.config/zsh-plugins"
  [2]="/Users/adityapatil/.tmux/plugins"

)

# Files to backup
declare -a files=(
  [0]="/Users/adityapatil/.zshrc"
  [1]="/Users/adityapatil/.tmux.conf"
)

declare -a exclusion_files=(
  [0]=".git"
  [1]="README.md"
  [2]="banner.png"
)

# Function to check if a file is in the exclusion list
is_excluded() {
  local file="$1"
  for excluded in "${exclusion_files[@]}"; do
    if [[ "$excluded" == "$file" ]]; then
      return 0  # file is excluded
    fi
  done
  return 1  # file is not excluded
}

# Function to find and delete .git files in the given directory
delete_git_directories() {
  find "$1" -type d -name ".git" -exec rm -rf {} +
}

# Copying directories to the backup buffer directory
for directory in ${directories[@]}; do 
  cp -r "$directory" "$backup_folder" 
done

# Removing .git files from the directories in the backup budder directory
# for directory in ${directories[@]}; do 
#   delete_git_directories "$backup_folder"
# done

# Copying files to the backup buffer directory
for file in ${files[@]}; do 
  cp "$file" "$backup_folder" 
done

# Pushing to the Remote Git Repository
cd "$backup_folder" 
git add .
git commit -m "Latest Backup"
git push -u origin main 
git push
display_message "Pushed!"

# Deleting buffer directory cache
if [ "$clear_buffer_option" == "yes" ]; then 
  display_message "[+] Deleting Cache .... "
  
  for file in "$backup_folder"/*; do
    filename=$(basename "$file")
    if ! is_excluded "$filename"; then
      rm -rf "$file"
    fi  
  done

  display_message "[+] Cache Cleared"
fi

display_message "[+] Exiting Backup Phase"
