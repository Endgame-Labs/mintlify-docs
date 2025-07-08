#!/bin/bash

# MongoDB Daily Backup Script
# Keeps only the 2 most recent backups in ~/Dropbox/backups

# Set backup directory
BACKUP_DIR="$HOME/Dropbox/backups"
TIMESTAMP=$(date +%Y_%m_%d_%H%M)
BACKUP_NAME="${TIMESTAMP}_mongodb"

# Create backup
echo "Starting MongoDB backup at $(date)"
/opt/homebrew/bin/mongodump --out "$BACKUP_DIR/$BACKUP_NAME"

# Check if backup was successful
if [ $? -eq 0 ]; then
    echo "Backup completed successfully: $BACKUP_NAME"
    
    # Compress the backup
    echo "Compressing backup..."
    cd "$BACKUP_DIR"
    tar -czf "$BACKUP_NAME.tar.gz" "$BACKUP_NAME"
    
    # Remove uncompressed directory
    echo "Removing uncompressed backup..."
    rm -rf "$BACKUP_NAME"
    
    # Keep only the 2 most recent backups
    # List all backup tar.gz files, sort by modification time (newest first), 
    # skip the first 2, and delete the rest
    ls -t *_mongodb.tar.gz 2>/dev/null | tail -n +3 | xargs -r rm -f
    
    echo "Backup retention applied - keeping only 2 most recent backups"
    echo "Current backups:"
    ls -la *_mongodb.tar.gz 2>/dev/null
else
    echo "Backup failed with exit code $?"
    exit 1
fi

echo "Backup process completed at $(date)"