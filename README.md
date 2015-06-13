# dotfiles

## Overview
This repository includes settings below:

  * bash
  * git
  * vim
  * tmux

## Usage
Clone this repository into your home directory.  
Then, run `install.sh`.

After that, you can edit or do the following things.

  * git
    - Configure with running `git config --global ...`
      + user.name
      + user.email
  * vim
    - Run vim.
    - Enter `:NeoBundleInstall`
  * tmux
    - Edit `.tmux.conf` as necessary.
      + prefix key
      + status-bg
      + window-status-current-fg
      + pane-active-border-fg
    - See also `tmux/tmux_color.md`

## Notes
  * Some file names begin with `_` to load first.

