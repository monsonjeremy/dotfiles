#!/bin/bash

export DOTFILES=$HOME/dotfiles
export STOW_FOLDERS="dotfiles,nvim,kitty,tmux,starship,zsh"

echo "$(tput setaf 2)Checking for Homebrew installation.$(tput sgr 0)"

export BREW_USR="/usr/local/bin/brew"
export BREW_OPT="/opt/homebrew/bin/brew"

if [ -f "$BREW_OPT" ] || [ -f "$BREW_USR" ]; then
  echo "$(tput setaf 2)Homebrew is installed.$(tput sgr 0)"
else
  echo "$(tput setaf 3)Installing Homebrew. Homebrew requires osx command lines tools, please download xcode first$(tput sgr 0)"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>/Users/jmonson/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew install stow
sh ./stow.sh

if command -v brew >/dev/null 2>&1; then
  brew bundle
fi

\curl -L https://install.perlbrew.pl | bash

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

echo "$(tput setaf 2)Setting up asdf.$(tput sgr 0)"
asdf plugin add python
asdf install python 3.9.5
asdf global python 3.9.5
pip install neovim
pip install vim-vint

sudo gem install neovim

nvim --headless -c 'autocmd User LazyComplete quitall' -c 'Lazy sync'

defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 10

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

eval "$(fnm env --use-on-cd)"
fnm install 16
fnm default 16
fnm use 16
npm i -g eslint_d \
  neovim \
  npm \
  prettier \
  prettier_d_slim \
  typescript \
  neovim

luarocks install luacheck
cargo install stylua

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ~/.tmux/plugins/tpm/scripts/install_plugins.sh
fi

echo "$(tput setaf 2)Switching shell to zsh. You may need to logout.$(tput sgr 0)"

sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)

exit 0
