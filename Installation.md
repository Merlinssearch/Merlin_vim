# Neovim Development Setup - Installation Guide (Arch Linux)

A modern Neovim configuration built on NvChad with LSP, formatting, linting, and syntax highlighting support for multiple programming languages.

## Prerequisites

### Install Neovim
```bash
# Install Neovim (latest stable)
sudo pacman -S neovim

# Or install from AUR for bleeding edge
yay -S neovim-git
```

### Install Required Dependencies

#### Core Dependencies
```bash
# Git (required for plugin management)
sudo pacman -S git

# Node.js and npm (required for many LSP servers)
sudo pacman -S nodejs npm

# Python with pip (required for Python tools)
sudo pacman -S python python-pip

# Cargo (for Rust-based tools)
sudo pacman -S rust

# Go (for Go-based tools)
sudo pacman -S go
```

#### Language-Specific Tools

**C/C++ Development:**
```bash
sudo pacman -S clang gcc gdb
```

**Go Development:**
```bash
# Go is already installed above
# Additional tools will be installed via Mason
```

**Python Development:**
```bash
pip install --user flake8 black isort
```

**JavaScript/TypeScript Development:**
```bash
npm install -g typescript typescript-language-server
```

**Lua Development:**
```bash
# Install luarocks for Lua package management
sudo pacman -S luarocks

# Install stylua for formatting
cargo install stylua
```

#### Optional but Recommended
```bash
# Ripgrep for better searching
sudo pacman -S ripgrep

# fd for file finding
sudo pacman -S fd

# lazygit for git management
sudo pacman -S lazygit

# Tree-sitter CLI
npm install -g tree-sitter-cli
```

## Installation Steps

### 1. Backup Existing Configuration
```bash
# Backup your existing Neovim config if it exists
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
mv ~/.local/state/nvim ~/.local/state/nvim.backup
mv ~/.cache/nvim ~/.cache/nvim.backup
```

### 2. Clone the Configuration
```bash
# Clone this repository to your Neovim config directory
git clone <your-repo-url> ~/.config/nvim

# Or if you have the files locally, copy them:
# cp -r /path/to/your/nvim/config ~/.config/nvim
```

### 3. Directory Structure Verification
Ensure your `~/.config/nvim` directory has this structure:
```
~/.config/nvim/
├── init.lua
├── Installation.md
├── lua
│   ├── chadrc.lua
│   ├── configs
│   │   ├── conform.lua
│   │   ├── lazy.lua
│   │   ├── lint.lua
│   │   ├── lspconfig.lua
│   │   ├── mason-conform.lua
│   │   ├── mason-lint.lua
│   │   ├── mason-lspconfig.lua
│   │   └── treesitter.lua
│   ├── mappings.lua
│   ├── options.lua
│   └── plugins
│       └── init.lua
└── Plugins.md
```

### 4. First Launch
```bash/zsh/fish whatever 
# Launch Neovim
nvim
```

On first launch:
1. Lazy.nvim will automatically install all plugins
2. Mason will install configured LSP servers, formatters, and linters
3. Treesitter will install syntax highlighting for configured languages

**Note:** The first startup might take a few minutes to download and compile everything.

### 5. Post-Installation Setup

#### Verify LSP Servers Installation
```bash
# In Neovim, check Mason status
:Mason
```

The following should be installed automatically:
- **LSP Servers:** lua_ls, clangd, gopls, pyright, ts_ls, html, cssls
- **Formatters:** stylua, clang-format, gofumpt, goimports-reviser, golines, black, isort, prettier
- **Linters:** luacheck, flake8, eslint_d

#### Check Health
```bash
# In Neovim, run health check
:checkhealth
```

## Supported Languages & Features

### Languages with Full LSP Support
- **Lua:** LSP (lua_ls), formatting (stylua), linting (luacheck)
- **C/C++:** LSP (clangd), formatting (clang-format)
- **Go:** LSP (gopls), formatting (gofumpt, goimports-reviser, golines)
- **Python:** LSP (pyright), formatting (black, isort), linting (flake8)
- **JavaScript/TypeScript:** LSP (ts_ls), formatting (prettier), linting (eslint_d)
- **HTML:** LSP (html), formatting (prettier)
- **CSS:** LSP (cssls), formatting (prettier)

### Treesitter Syntax Highlighting
- Bash, C, C++, CMake, Fish, Go, Lua, Make, Markdown, Python, TOML, Vim, YAML, JavaScript, TypeScript, HTML, CSS

## Key Features

- **Theme:** Catppuccin with transparency enabled
- **Auto-formatting:** Format on save for all supported languages
- **Intelligent linting:** Language-specific linters with error checking
- **LSP integration:** Auto-completion, go-to-definition, diagnostics
- **Treesitter:** Advanced syntax highlighting and code understanding
- **Mason integration:** Automatic tool management

## Troubleshooting

### Common Issues

#### LSP Server Not Working
```bash
# Check if LSP server is installed
:Mason

# Check LSP status
:LspInfo

# Restart LSP
:LspRestart
```

#### Formatting Not Working
```bash
# Check available formatters
:ConformInfo

# Manual format
:Format
```

#### Linting Issues
```bash
# Check linter status
:lua require("lint").try_lint()
```

#### Plugin Issues
```bash
# Update all plugins
:Lazy update

# Clean and reinstall
:Lazy clean
:Lazy install
```

### Getting Help
- Check `:help` for general Neovim help
- Use `:checkhealth` to diagnose configuration issues
- Check plugin documentation with `:help <plugin-name>`

## Configuration Customization

All configuration files are well-commented and can be modified to suit your needs:
- `lua/options.lua` - Editor options and settings
- `lua/mappings.lua` - Custom keybindings
- `lua/chadrc.lua` - NvChad theme and UI settings
- `lua/configs/` - Plugin-specific configurations

## Updates

To update your configuration:
```bash
# Update plugins
nvim -c "Lazy update" -c "qa"

# Update Mason packages
nvim -c "MasonUpdate" -c "qa"
```
