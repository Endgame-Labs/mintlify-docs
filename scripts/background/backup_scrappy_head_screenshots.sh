#!/bin/bash

# Backup script for scrappy-head screenshots
# This script zips up everything in the screenshots directory and saves it to Dropbox

SOURCE_DIR="/Users/dorkitude/a/dev/scrappy-head/screenshots"
BACKUP_FILE="/Users/dorkitude/Dropbox/backups/scrappy_head_screenshots.zip"
LOG_FILE="/Users/dorkitude/Dropbox/backups/backup_scrappy_head_screenshots.log"

# Create backup directory if it doesn't exist
mkdir -p "$(dirname "$BACKUP_FILE")"

# Create the zip file (overwriting if it exists)
echo "Starting backup at $(date)" | tee -a "$LOG_FILE"
if [ -d "$SOURCE_DIR" ]; then
    echo "Creating backup: $BACKUP_FILE" | tee -a "$LOG_FILE"
    zip -r "$BACKUP_FILE" "$SOURCE_DIR" 2>&1 | tee -a "$LOG_FILE"
    echo "Backup completed: $BACKUP_FILE" | tee -a "$LOG_FILE"
    # Get backup size in MB
    SIZE=$(du -m "$BACKUP_FILE" | cut -f1)
    echo "Backup size: ${SIZE} MB" | tee -a "$LOG_FILE"
else
    echo "Error: Source directory not found: $SOURCE_DIR" | tee -a "$LOG_FILE"
    exit 1
fi
echo "Backup process completed at $(date)" | tee -a "$LOG_FILE"
echo "----------------------------------------" >> "$LOG_FILE"