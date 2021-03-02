#!/bin/sh

INSTALLDIR=$PWD

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Checking for Homebrew installation.$(tput sgr 0)"
echo "---------------------------------------------------------"

brew="/usr/local/bin/brew"
if [ -f "$brew" ]; then
    echo "---------------------------------------------------------"
    echo "$(tput setaf 2)Homebrew is installed.$(tput sgr 0)"
    echo "---------------------------------------------------------"
else
    echo "---------------------------------------------------------"
    echo "$(tput setaf 3)Installing Homebrew. Homebrew requires osx command lines tools, please download xcode first$(tput sgr 0)"
    echo "---------------------------------------------------------"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "---------------------------------------------------------"
echo "$(tput setaf 2) Installing brew packages from Brewfile.$(tput sgr 0)"
echo "---------------------------------------------------------"

if command -v brew >/dev/null 2>&1; then
    brew bundle
fi

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Installing Python NeoVim client.$(tput sgr 0)"
echo "---------------------------------------------------------"

pip install neovim
pip3 install neovim

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Installing node neovim package$(tput sgr 0)"
echo "---------------------------------------------------------"

npm install -g neovim

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Installing vim linter (vint)$(tput sgr 0)"
echo "---------------------------------------------------------"

pip3 install vim-vint

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Installing bash language server$(tput sgr 0)"
echo "---------------------------------------------------------"

npm i -g bash-language-server

localGit="/usr/local/bin/git"
if ! [[ -f "$localGit" ]]; then
    echo "---------------------------------------------------------"
    echo "$(tput setaf 1)Invalid git installation. Aborting. Please install git.$(tput sgr 0)"
    echo "---------------------------------------------------------"
    exit 1
fi

# Create backup folder if it doesn't exist
mkdir -p ~/.local/share/nvim/backup

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Installing oh-my-zsh.$(tput sgr 0)"
echo "---------------------------------------------------------"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
    echo "---------------------------------------------------------"
    echo "$(tput setaf 2)oh-my-zsh already installed.$(tput sgr 0)"
    echo "---------------------------------------------------------"
fi

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Installing zsh-autosuggestions.$(tput sgr 0)"
echo "---------------------------------------------------------"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Installing pyenv.$(tput sgr 0)"
echo "---------------------------------------------------------"
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

eval "$(pyenv init - --no-rehash)"

pyenv install 2.7.15
pyenv install 3.6.7

pyenv virtualenv 2.7.15 neovim2
pyenv virtualenv 3.6.7 neovim3

pyenv activate neovim2
pip install neovim

pyenv activate neovim3
pip install neovim

# The following is optional, and the neovim3 env is still active
# This allows flake8 to be available to linter plugins regardless
# of what env is currently active.  Repeat this pattern for other
# packages that provide cli programs that are used in Neovim.
pip install flake8
ln -s `pyenv which flake8` ~/bin/flake8

sudo gem install neovim

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Installing vtop.$(tput sgr 0)"
echo "---------------------------------------------------------"
npm install -g vtop

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Installing Neovim plugins and linking dotfiles.$(tput sgr 0)"
echo "---------------------------------------------------------"

sh install/backup.sh
sh install/link.sh
nvim +PlugInstall +qall
nvim +UpdateRemotePlugins +qall

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Installing tmux plugin manager.$(tput sgr 0)"
echo "---------------------------------------------------------"

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ~/.tmux/plugins/tpm/scripts/install_plugins.sh
fi

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Switching shell to zsh. You may need to logout.$(tput sgr 0)"
echo "---------------------------------------------------------"

sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)

echo "---------------------------------------------------------"
echo "$(tput setaf 2)System update complete. Currently running at 100% power. Enjoy.$(tput sgr 0)"
echo "---------------------------------------------------------"

defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 10
cp .rgignore ~/.rgignore
tic -x tmux-256color.terminfo
tic -x xterm-256color-italic.terminfo

exit 0
