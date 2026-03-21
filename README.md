# dotfiles

Personal Hyprland dotfiles with a generic rice management system built on [chezmoi](https://www.chezmoi.io/).

## Overview

This repo manages configs for multiple Hyprland desktop rices and provides a set of fish functions to install, switch, and remove them seamlessly.

Currently supported rices:
- **ii** — [illogical-impulse](https://github.com/end-4/dots-hyprland) by end-4

---

## Structure

```
~/.local/share/chezmoi/
├── .rices                        # Space-separated registry of installed rices
├── .chezmoidata.toml             # Active rice (qsConfig variable)
├── rice-configs/
│   ├── <rice>.conf               # Rendered Hyprland snippet (sourced at boot)
│   ├── <rice>.conf.tmpl          # Portable template (source of truth)
│   ├── <rice>.start              # uwsm start command
│   └── <rice>.stop               # pkill stop command
└── dot_config/
    ├── hypr/                     # All Hyprland configs
    │   └── hyprland.conf.tmpl    # Sources active rice conf dynamically
    ├── quickshell/<rice>/        # Shell config per rice
    └── fish/functions/           # Rice management scripts
```

### How it works

`hyprland.conf` is a chezmoi template that sources the active rice's config snippet:

```ini
source = /home/<user>/.local/share/chezmoi/rice-configs/<active-rice>.conf
```

Each rice snippet contains its own Hyprland `source=` lines, keybinds, execs, etc. Switching rices updates this variable and re-renders the config.

---

## Requirements

- [chezmoi](https://www.chezmoi.io/)
- [fish](https://fishshell.com/)
- [uwsm](https://github.com/Vladimir-csp/uwsm)
- [hyprland](https://hyprland.org/)
- An AUR helper (`paru` or `yay`)

---

## Fresh Install

```bash
chezmoi init https://github.com/Kanapech/dotfiles.git
chezmoi apply
```

This will restore all configs and fish functions. Then install your desired rice manually and register it with `install-rice`.

---

## Commands

### `switch-rice <name>`
Switch to an installed rice. Stops the current shell, applies the new Hyprland config, reloads Hyprland, and starts the new shell via `uwsm`.

```bash
switch-rice ii
```

### `list-rices`
Show all installed rices and which one is currently active.

```bash
list-rices
# Output:
#   * ii (active)
#     caelestia
```

### `install-rice <name>`
Register a new rice. The rice must be cloned to `~/.local/share/<name>` first. Auto-detects the shell start/stop commands from the rice's `execs.conf`.

```bash
# 1. Clone the rice
git clone https://github.com/some/rice ~/.local/share/myrice

# 2. Run its installer (say N to hypr config overwrite)
~/.local/share/myrice/install.fish

# 3. Register it
install-rice myrice

# 4. Switch to it
switch-rice myrice
```

### `uninstall-rice <name>`
Fully remove a rice. Switches away if active, removes symlinked configs, cleans up `rice-configs/`, uninstalls top-level AUR packages, and lists orphaned deps for manual review.

```bash
uninstall-rice caelestia
```

### `update-dots`
Re-adds all managed configs to chezmoi, updates rice config snippets, commits, and pushes to GitHub.

```bash
update-dots
```

---

## Adding a New Rice

1. Clone it to `~/.local/share/<name>`
2. Run its installer — **say N when asked to overwrite `~/.config/hypr`**
3. Run `install-rice <name>` — this will:
   - Register it in `.rices`
   - Create a portable `<name>.conf.tmpl` from its `hyprland.conf`
   - Auto-detect and save start/stop commands
4. Run `switch-rice <name>`

---

## How Switching Works

1. All running rice shells are stopped via their `.stop` scripts
2. `.chezmoidata.toml` is updated with the new rice name
3. The rice's `.conf.tmpl` is rendered into `.conf`
4. `chezmoi apply` writes the new `hyprland.conf`
5. `hyprctl reload` applies the new Hyprland config
6. The new shell is started via `uwsm app -t service`
7. A desktop notification confirms the switch

---

## Keeping Configs Updated

After an ii update:
```bash
update-dots
```

This re-adds all tracked files, updates rice snippets, and pushes everything to GitHub in one command.

---

## Notes

- `~/.config/hypr` is fully managed by chezmoi — do not use a separate git repo for it
- `~/.config/quickshell/<rice>/` is managed per rice — only the active rice's shell config is tracked
- `rice-configs/*.conf` files are committed to the repo — they are needed at Hyprland startup before any script can run
- `rice-configs/*.conf.tmpl` are the portable source of truth — `$HOME` paths are replaced with `{{ .chezmoi.homeDir }}`

## Custom ii modifications

These upstream ii files have been modified and are tracked in chezmoi:

- `GlobalStates.qml` — added `appBrowserOpen` property
- `panelFamilies/IllogicalImpulseFamily.qml` — added AppBrowser loader
- `modules/ii/overview/SearchBar.qml` — added app browser toggle button

### New modules
- `modules/ii/appBrowser/AppBrowser.qml` — fullscreen app grid browser
