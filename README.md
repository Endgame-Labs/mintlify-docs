# ~/a Directory Documentation

This directory (`~/a`) serves as a personal workspace containing development projects, scripts, and configurations.

## Directory Structure

```
~/a/
├── base/               # Empty directory (placeholder)
├── dev/                # Development projects (ignored by git)
│   ├── cerebro/       # Main project workspace
│   ├── cd/            # Copy of cerebro project
│   └── scrappy-head/  # Web scraping project
├── scripts/           # Utility scripts and configurations
│   ├── .startup       # Shell startup configuration (sourced from ~/.zshrc)
│   ├── background/    # Background/automated scripts
│   │   └── backup_a.sh  # Automated backup script
│   └── daemon-wrappers.zsh  # Terminal title management for daemons
└── .gitignore         # Git ignore configuration
```

## File Descriptions

### Scripts

#### `/scripts/.startup`
- **Purpose**: Shell startup configuration file
- **Integration**: Sourced from `~/.zshrc` on shell initialization
- **Features**:
  - Custom command aliases (git, navigation, etc.)
  - Terminal prompt customization with git branch display
  - Environment path configurations (Google Cloud SDK, CMake, cocos2d-x)
  - Python environment initialization (pyenv)
  - Claude CLI alias configuration

#### `/scripts/background/backup_a.sh`
- **Purpose**: Automated backup script for the `~/a` directory and dotfiles
- **Integration**: Scheduled via crontab to run hourly
- **Features**:
  - Creates timestamped zip backups in `~/Dropbox/backups/`
  - Backs up entire `~/a` directory (excluding `/dev` subdirectory)
  - Separately backs up home directory dotfiles
  - Maintains only the 20 most recent backups of each type
  - Excludes common temporary files (.DS_Store, __pycache__, .git, etc.)

#### `/scripts/daemon-wrappers.zsh`
- **Purpose**: Terminal title management wrappers for daemon processes
- **Integration**: Sourced from `.startup` file
- **Features**:
  - `os()`: Wrapper for Overmind with dynamic terminal title
  - `cly()`: Claude CLI wrapper with dangerous permissions and custom title
  - `cla()`: Claude CLI wrapper without dangerous permissions
  - Prevents wrapped commands from changing terminal titles
  - Automatically restores terminal title after command completion

### Configuration Files

#### `.gitignore`
- **Purpose**: Git ignore configuration
- **Notable exclusions**:
  - The entire `dev/` directory
  - OS-generated files (.DS_Store, etc.)
  - IDE/editor files
  - Language-specific build artifacts (Python, Node.js, Go)
  - Temporary files and logs
  - Environment configuration files

## System Integration

### Crontab Entry
```bash
0 * * * * /Users/dorkitude/a/scripts/background/backup_a.sh >> /tmp/backup_a.log 2>&1
```
- Runs backup script hourly
- Logs output to `/tmp/backup_a.log`

### Shell Integration
The `.startup` file should be sourced from `~/.zshrc`:
```bash
source ~/a/scripts/.startup
```

## Key Aliases (from .startup)

### Navigation
- `cda` - cd to ~/a
- `cdd` - cd to ~/a/dev
- `cdc` - cd to ~/a/dev/cerebro/
- `cdb` - cd to ~/a/dev/cerebro/src/briefs
- `cdaf` - cd to ~/a/dev/cerebro/src/app-frontend

### Git Commands
- `gs` - git status
- `gd` - git diff
- `gcm` - git commit -m
- `gau` - git add -u
- `ga` - git add
- `gb` - git branch
- `gc` - git checkout
- `gl` - git log
- `gp` - git pull
- `gcam` - git commit -am

### Utilities
- `ll` - ls -lah
- `v`, `vim`, `vi` - nvim
- `cc` - claude --dangerously-skip-permissions
- `vs` - vim ~/a/scripts/.startup
- `cs` - code ~/a/scripts/.startup
- `ss` - source ~/.zshrc
- `pg` - ping google.com

## Notes

- The `dev/` directory contains development projects but is excluded from git tracking
- Backup retention is set to 20 most recent backups for both directory and dotfiles
- Terminal title management prevents certain commands from changing the terminal title during execution