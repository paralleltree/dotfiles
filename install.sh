#!/bin/bash
set -eu

# Variables
DOTPATH=${DOTPATH:-$HOME/.dotfiles}
REPO="https://github.com/paralleltree/dotfiles"

# Logging utilities
# colorize [color] [text]
colorize() {
  # use Select Graphic Rendition command to colorize
  local esc="\033["
  local reset="0m"
  local color
  case "$1" in
    red ) color="1;31m" ;;
    green ) color="1;32m" ;;
    yellow ) color="1;33m" ;;
    blue ) color="1;34m" ;;
    gray ) color="1;30m" ;;
    white | none ) color="$reset" ;;
    * )
      echo 'Usage: colorize [color] [text]' >&2
      return 1
      ;;
  esac
  local text="$2"
  printf "${esc}${color}${text}${esc}${reset}"
}

# [log level] [message]
print_log() {
  local message="$2"
  local color
  case "$1" in
    INFO ) color=blue ;;
    SUCCESS ) color=green ;;
    ERROR ) color=red ;;
    * )
      echo 'Usage: print_log [log level] [message]' >&2
      return 1
      ;;
  esac

  colorize gray "["
  colorize "$color" "$1"
  colorize gray "]"
  echo " $message"
}

log_info() {
  print_log INFO "$1"
}

log_success() {
  print_log SUCCESS "$1"
}

log_fail() {
  print_log ERROR "$1"
}

# Setup utilities
has() {
  type "$1" > /dev/null 2>&1 || (log_fail "$1 not found." && false)
}

check_requirements() {
  log_info "Checking requirements..."
  (
    has git &&
    has make &&
    :
  ) && log_success "All required commands available." || {
    log_fail "Required command not found. Exiting."
    exit 1
  }
}

# Setup actions
setup_repo() {
  log_info "Cloning repository..."
  if [ -d "$DOTPATH" ]; then
    log_info "dotfiles already exists. Skipping."
  else
    git clone "$REPO" "$DOTPATH" && log_success "Successfully cloned." || {
      log_fail "Failed to clone repository. Exiting."
      exit 1
    }
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
    make install && log_success "Successfully installed." || {
      log_fail "Could not install dotfiles. Exiting."
      exit 1
    }
  )
}


# Setup
check_requirements && setup_repo && install
