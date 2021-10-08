alias tmux='tmux -2'

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export FZF_PREVIEW_COMMAND="cat {}" # avoid syntax highlighting

if [ -e ~/.bashrc_local ]; then
  source ~/.bashrc_local
fi

if [ -d "$HOME/.cargo" ]; then
  . "$HOME/.cargo/env"
fi
