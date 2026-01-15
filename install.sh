#!/bin/bash

set -e

echo "🚀 Starting Dotfiles Installation..."

# 1. Homebrew
if ! command -v brew &> /dev/null; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "✅ Homebrew already installed"
fi

# 2. Bundle
echo "📦 Installing Brewfile dependencies..."
brew bundle --file="$HOME/dotfiles/Brewfile" || true

# 3. Stow
echo "🔗 Stowing dotfiles..."
./stow.sh

# 4. Mise (Version Management)
echo "🛠️  Setting up mise..."
if ! command -v mise &> /dev/null; then
    echo "❌ mise not found! It should have been installed by Brewfile."
    exit 1
fi

# Trust the config
mise trust "$HOME/dotfiles/mise.toml" || true

# Install tools defined in mise.toml
mise install

# 5. Shell Setup
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "🐚 Changing shell to zsh..."
    chsh -s "$(which zsh)"
fi

# 6. Neovim Setup
echo "📝 Setting up Neovim..."
# Install dependencies that might be needed by LSPs if not covered by mise
# (Most should be in mise now)

echo "🎉 Installation Complete! Restart your terminal."
