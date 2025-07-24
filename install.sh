#!/usr/bin/env bash

# sshx Installation Script

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$HOME/bin"
CONFIG_DIR="$HOME/.config"

echo "🚀 Installing sshx - SSH Context Switcher"
echo

# Create directories
echo "📁 Creating directories..."
mkdir -p "$BIN_DIR"
mkdir -p "$CONFIG_DIR/sshx"
mkdir -p "$CONFIG_DIR/zsh/completions"

# Copy main script
echo "📋 Installing main script..."
cp "$SCRIPT_DIR/bin/sshx" "$BIN_DIR/sshx"
chmod +x "$BIN_DIR/sshx"

# Copy configuration files
echo "⚙️  Installing configuration files..."

# Only copy config if it doesn't exist to avoid overwriting user's connections
if [[ ! -f "$CONFIG_DIR/sshx/config" ]]; then
    cp "$SCRIPT_DIR/.config/sshx/config" "$CONFIG_DIR/sshx/config"
    echo "   ✅ Created example config file at ~/.config/sshx/config"
else
    echo "   ⚠️  Config file already exists, skipping to preserve your connections"
fi

# Copy completion script
cp "$SCRIPT_DIR/.config/zsh/completions/_sshx" "$CONFIG_DIR/zsh/completions/_sshx"

# Check if ~/bin is in PATH
if ! echo "$PATH" | grep -q "$HOME/bin"; then
    echo
    echo "⚠️  ~/bin is not in your PATH. Adding to ~/.zshrc..."
    echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
    RESTART_SHELL=true
fi

# Check if completion is configured
if ! grep -q "fpath.*completions" ~/.zshrc 2>/dev/null; then
    echo "⚙️  Configuring zsh completions..."
    echo 'fpath=(~/.config/zsh/completions $fpath)' >> ~/.zshrc
    echo 'autoload -U compinit && compinit' >> ~/.zshrc
    RESTART_SHELL=true
fi

echo
echo "✅ Installation complete!"
echo

if [[ "${RESTART_SHELL:-}" == "true" ]]; then
    echo "🔄 Please restart your terminal or run: source ~/.zshrc"
    echo
fi

echo "📖 Usage:"
echo "   sshx              # Interactive mode (with fzf) or list connections"
echo "   sshx --list       # List all connections"
echo "   sshx <alias>      # Connect to a specific server"
echo "   sshx --help       # Show help"
echo
echo "📝 Edit your connections:"
echo "   sshx --edit       # Edit config file"
echo "   vim ~/.config/sshx/config"
echo
echo "💡 Install fzf for interactive mode:"
echo "   brew install fzf  # macOS"
echo "   sudo apt install fzf  # Ubuntu/Debian"
echo
echo "📚 Dependencies:"
echo "   Required: bash, ssh"
echo "   Optional: fzf (interactive mode), zsh (tab completion)"
echo

echo "🎉 Happy SSH-ing with sshx!"
