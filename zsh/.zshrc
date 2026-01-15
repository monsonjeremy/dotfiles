eval "$(mise activate zsh)"
eval "$(starship init zsh)"

# Antidote (Plugin Manager)
# Clone antidote if necessary
if [[ ! -d ${ZDOTDIR:-~}/.antidote ]]; then
  git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
fi

# Source antidote
source ${ZDOTDIR:-~}/.antidote/antidote.zsh

# Initialize plugins
antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt

# Completion handled by antidote (ohmyzsh/lib/completion.zsh)

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

alias ls="eza -a --tree -L 1"
alias ll="eza --tree --level=2 -a --long --header --accessed --git"
source ~/.functions

# Completion for kitty
kitty + complete setup zsh | source /dev/stdin



export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
export PNPM_HOME="/Users/jmonson/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# bun completions
[ -s "/opt/homebrew/Cellar/bun/1.0.1/share/zsh/site-functions/_bun" ] && source "/opt/homebrew/Cellar/bun/1.0.1/share/zsh/site-functions/_bun"





# GoLang
# GOROOT/GOPATH managed by mise or default


# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Homebrew & System
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"

# PNPM
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Elixir (if not managed by mise yet)
export PATH="$HOME/.elixir-install/installs/otp/27.1.2/erts-15.1.2/bin:$PATH"
export PATH="$HOME/.elixir-install/installs/elixir/1.17.3-otp-27/bin:$PATH"

# Added by Antigravity
export PATH="/Users/jeremy.monson/.antigravity/antigravity/bin:$PATH"
