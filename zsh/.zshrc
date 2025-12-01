# Path to oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
export GEM_HOME="$HOME/.gem"
export PATH="$PATH:$GEM_HOME/bin"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

eval "$(fnm env --use-on-cd)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# TMUX
# Automatically start tmux
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOQUIT=false
ZSH_TMUX_AUTOCONNECT=true

# Disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(tmux)

# User configuration
# Hide user@hostname if it's expected default user
DEFAULT_USER=$(whoami)
prompt_context() {}

# Enabled zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# Enable autosuggestions automatically
zle-line-init() {
    zle autosuggest-start
}

source $ZSH/oh-my-zsh.sh

alias ls="eza -a --tree -L 1"
alias ll="eza --tree --level=2 -a --long --header --accessed --git"
source ~/.functions

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/jmonson/miniconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/jmonson/miniconda/etc/profile.d/conda.sh" ]; then
        . "/Users/jmonson/miniconda/etc/profile.d/conda.sh"
    else
        export PATH="/Users/jmonson/miniconda/bin:$PATH"
    fi
fi

unset __conda_setup
# <<< conda initialize <<<


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

autoload -Uz compinit
compinit
# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

source ~/perl5/perlbrew/etc/bashrc

export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
export PNPM_HOME="/Users/jmonson/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# bun completions
[ -s "/opt/homebrew/Cellar/bun/1.0.1/share/zsh/site-functions/_bun" ] && source "/opt/homebrew/Cellar/bun/1.0.1/share/zsh/site-functions/_bun"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# GoLang
export GOROOT=/Users/jeremymonson/.go
export PATH=$GOROOT/bin:$PATH
export GOPATH=/Users/jeremymonson/go
export PATH=$GOPATH/bin:$PATH
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/opt/homebrew/opt/jpeg/bin:$PATH"
export PATH="$HOME/.elixir-install/installs/otp/27.1.2/erts-15.1.2/bin:$PATH"
export PATH="$HOME/.elixir-install/installs/elixir/1.17.3-otp-27/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"

# Added by Antigravity
export PATH="/Users/jeremy.monson/.antigravity/antigravity/bin:$PATH"
