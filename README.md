# ccs - Claude Code Settings Switcher

An Oh My Zsh plugin to quickly switch between different Claude Code configurations.

## Overview

This plugin manages your `~/.claude/settings.json` by symlinking it to configuration files stored in `~/.claude-code-custom/settings/`.

## Prerequisites

1.  **Oh My Zsh** installed.
2.  A directory at `~/.claude-code-custom/settings/` containing your configuration JSON files (e.g., `personal.json`, `work.json`, etc.).

## Installation

1.  Clone this repository into your Oh My Zsh custom plugins directory:
    ```sh
    git clone https://github.com/yourusername/omz-plugin-ccs ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/ccs
    ```

2.  Add the plugin to the list of plugins for Oh My Zsh to load (inside `~/.zshrc`):
    ```sh
    plugins=(... ccs)
    ```

3.  Start a new terminal session or reload your shell.

## Usage

### List Available Configurations

Run `ccs` without arguments to list all available configuration files in `~/.claude-code-custom/settings/`. The currently active configuration (symlinked to `~/.claude/settings.json`) will be marked with an asterisk `*`.

```sh
ccs
```

**Output Example:**
```
  personal
* work
  creative
```

### Switch Configuration

To switch to a specific configuration, provide the name of the configuration file (without the `.json` extension).

```sh
ccs personal
```

**Output:**
```
Switched to: personal
```

## Autocompletion

The plugin includes built-in tab completion for configuration names. Type `ccs` followed by a space and press `Tab` to see available options.
