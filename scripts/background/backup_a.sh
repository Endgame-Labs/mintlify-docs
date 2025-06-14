#!/bin/bash

# Backup script for ~/a directory and dotfiles
# Creates timestamped zip files and saves them to ~/Dropbox/backups/
# Keeps only the newest 20 backups

# Define paths
SOURCE_DIR="$HOME/a"
BACKUP_DIR="$HOME/Dropbox/backups"
TIMESTAMP=$(date +"%Y_%m_%d_%H%M_%S")_$(printf "%03d" $((RANDOM % 1000)))
BACKUP_FILENAME="users_dorkitude_a_${TIMESTAMP}.zip"
BACKUP_PATH="${BACKUP_DIR}/${BACKUP_FILENAME}"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Create zip file, excluding /a/dev directory
echo "Creating backup: ${BACKUP_PATH}"
cd "$SOURCE_DIR" || exit 1

# Create zip with exclusions
zip -r -9 "$BACKUP_PATH" . \
    -x "*.DS_Store" \
    -x "__pycache__/*" \
    -x "*.pyc" \
    -x ".git/*" \
    -x "dev/*"

# Check if zip was successful
if [ $? -ne 0 ]; then
    echo "Zip command failed"
    [ -f "$BACKUP_PATH" ] && rm "$BACKUP_PATH"
    exit 1
fi

echo "Zip creation completed successfully"
echo "Backup completed: ${BACKUP_PATH}"

# Get backup size in MB
SIZE=$(du -m "$BACKUP_PATH" | cut -f1)
echo "Backup size: ${SIZE} MB"

# Clean up old backups - keep only newest 20 for ~/a backups
cd "$BACKUP_DIR" || exit 1

# Get all backup files sorted by modification time (newest first)
BACKUP_FILES=($(ls -t users_dorkitude_a_*.zip 2>/dev/null))
TOTAL_FILES=${#BACKUP_FILES[@]}

if [ $TOTAL_FILES -gt 20 ]; then
    # Delete all files beyond the 20 newest
    for ((i=20; i<$TOTAL_FILES; i++)); do
        echo "Removing old backup: ${BACKUP_FILES[$i]}"
        rm "${BACKUP_FILES[$i]}"
    done
fi

# Now backup dotfiles
echo ""
echo "Creating dotfiles backup..."

# Create dotfiles backup
DOTFILES_BACKUP="users_dorkitude_dotfiles_${TIMESTAMP}.zip"
DOTFILES_PATH="${BACKUP_DIR}/${DOTFILES_BACKUP}"

cd "$HOME" || exit 1

# Create list of dotfiles (files only, not directories)
DOTFILES_LIST=""
for f in .[^.]*; do
    if [ -f "$f" ] && [ "$f" != ".DS_Store" ] && [ "$f" != ".CFUserTextEncoding" ] && [ "$f" != ".localized" ]; then
        DOTFILES_LIST="$DOTFILES_LIST $f"
    fi
done

# Create zip with only top-level dotfiles (no subdirectories)
if [ -n "$DOTFILES_LIST" ]; then
    zip -9 "$DOTFILES_PATH" $DOTFILES_LIST 2>/dev/null
else
    echo "No dotfiles found to backup"
    touch "$DOTFILES_PATH"  # Create empty zip
fi

if [ $? -eq 0 ]; then
    echo "Dotfiles backup completed: ${DOTFILES_PATH}"
    SIZE=$(du -m "$DOTFILES_PATH" | cut -f1)
    echo "Dotfiles backup size: ${SIZE} MB"
else
    echo "Warning: Some dotfiles may not have been backed up"
fi

# Clean up old dotfiles backups - keep only newest 20
DOTFILES_BACKUPS=($(ls -t users_dorkitude_dotfiles_*.zip 2>/dev/null))
TOTAL_DOTFILES=${#DOTFILES_BACKUPS[@]}

if [ $TOTAL_DOTFILES -gt 20 ]; then
    for ((i=20; i<$TOTAL_DOTFILES; i++)); do
        echo "Removing old dotfiles backup: ${DOTFILES_BACKUPS[$i]}"
        rm "${DOTFILES_BACKUPS[$i]}"
    done
fi