<div align="center">
  <strong>(Neo)Vim of the Future</strong>
</div>
<div align="center">
  My personal dotfiles, which turn a ZSH shell into a full development environment
</div>
<br/>

<div align="center">
  <img src="https://i.redditmedia.com/5hM6ZNO1nVaGShnp78BRFuGtXcnDDNftA-7cc6aINFI.png?s=10cc17271fc5823361cb4e238183fc1b" />
</div>

<div align="center">
  <img src="https://i.imgur.com/2rqF24f.png" alt="Jarvis SS"/>
</div>
<br/>

## Table of Contents
- [Features](#features)
- [Installation](#installation)
- [Commands](#commands)
- [Support](#support)

## Features

The following are features provided by Jarvis. They all have quick keybindings to make them quick and easy to use.

1. **Quick-open files** - *zsh* & *NeoVim*

    Open files with simple keystrokes with fuzzy matching via command line and inside NeoVim.

    <img src="https://i.imgur.com/QgtsoRL.gif" height="400px"/>

2. **Asynchronous linting** - *NeoVim*

	For Typescript/Javascript development, code is linted asynchronously with [coc-eslint](https://github.com/neoclide/coc-eslint) and automatically formatted via [coc-prettier](https://github.com/neoclide/coc-prettier) on file save to conform to [prettier](https://prettier.io/) standards.

	<img src="https://i.imgur.com/Tnh6e0z.gif" height="400px"/>

3. **Session management** - *Tmux* and *zsh/fzf*

	Create sessions for each project with a custom layout. Quickly browse, create, and delete sessions. Tmux even keeps sessions alive if the terminal is closed. Using `fzf` and `zsh`, you can create or switch to sessions easily, as well as delete session by name or fuzzy-search.

	<img src="https://i.imgur.com/r9rXyeL.gif" height="400px"/>

4. **Keyword auto-complete** - *NeoVim* and *zsh*

    Neovim - Automatic, asynchronous keyword completion available in the current buffer via [coc.nvim](https://github.com/neoclide/coc.nvim). It's powered by the same language server extensions as VSCode. It also supports the new "floating window" feature so you can finally have syntax highlighting in your completion windows!

    <img src="https://i.imgur.com/AsXMuHA.gif" width="100%"/>

	A variety of languages are supported by coc.nvim. I currently use a pretty standard set for web development that I will continue to tweak as needed.
	  - [Typescript/Javascript](https://github.com/neoclide/coc-tsserver): `:CocInstall coc-tsserver`
	  - [Eslint](https://github.com/neoclide/coc-eslint): `:CocInstall coc-eslint`
	  - [Prettier](https://github.com/neoclide/coc-prettier): `:CocInstall coc-prettier`
	  - [CSS](https://github.com/neoclide/coc-css): `:CocInstall coc-css`
	  - [json](https://github.com/neoclide/coc-json): `:CocInstall coc-json`

5. **Fuzzy search through CWD with Ripgrep and FZF** - *NeoVim*

    Quickly fuzzy find code or files in your current working directory using floating windows and FZF/Ripgrep. `CTRL-p` will open a floating window (with previews) to fuzzy find files in your current working directory.
    `<Leader>ff` will open a floating window to fuzzy find within the files in your current working directory.

## Installation

I've done my best to make the script install all the needed pieces to get up and running, however it's hard to be sure that it will work for all development environments.
Run the `install.sh` script and upon completion, you can run `:checkhealth` from within `nvim` to ensure the installation is working properly.

## Commands

See the [Commands Guide](docs/COMMANDS.md) for a list of mappings/shortcuts.

## Support

If you find any problems or bugs, please open a new [issue](https://github.com/monsonjeremy/dotfiles/issues).
