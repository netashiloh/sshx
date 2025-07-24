# sshx - SSH Context Switcher

A tool inspired by `kubectx` for managing and switching between SSH connections quickly and easily.

## Features

- 🚀 Quick switching between predefined SSH connections
- 📝 Simple configuration file format
- 🔍 Interactive selection with `fzf` (if available)
- 🎯 Tab completion for zsh
- 📚 Previous connection memory (like `cd -`)
- ✨ Colored output for current connection
- 💡 Easy connection management (add/remove/edit)

## Installation

### Quick Install

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd sshx
   ```

2. Run the install script:
   ```bash
   ./install.sh
   ```

### Manual Installation

1. Copy the main script to a directory in your PATH:
   ```bash
   cp bin/sshx ~/bin/sshx
   chmod +x ~/bin/sshx
   ```

2. Copy the configuration files:
   ```bash
   # Create config directory
   mkdir -p ~/.config/sshx
   mkdir -p ~/.config/zsh/completions
   
   # Copy config files
   cp .config/sshx/config ~/.config/sshx/config
   cp .config/zsh/completions/_sshx ~/.config/zsh/completions/_sshx
   ```

3. Add to your shell configuration (`.zshrc` for zsh):
   ```bash
   # Add ~/bin to PATH if not already there
   export PATH="$HOME/bin:$PATH"
   
   # Add completion directory to fpath
   fpath=(~/.config/zsh/completions $fpath)
   autoload -U compinit && compinit
   ```

4. Restart your terminal or run `source ~/.zshrc`

## Usage

### Basic Commands

```bash
# List all connections (or interactive mode with fzf)
sshx

# Connect to a specific connection
sshx server1

# Show current connection  
sshx --current

# Connect to previous connection
sshx -

# Add a new connection
sshx --add myserver "ssh -i ~/.ssh/key.pem user@host"

# Remove a connection
sshx --remove myserver

# Edit configuration file
sshx --edit

# List all connections
sshx --list

# Show help
sshx --help
```

### Interactive Mode

`sshx` has two modes when run without arguments:

**With fzf installed**: Shows an interactive fuzzy-search menu
```bash
# Install fzf to enable interactive mode
brew install fzf  # macOS
sudo apt install fzf  # Ubuntu/Debian

# Then use interactive mode
sshx
```

**Without fzf**: Simply lists all available connections
```bash
# Without fzf, this just lists connections
sshx
# Same as running:
sshx --list
```

## Configuration

### Config File Location

The configuration file is located at `~/.config/sshx/config`. Each line follows the format:
```
alias:ssh_command
```

### Example Configuration

```bash
# Example connections
production:ssh -i ~/.ssh/prod.pem ec2-user@prod-server.com
staging:ssh -i ~/.ssh/staging.pem ubuntu@staging-server.com
dev:ssh developer@dev.example.com
local:ssh user@localhost
vpn-server:ssh -p 2222 -i ~/.ssh/vpn.pem admin@vpn.company.com
```

### Environment Variables

- `SSHX_IGNORE_FZF=1` - Disable fzf interactive mode
- `SSHX_CURRENT_FGCOLOR` - Customize current connection foreground color
- `SSHX_CURRENT_BGCOLOR` - Customize current connection background color

## Tab Completion

Tab completion is automatically configured for zsh. You can:
- Press Tab after `sshx ` to see all available connections
- Press Tab after `sshx --remove ` to see removable connections
- Use fuzzy matching for connection names

## Examples

```bash
# Connect to production server
sshx production

# Go back to previous connection
sshx -

# Add a new connection for your local dev machine
sshx --add local "ssh user@localhost"

# List all connections with current highlighted
sshx --list

# Remove old connection
sshx --remove old-server

# Edit config file directly
sshx --edit
```

## Requirements

### Required
- **Bash** - For the main script execution
- **SSH client** - For establishing SSH connections

### Optional (Enhances Experience)
- **fzf** - Enables interactive connection selection mode (without it, `sshx` will list connections instead)
- **Zsh** - Provides advanced tab completion support (works with bash too, but completion is better with zsh)

### Installation of Optional Dependencies

#### fzf (Interactive Mode)
```bash
# macOS
brew install fzf

# Ubuntu/Debian
sudo apt install fzf

# Or install via git
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

#### Zsh (Tab Completion)
```bash
# macOS (usually pre-installed)
brew install zsh

# Ubuntu/Debian
sudo apt install zsh

# Set as default shell
chsh -s $(which zsh)
```

## Troubleshooting

### Command not found
Make sure:
1. `~/bin` is in your PATH: `echo $PATH | grep ~/bin`
2. The script is executable: `ls -la ~/bin/sshx`
3. You've restarted your terminal or run `source ~/.zshrc`

### Tab completion not working
1. Check if completion directory is in fpath: `echo $fpath`
2. Make sure `compinit` is loaded in your `.zshrc`
3. Try running `compinit` manually

### Interactive mode not working
1. Check if `fzf` is installed: `which fzf`
2. Install fzf: `brew install fzf` (macOS) or `sudo apt install fzf` (Ubuntu)

## Files Structure

```
sshx/
├── bin/
│   └── sshx                 # Main executable script
├── .config/
│   ├── sshx/
│   │   └── config          # Example configuration file
│   └── zsh/
│       └── completions/
│           └── _sshx       # Zsh completion script
├── install.sh              # Installation script
└── README.md               # This file
```

## Inspired By

This tool is inspired by [kubectx](https://github.com/ahmetb/kubectx), which provides similar functionality for Kubernetes contexts. If you work with Kubernetes, definitely check out the original kubectx project!

## License

MIT License - feel free to use and modify as needed.
