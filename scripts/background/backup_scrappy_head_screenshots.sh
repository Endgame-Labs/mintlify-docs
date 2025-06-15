#!/bin/bash

# Backup script for scrappy-head screenshots
# This script zips up everything in the screenshots directory and saves it to Dropbox

SOURCE_DIR="/Users/dorkitude/a/dev/scrappy-head/screenshots"
BACKUP_FILE="/Users/dorkitude/Dropbox/backups/scrappy_head_screenshots.zip"

# Create backup directory if it doesn't exist
mkdir -p "$(dirname "$BACKUP_FILE")"

# Create the zip file (overwriting if it exists)
if [ -d "$SOURCE_DIR" ]; then
    zip -r "$BACKUP_FILE" "$SOURCE_DIR"
    echo "Backup completed: $BACKUP_FILE"
else
    echo "Error: Source directory not found: $SOURCE_DIR"
    exit 1
fi