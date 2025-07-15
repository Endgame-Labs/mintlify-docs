#!/usr/bin/env zsh
# Improved daemon wrappers with proper ghostty split coordination
# Uses PID-based tracking to prevent conflicts between splits

# Directory for daemon state files
DAEMON_STATE_DIR="${HOME}/.cache/daemon-wrappers"
mkdir -p "$DAEMON_STATE_DIR"

# Set terminal title
_set_title() { 
    print -Pn "\e]2;$1\a" 
}

# Create a state file for this daemon
_create_daemon_state() {
    local daemon_type="$1"
    local pid=$$
    local state_file="${DAEMON_STATE_DIR}/${pid}.state"
    
    cat > "$state_file" <<EOF
DAEMON_TYPE=$daemon_type
DAEMON_PID=$pid
DAEMON_FOLDER=${PWD:t}
DAEMON_START_TIME=$(date +%s)
EOF
}

# Remove state file when daemon exits
_cleanup_daemon_state() {
    local pid=$$
    rm -f "${DAEMON_STATE_DIR}/${pid}.state"
}

# Get title for daemon type
_get_daemon_title() {
    local daemon_type="$1"
    local folder="$2"
    
    case "$daemon_type" in
        overmind)
            echo "🧠 🧠 Overmind @ $folder 🧠 🧠"
            ;;
        claude-yolo)
            echo "$folder — Claude Yolo 🤖🔥"
            ;;
        claude)
            echo "$folder — Claude 🤖"
            ;;
        gemini-yolo)
            echo "$folder — Gemini Yolo ✨🔥"
            ;;
        *)
            echo "%~"
            ;;
    esac
}

# Wrapper for managing daemon lifecycle
_run_daemon() {
    local daemon_type="$1"
    shift  # Remove daemon_type from args
    
    local folder=${PWD:t}
    local title=$(_get_daemon_title "$daemon_type" "$folder")
    
    # Create state file
    _create_daemon_state "$daemon_type"
    
    # Set up cleanup trap
    trap '_cleanup_daemon_state' EXIT INT TERM
    
    # Set initial title
    _set_title "$title"
    
    # Start title maintenance in background (with proper PID tracking)
    (
        local my_pid=$$
        while kill -0 $my_pid 2>/dev/null; do
            # Only update title if we're still the active process
            if [[ -f "${DAEMON_STATE_DIR}/${my_pid}.state" ]]; then
                _set_title "$title"
            fi
            sleep 0.5
        done
    ) &
    local title_pid=$!
    
    # Run the actual command
    "$@"
    local exit_code=$?
    
    # Cleanup
    kill $title_pid 2>/dev/null
    wait $title_pid 2>/dev/null
    _cleanup_daemon_state
    
    # Restore normal title
    _set_title "%~"
    
    # Remove trap
    trap - EXIT INT TERM
    
    return $exit_code
}

# Overmind wrapper
os() {
    # Remove any existing overmind socket
    rm -f .overmind.sock
    
    _run_daemon "overmind" overmind start --any-can-die 2>&1 | tee -a overmind.log.local
}

# Claude YOLO wrapper
cly() {
    _run_daemon "claude-yolo" "claude" --dangerously-skip-permissions "$@"
}

# Claude wrapper without dangerous permissions
cla() {
    _run_daemon "claude" "claude" "$@"
}

# Gemini YOLO wrapper
gy() {
    _run_daemon "gemini-yolo" "gemini" -y "$@"
}

# Clean up stale state files on shell startup
_cleanup_stale_states() {
    local now=$(date +%s)
    for state_file in "$DAEMON_STATE_DIR"/*.state(N); do
        if [[ -f "$state_file" ]]; then
            local pid=$(basename "$state_file" .state)
            # Remove if process doesn't exist
            if ! kill -0 "$pid" 2>/dev/null; then
                rm -f "$state_file"
            fi
        fi
    done
}

# Update terminal title before each prompt
_daemon_wrapper_precmd() {
    # Check if current shell has an active daemon
    local my_state="${DAEMON_STATE_DIR}/$$.state"
    if [[ -f "$my_state" ]]; then
        # We have an active daemon, keep its title
        source "$my_state"
        local title=$(_get_daemon_title "$DAEMON_TYPE" "$DAEMON_FOLDER")
        _set_title "$title"
    else
        # No active daemon, show directory
        _set_title "%~"
    fi
}

# Add our precmd function to the array
if [[ -z ${precmd_functions[(r)_daemon_wrapper_precmd]} ]]; then
    precmd_functions+=(_daemon_wrapper_precmd)
fi

# Clean up on startup
_cleanup_stale_states