#!/bin/bash
set -eu

# Variables
DOTPATH=${DOTPATH:-$HOME/.dotfiles}
REPO="https://github.com/paralleltree/dotfiles"

# Logging utilities
# [log level] [message]
print_log() {
  echo "[$1] $2"
}

log_info() {
  print_log INFO "$1"
}

log_success() {
  print_log SUCCESS "$1"
}

log_fail() {
  print_log ERROR "$1" >&2
}

# Setup utilities
has() {
  type "$1" > /dev/null 2>&1 || (log_fail "$1 not found." && false)
}

check_requirements() {
  log_info "Checking requirements..."
  (
    has git &&
    has make
  ) || false
}

# Setup actions
setup_repo() {
  log_info "Cloning repository..."
  if [ -d "$DOTPATH" ]; then
    log_info "dotfiles already exists. Skipping."
  else
    git clone "$REPO" "$DOTPATH"
  fi
}

install() {
  (
    if [ ! -d "$DOTPATH" ]; then
      log_fail "$DOTPATH not found. Exiting."
      exit 1
    fi

    cd "$DOTPATH"

    log_info "Installing dotfiles..."
    make install && log_success "Successfully installed."
  )
}

# Setup
if ! check_requirements; then
  log_fail "Required command not found. Exiting."
  exit 1
fi

setup_repo && install
