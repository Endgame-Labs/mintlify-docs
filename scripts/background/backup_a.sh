#!/bin/bash

# Backup script for ~/a directory and dotfiles
# Creates timestamped zip files and saves them to ~/Dropbox/backups/
# Keeps only the newest 20 backups

# Define paths
SOURCE_DIR="$HOME/a"
BACKUP_DIR="$HOME/Dropbox/backups"
# Get timestamp with milliseconds (using perl for cross-platform compatibility)
TIMESTAMP=$(perl -MTime::HiRes=time -e 'my $t = time; my @tm = localtime($t); printf "%04d_%02d_%02d_%02d%02d_%02d.%02d", $tm[5]+1900, $tm[4]+1, $tm[3], $tm[2], $tm[1], $tm[0], ($t-int($t))*100')
BACKUP_FILENAME="${TIMESTAMP}_users_dorkitude_a.zip"
BACKUP_PATH="${BACKUP_DIR}/${BACKUP_FILENAME}"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Create uncompressed dotfiles backup folder
echo "Creating uncompressed dotfiles backup..."
DOTFILES_BACKUP_DIR="${SOURCE_DIR}/dotfiles.backup"
mkdir -p "$DOTFILES_BACKUP_DIR"

# Copy dotfiles to backup folder
cd "$HOME" || exit 1
for f in .[^.]*; do
    if [ -f "$f" ] && [ "$f" != ".DS_Store" ] && [ "$f" != ".CFUserTextEncoding" ] && [ "$f" != ".localized" ]; then
        cp "$f" "$DOTFILES_BACKUP_DIR/" 2>/dev/null && echo "Copied: $f"
    fi
done

# Copy specific .claude files if they exist
if [ -d ".claude" ]; then
    mkdir -p "$DOTFILES_BACKUP_DIR/.claude"
    [ -f ".claude/settings.json" ] && cp ".claude/settings.json" "$DOTFILES_BACKUP_DIR/.claude/" && echo "Copied: .claude/settings.json"
    [ -f ".claude/settings.local.json" ] && cp ".claude/settings.local.json" "$DOTFILES_BACKUP_DIR/.claude/" && echo "Copied: .claude/settings.local.json"
    [ -f ".claude/CLAUDE.md" ] && cp ".claude/CLAUDE.md" "$DOTFILES_BACKUP_DIR/.claude/" && echo "Copied: .claude/CLAUDE.md"
    [ -f ".claude/claude.md" ] && cp ".claude/claude.md" "$DOTFILES_BACKUP_DIR/.claude/" && echo "Copied: .claude/claude.md"
fi

echo "Uncompressed dotfiles backup completed: ${DOTFILES_BACKUP_DIR}"
echo ""

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
BACKUP_FILES=($(ls -t *_users_dorkitude_a.zip 2>/dev/null))
TOTAL_FILES=${#BACKUP_FILES[@]}

if [ $TOTAL_FILES -gt 20 ]; then
    # Delete all files beyond the 20 newest
    for ((i=20; i<$TOTAL_FILES; i++)); do
        echo "Removing old backup: ${BACKUP_FILES[$i]}"
        rm "${BACKUP_FILES[$i]}"
    done
fi