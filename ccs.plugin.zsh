# Claude Code Settings switcher
# Usage: ccs [config_name]

function ccs() {
    local settings_dir="$HOME/.claude-code-custom/settings"
    local target_link="$HOME/.claude/settings.json"

    # No argument - list all configs
    if [[ -z "$1" ]]; then
        local configs=("$settings_dir"/*.json(N))
        local current_target

        # Get current link target if exists
        if [[ -L "$target_link" ]]; then
            current_target=$(readlink "$target_link")
        fi

        for config in "${configs[@]}"; do
            local basename="${config:t}"
            local marker=" "

            # Check if this is the current config
            if [[ "$current_target" == "$config" ]]; then
                marker="*"
            fi

            echo "$marker ${basename%.json}"
        done
        return
    fi

    # With argument - switch config
    local config_file="$settings_dir/$1.json"

    # Check if config file exists
    if [[ ! -f "$config_file" ]]; then
        echo "Error: Config file '$config_file' not found" >&2
        return 1
    fi

    # Create target directory if not exists
    local target_dir=$(dirname "$target_link")
    if [[ ! -d "$target_dir" ]]; then
        mkdir -p "$target_dir"
    fi

    # Remove existing link if exists
    if [[ -L "$target_link" ]]; then
        rm "$target_link"
    fi

    # Create new symlink
    ln -s "$config_file" "$target_link"
    echo "Switched to: $1"
}

function _ccs() {
    local -a configs
    local settings_dir="$HOME/.claude-code-custom/settings"
    
    # Get config names (filenames without extension)
    # (N) - nullglob (don't error if no matches)
    # :t  - tail (basename)
    # :r  - root (remove extension)
    configs=("$settings_dir"/*.json(N:t:r))
    
    if (( ${#configs} )); then
        compadd -a configs
    fi
}

compdef _ccs ccs
