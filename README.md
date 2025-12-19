# nix-darwin

My personal macOS configuration using nix-darwin and home-manager.

## Structure

```
.
├── flake.nix                 # Main entry point
├── flake.lock
├── .envrc                    # Direnv integration
└── modules/
    ├── nix.nix               # Nix/Determinate settings
    ├── darwin/
    │   ├── default.nix       # Darwin module entry
    │   └── system.nix        # macOS system settings
    └── home/
        ├── default.nix       # Home-manager entry
        ├── zsh.nix           # Zsh configuration
        └── neovim.nix        # Neovim IDE setup
```

## What's Included

### System (darwin)
- Touch ID for sudo
- Passwordless sudo
- Nerd Fonts (JetBrains Mono, Fira Code)
- macOS defaults (dock, finder, keyboard)

### Shell (zsh)
- Oh-My-Zsh with robbyrussell theme
- Plugins: git, z, docker, kubectl
- Starship prompt
- Zoxide, fzf integration
- Syntax highlighting & autosuggestions

### Editor (neovim)
- Catppuccin theme
- LSP (Lua, Nix, TypeScript)
- Treesitter
- Telescope fuzzy finder
- Neo-tree file explorer
- Git signs, lualine, autopairs

### Tools
- ripgrep, fd, fzf, eza, bat, jq, tree
- Volta (Node.js version manager)
- Ghostty terminal

## Installation

### Prerequisites
- macOS on Apple Silicon
- [Determinate Nix](https://determinate.systems/posts/determinate-nix-installer)

### Setup

```bash
# Clone the repo
git clone git@github.com:maulanasdqn/nix-darwin.git ~/.config/nix

# Enter dev shell and rebuild
cd ~/.config/nix
nix develop --command rebuild
```

## Usage

```bash
# Rebuild after making changes
cd ~/.config/nix
nix develop --command rebuild

# Or with direnv enabled
rebuild
```

## Neovim Keybindings

| Key | Action |
|-----|--------|
| `<Space>` | Leader key |
| `<leader>e` | Toggle file tree |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Hover docs |
| `<leader>rn` | Rename |
| `<leader>ca` | Code action |

## License

MIT
