# Claude Code Settings switcher
# Usage: ccs [provider_name] [args...]

function ccs() {
    local providers_dir="$HOME/.claude-code-custom/providers"

    # No argument - list all providers
    if [[ -z "$1" ]]; then
        local configs=("$providers_dir"/*.json(N))

        if (( ${#configs} == 0 )); then
            echo "No providers found in $providers_dir"
            return
        fi

        for config in "${configs[@]}"; do
            echo "  ${${config:t}%.json}"
        done
        return
    fi

    # With argument - launch claude with that provider's settings
    local config_file="$providers_dir/$1.json"

    if [[ ! -f "$config_file" ]]; then
        echo "Error: Provider '$1' not found ($config_file)" >&2
        return 1
    fi

    claude --settings "$config_file" "${@:2}"
}

function _ccs() {
    local -a configs
    local providers_dir="$HOME/.claude-code-custom/providers"

    configs=("$providers_dir"/*.json(N:t:r))

    if (( ${#configs} )); then
        compadd -a configs
    fi
}

compdef _ccs ccs
