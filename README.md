# My configuration files

## Installation

1. Go to `~` directory
2. Clone the repository with `git clone`
3. Go to `dotfiles` directory
4. Run `stow <dir>` for the configurations you want to inject

### How GNU Stow works
All the configuration files are managed by GNU Stow. Run `stow <dir>` to
generate symlinks for a given service/program (e.g. bash) in the parent
directory to where the command was run. In this case, the dotfiles
directory is designed to be located in the `~` home directory, so that's
where Stow will generate the symlinks.

**Example**: running `stow bash` in `~/dotfiles` will generate symlinks for
all the files in `~/dotfiles/bash` inside the `~` directory.
As a result the `~` directory will be populated with symlinks to:
 - `~/dotfiles/bash/.bashrc`
 - `~/dotfiles/bash/.bash_profile`

## What's in the files
- [zsh](https://www.zsh.org) configuration
- [bash](https://www.gnu.org/software/bash/) configuration, aliases etc.
- [git](https://git-scm.com) configuration
- [vim](https://www.vim.org) configuration
- [neovim](https://neovim.io) configuration
- [ranger](https://ranger.github.io) configuration
- [tmux](https://github.com/tmux/tmux/wiki) configuration
- [Homebrew](https://brew.sh) file
