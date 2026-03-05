# Neovim Configuration

A modern, fast, and feature-rich Neovim configuration managed with [lazy.nvim](https://github.com/folke/lazy.nvim).

## Installation On Host PC

### 1. Prerequisites

Ensure you have the following installed on your system before setting up the configuration.

- **Neovim** (v0.9.0 or higher)
- **Git**
- **Ripgrep** (Required for Telescope live grep)
- **Compiler/Build Tools** (Required for `nvim-treesitter` and C++ config commands)
- **Python 3** (Required for Python tools/LSP)
- **Java 17+** (Required for `nvim-jdtls` Java support)

#### Arch Linux
```bash
sudo pacman -S neovim git ripgrep base-devel python jdk17-openjdk
```

#### Debian / Ubuntu
```bash

sudo apt install -y neovim git ripgrep build-essential python3 default-jdk
```

#### macOS (Using Homebrew)
```bash
brew install neovim git ripgrep python openjdk@17
```

#### Windows (Using Winget)
You will need to install MinGW or Visual Studio build tools manually for C++ compilation, but the rest can be grabbed quickly:
```powershell
winget install Neovim.Neovim Git.Git BurntSushi.ripgrep.MSVC Python.Python.3.11 Microsoft.OpenJDK.17
```

### 2. Setup Configuration

Use the following bash commands to install the configuration:

```bash
# 1. Back up your existing Neovim configuration and state (if any)
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak

# 2. Clone this repository into your Neovim config directory
git clone https://github.com/MukaramNadeem/lazy-nvim-config.git ~/.config/nvim

# 3. Start Neovim!
# Lazy.nvim will automatically download and install all the plugins on the first run.
nvim
```

## Features & Plugins

This configuration comes with a carefully selected set of powerful plugins:

- **Plugin Manager:** `lazy.nvim`
- **Theme:** `catppuccin`
- **File Explorer:** `neo-tree`
- **Statusline:** `lualine`
- **Fuzzy Finder:** `telescope.nvim`
- **Syntax Highlighting:** `nvim-treesitter`
- **LSP / Autocomplete:** `nvim-lspconfig`, `mason.nvim`, `nvim-cmp`
- **Formatting:** `conform.nvim` (with auto-format on save)
- **Indentation Guides:** `mini.indentscope` and `indent-blankline.nvim`
- **Java Experience:** `nvim-jdtls`

## Keybindings

The leader key is mapped to `<Space>`. All bindings below showing `<Space>` require pressing the spacebar followed by the specified key(s).

### General
| Keybinding | Action |
| --- | --- |
| `<C-s>` | Save File (`:w`) |
| `<Esc>` | Clear search highlights (`:nohl`) |
| `<C-h> / <C-j> / <C-k> / <C-l>` | Better window navigation |
| `<Space>e` | Toggle Neo-tree Explorer |
| `<Space>mp` | Format file or range (Conform) |

### Telescope (Fuzzy Finding)
| Keybinding | Action |
| --- | --- |
| `<Space>f` | Find Files |
| `<Space>fg` | Find Text (Live Grep) |
| `<Space>b` | Find Buffers |

### Autocomplete (`nvim-cmp`)
| Keybinding | Action |
| --- | --- |
| `<C-p> / <C-n>` | Select previous / next item |
| `<CR>` | Confirm selection |
| `<C-Space>` | Complete |

### LSP & Code Interaction (Java specifically - `jdtls`)
| Keybinding | Action |
| --- | --- |
| `<Space>jo` | Organize Imports |
| `<Space>jv` | Extract Variable |
| `<Space>jc` | Extract Constant |
| `<Space>jm` | Extract Method (Visual Mode) |

### Language Specific "Run" Commands
This configuration adds simple "Run" commands for supported languages, compiling and running with one keypress!

| Language | Keybinding | Action |
| --- | --- | --- |
| **C++** | `<Space>r` | Compile the C++ file into `/tmp/` and execute it |
| **Python** | `<Space>r` | Run the Python file in a horizontal split terminal |
| **Java** | `<Space>r` | Run the Java file (`java <filename>`) in a split terminal |

## Editor Options
- **Indentation:** 4 spaces (except C++ which is customized to 2 spaces)
- **Line Numbers:** Absolute and Relative turned on for easy jumping.
- **Search:** Smart casing (ignores case unless you type a capital letter).
- **Split Behavior:** Vertical splits open to the right; horizontal go down.
- **Undo:** Persistent undo history (keeps history even after closing Neovim).
- **Scroll:** Keeps 8 lines of context above/below the cursor when scrolling.
