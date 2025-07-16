#!/usr/bin/env zsh
# Focus-aware terminal title management for daemons in ghostty
# This version uses environment variables instead of aggressive background loops

# Set terminal title
_set_title() { 
    print -Pn "\e]2;$1\a" 
}

# Check if we're in the focused ghostty split
_is_focused() {
    # ghostty sets GHOSTTY_RESOURCES_DIR, we can use this to detect ghostty
    [[ -n "$GHOSTTY_RESOURCES_DIR" ]] || return 0  # If not in ghostty, assume focused
    
    # For now, we'll set title only when command is run
    # This prevents background loops from fighting
    return 0
}

# Update title based on current daemon state
_update_daemon_title() {
    local daemon_type="$1"
    local folder=${PWD:t}
    
    case "$daemon_type" in
        overmind)
            _set_title "🧠 🧠 Overmind @ $folder 🧠 🧠"
            ;;
        claude-yolo)
            _set_title "$folder — Claude Yolo 🤖🔥"
            ;;
        claude)
            _set_title "$folder — Claude 🤖"
            ;;
        gemini-yolo)
            _set_title "$folder — Gemini Yolo ✨🔥"
            ;;
        *)
            _set_title "%~"
            ;;
    esac
}

# Store daemon state in environment variable
_set_daemon_state() {
    export DAEMON_WRAPPER_STATE="$1"
    export DAEMON_WRAPPER_FOLDER="${PWD:t}"
}

_clear_daemon_state() {
    unset DAEMON_WRAPPER_STATE
    unset DAEMON_WRAPPER_FOLDER
}

# Overmind wrapper
os() {
    local folder=${PWD:t}
    
    # Remove any existing overmind socket
    rm -f .overmind.sock
    
    # Set daemon state
    _set_daemon_state "overmind"
    _update_daemon_title "overmind"
    
    # Run overmind without background title loop
    overmind start --any-can-die 2>&1 | tee -a overmind.log.local
    local exit_code=$?
    
    # Clear daemon state
    _clear_daemon_state
    _set_title "%~"
    
    return $exit_code
}

# Claude YOLO wrapper
cly() {
    local folder=${PWD:t}
    
    # Set daemon state
    _set_daemon_state "claude-yolo"
    _update_daemon_title "claude-yolo"
    
    # Run Claude with dangerous permissions
    "claude" --dangerously-skip-permissions "$@"
    local exit_code=$?
    
    # Clear daemon state
    _clear_daemon_state
    _set_title "%~"
    
    return $exit_code
}

# Claude wrapper without dangerous permissions
cla() {
    local folder=${PWD:t}
    
    # Set daemon state
    _set_daemon_state "claude"
    _update_daemon_title "claude"
    
    # Run Claude without dangerous permissions
    "claude" "$@"
    local exit_code=$?
    
    # Clear daemon state
    _clear_daemon_state
    _set_title "%~"
    
    return $exit_code
}

# Gemini YOLO wrapper
gy() {
    local folder=${PWD:t}
    
    # Set daemon state
    _set_daemon_state "gemini-yolo"
    _update_daemon_title "gemini-yolo"
    
    # Run Gemini with yolo flag
    "gemini" -y "$@"
    local exit_code=$?
    
    # Clear daemon state
    _clear_daemon_state
    _set_title "%~"
    
    return $exit_code
}

# Update terminal title before each prompt
_daemon_wrapper_precmd() {
    if [[ -n "$DAEMON_WRAPPER_STATE" ]]; then
        # If a daemon is running, maintain its title
        _update_daemon_title "$DAEMON_WRAPPER_STATE"
    else
        # Otherwise show current directory
        _set_title "%~"
    fi
}

# Add our precmd function to the array
if [[ -z ${precmd_functions[(r)_daemon_wrapper_precmd]} ]]; then
    precmd_functions+=(_daemon_wrapper_precmd)
fi

# Optional: Hook into ghostty's focus events if available
# This would require ghostty to expose focus events somehow
# For now, we rely on precmd to update titles