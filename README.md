# Neovim Development Setup - Installation Guide 

A modern Neovim configuration built on NvChad with LSP, formatting, linting, and syntax highlighting support for multiple programming languages.

**My Setup**: Arch Linux

Should work on any Linux distro. If not and you found a solution, post it in ISSUES so others can profit from it too! 

Some distros may have old Nvim versions - consider building from source if something doesn't work. Should maybe work with Brew on macOS too.

I also managed to use PowerShell with WSL to get Nvim running on Windows (spent too much time with it though - just use Visual Studio with vim motion. Not worth the time, no system clipboard working for me xD).

# Package Manager Quick Reference

Different Linux distros use different package managers, but they work similarly. Just replace `pacman` with your distro's package manager and the appropriate flags. Here's the conversion:

- **Arch/Manjaro**: `pacman -S package_name` <--- Arch is the best by the way <3 
- **Ubuntu/Debian**: `apt install package_name` 
- **Fedora/RHEL**: `dnf install package_name`
- **openSUSE**: `zypper install package_name`
- **Alpine**: `apk add package_name`

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
# About `~/.local/state/nvim`

Neovim stores **runtime data** in `~/.local/state/nvim`. This includes:

- Undo files (undo changes after closing)
- Swap files (crash protection)
- Temporary session or plugin data

It follows the [XDG spec](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html):

- Config in `~/.config/nvim`
- Data in `~/.local/share/nvim`
- Runtime state in `~/.local/state/nvim`
- Cache in `~/.cache/nvim`

Backing up this folder preserves undo history and session info.

---


### 2. Clone the Configuration
```bash
# Clone this repository to your Neovim config directory
git clone <your-repo-url> ~/.config/nvim

# Or if you have the files locally, copy them:
# cp -r /path/to/your/nvim/config ~/.config/nvim
```

### 3. Directory Structure Verification
Ensure your `~/.config/nvim` directory has this structure (my Structure is bad but worked) :
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

- **Theme:** Catppuccin with transparency enabled (make sure Terminal Emulator has transparency also enabled , also Font related thinks like Nerd Fonts should be used by terminal)
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
# Nerd Fonts Installation Guide

Nerd Fonts are patched fonts with extra icons and glyphs for programming and terminals.

## 1. Choose & Download

Visit [nerdfonts.com/font-downloads](https://www.nerdfonts.com/font-downloads) and pick a font:
- **FiraCode Nerd Font** - Popular with ligatures
- **JetBrains Mono Nerd Font** - Clean and modern  
- **Hack Nerd Font** - Classic monospace

Download the `.zip` file and extract all `.ttf` files.

## 2. Install Fonts

### Linux
```bash
mkdir -p ~/.local/share/fonts
cp *.ttf ~/.local/share/fonts/
fc-cache -fv
```

### macOS
```bash
# Double-click font files or use command:
open *.ttf
```
Then click "Install Font" in Font Book.

### Windows
Right-click font files → "Install" or "Install for all users"

## 3. Configure Terminal

### GUI Method
Most terminals: **Preferences** → **Font/Appearance** → Select your Nerd Font

### Config Files

**Kitty** (`~/.config/kitty/kitty.conf`):
```
font_family FiraCode Nerd Font
```

**Alacritty** (`~/.config/alacritty/alacritty.yml`):
```yaml
font:
  normal:
    family: FiraCode Nerd Font
```

**Windows Terminal** (`settings.json`):
```json
"fontFace": "FiraCode Nerd Font"
```

**iTerm2** (macOS): Preferences → Profiles → Text → Font

**GNOME Terminal**: Preferences → Profile → Text → Custom font

**Konsole** (KDE): Settings → Edit Current Profile → Appearance → Font

**Hyper** (`~/.hyper.js`):
```js
fontFamily: 'FiraCode Nerd Font'
```

**Wezterm** (`~/.wezterm.lua`):
```lua
config.font = wezterm.font('FiraCode Nerd Font')
```

**Terminator** (`~/.config/terminator/config`):
```ini
[profiles]
  [[default]]
    font = FiraCode Nerd Font 12
```

## 4. Test Installation

Icons should display correctly in:
- Powerlevel10k prompts (a theme from oh my zsh for nice terminal with zsh)
- File managers with icons (like yazi)
- Status bars and dev tools 

## Troubleshooting

- **Linux**: Check installation with `fc-list | grep "Nerd"`
- **All platforms**: Restart terminal after installation
- Verify exact font name in system settings
