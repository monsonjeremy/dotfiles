# Path to oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(fnm env)"
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

alias ls="exa -a --tree -L 1"
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

. /opt/homebrew/opt/asdf/asdf.sh
