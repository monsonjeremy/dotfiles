# Skip prompt/plugin bootstrap in non-TTY shells (e.g. agent command runners).
# Environment variables belong in .zshenv and remain available there.
[[ -t 0 || -t 1 ]] || return
# Skip prompt/plugin bootstrap for zsh command strings (`zsh -c` / `zsh -ic`).
[[ -n "${ZSH_EXECUTION_STRING:-}" ]] && return

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

antidote_plugins="${ZDOTDIR:-$HOME}/.zsh_plugins.txt"
antidote_source=""
for candidate in /opt/homebrew/opt/antidote/share/antidote/antidote.zsh /usr/local/opt/antidote/share/antidote/antidote.zsh; do
  if [[ -f "$candidate" ]]; then
    antidote_source="$candidate"
    break
  fi
done

# Antidote (Plugin Manager)
if [[ -n "$antidote_source" ]]; then
  source "$antidote_source"
  [[ -f "$antidote_plugins" ]] && antidote load "$antidote_plugins"
elif [[ -t 1 ]]; then
  echo "zsh: antidote not found in Homebrew prefix (install with: brew install antidote)" >&2
fi

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

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

# Virtualenv activation
if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
    source "${VIRTUAL_ENV}/bin/activate"
fi

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init - --no-rehash)"
fi

# FZF
FD_OPTIONS="--type f --hidden --follow --exclude .git/ --exclude node_modules"
export FZF_DEFAULT_OPTS="
--border
--margin=1,2
--no-sort
--layout=reverse
--preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --theme='OneHalfDark' --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300'
--bind='f2:toggle-preview'"

export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --header 'Press CTRL-Y to copy command into clipboard'"

if command -v fd > /dev/null; then
  export FZF_DEFAULT_COMMAND="fd $FD_OPTIONS"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND='fd --type f --type d --hidden --follow --exclude .git'
fi

command -v bat  > /dev/null && export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {} --theme='OneHalfDark''"
command -v blsd > /dev/null && export FZF_ALT_C_COMMAND='blsd'
command -v tree > /dev/null && export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# eza
alias ls="eza -a --tree -L 1"
alias ll="eza --tree --level=2 -a --long --header --accessed --git"

[[ -f "$HOME/.functions" ]] && source "$HOME/.functions"

# Completion for kitty
if command -v kitty >/dev/null 2>&1; then
  kitty + complete setup zsh 2>/dev/null | source /dev/stdin
fi

# Aliases

# Reload .zshrc
alias reload='source ~/.zshrc && source ~/.zshenv && echo "Loaded ~/.zshrc"'

# Preferred implementations
alias cp='cp -iv'
alias mkdir='mkdir -pv'
alias mv='mv -iv'
alias rmrf='rm -rf'
alias sshnc='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
alias code='code-insiders .'

if command -v vtop >/dev/null 2>&1; then
  alias top="vtop --theme=wizard"
fi
alias v='nvim'

# Git aliases
alias g='git'
alias ga='git add'
alias ga.='git add .'
alias gb='git branch'
alias gc='git commit'
alias gca='git commit --amend'
alias gco='git checkout'
alias gco.='git checkout .'
alias gd='git diff'
alias gd.='git diff .'
alias gf='git fetch --prune'
alias gl="git --no-pager log --oneline --pretty=tformat:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit $1 $2"
alias gm='git merge'
alias gpu='git push'
alias gpuf='git push --force'
alias gpd='git pull --rebase'
alias gr='git rebase -i'
alias gs='git status'
alias gcm="git checkout main"
alias gpm="git pull origin main"
alias gcb="git checkout -b"
alias ghold="git add --all && git commit -n -m \"WIP\""

# tmux aliases
alias t='tmux'
alias ts='tmux new -s'
alias ta='tmux attach -t'
alias tl='tmux ls'
alias tk='tmux kill-session -t'

# Neovim/Vim aliases
if command -v nvim >/dev/null 2>&1; then
    alias vim='nvim'
fi

# Bundler
alias b="bundle"

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'
alias dev='npm run dev'

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

# Shortcuts
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias sl="cd ~/Desktop/Surfline"

# Always enable colored `grep` output
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Enable aliases to be sudo'ed
alias sudo='sudo '

# Get week number
alias week='date +%V'

# Get macOS Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update; sudo gem cleanup'

# Google Chrome
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias canary='/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Flush Directory Service cache
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

# Clean up LaunchServices to remove duplicates in the "Open With" menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# Canonical hex dump; some systems have this symlinked
command -v hd >/dev/null || alias hd="hexdump -C"

# macOS has no `md5sum`, so use `md5` as a fallback
command -v md5sum >/dev/null || alias md5sum="md5"

# macOS has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum >/dev/null || alias sha1sum="shasum"

# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple's System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# URL-encode strings
alias urlencode='python3 -c "import sys, urllib.parse as ul; print(ul.quote_plus(sys.argv[1]))"'

# Merge PDF files
# Usage: `mergepdf -o output.pdf input{1,2,3}.pdf`
alias mergepdf='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'

# Disable Spotlight
alias spotoff="sudo mdutil -a -i off"
# Enable Spotlight
alias spoton="sudo mdutil -a -i on"

# PlistBuddy alias, because sometimes `defaults` just doesn't cut it
alias plistbuddy="/usr/libexec/PlistBuddy"

# Airport CLI alias
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# One of @janmoesen's ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
    alias "${method}"="lwp-request -m '${method}'"
done

# Make Grunt print stack traces by default
command -v grunt >/dev/null && alias grunt="grunt --stack"

# Stuff I never really use but cannot delete either because of http://xkcd.com/530/
alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="osascript -e 'set volume output volume 100'"

# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

# Lock the screen (when going AFK)
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# bun completions
for bun_completion_file in /opt/homebrew/share/zsh/site-functions/_bun /usr/local/share/zsh/site-functions/_bun; do
  if [[ -s "$bun_completion_file" ]]; then
    source "$bun_completion_file"
    break
  fi
done

# Optional machine-local interactive overrides (never committed).
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
export PATH="$HOME/.local/bin:$PATH"
