#!/bin/bash

# MongoDB Daily Backup Script
# Keeps only the 2 most recent backups in ~/Dropbox/backups

# Set backup directory
BACKUP_DIR="$HOME/Dropbox/backups"
TIMESTAMP=$(date +%Y_%m_%d_%H%M)
BACKUP_NAME="${TIMESTAMP}_mongodb"
LOG_FILE="$BACKUP_DIR/mongo_backup.log"

# Create backup
echo "Starting MongoDB backup at $(date)" | tee -a "$LOG_FILE"
/opt/homebrew/bin/mongodump --out "$BACKUP_DIR/$BACKUP_NAME" 2>&1 | tee -a "$LOG_FILE"

# Check if backup was successful
if [ $? -eq 0 ]; then
    echo "Backup completed successfully: $BACKUP_NAME" | tee -a "$LOG_FILE"
    
    # Compress the backup
    echo "Compressing backup..." | tee -a "$LOG_FILE"
    cd "$BACKUP_DIR"
    tar -czf "$BACKUP_NAME.tar.gz" "$BACKUP_NAME"
    
    # Remove uncompressed directory
    echo "Removing uncompressed backup..." | tee -a "$LOG_FILE"
    rm -rf "$BACKUP_NAME"
    
    # Keep only the 2 most recent backups
    # List all backup tar.gz files, sort by modification time (newest first), 
    # skip the first 2, and delete the rest
    ls -t *_mongodb.tar.gz 2>/dev/null | tail -n +3 | xargs -r rm -f
    
    echo "Backup retention applied - keeping only 2 most recent backups" | tee -a "$LOG_FILE"
    echo "Current backups:" | tee -a "$LOG_FILE"
    ls -la *_mongodb.tar.gz 2>/dev/null | tee -a "$LOG_FILE"
else
    echo "Backup failed with exit code $?" | tee -a "$LOG_FILE"
    exit 1
fi

echo "Backup process completed at $(date)" | tee -a "$LOG_FILE"
echo "----------------------------------------" >> "$LOG_FILE"