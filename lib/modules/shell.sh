#!/usr/bin/env bash
# =============================================================================
# Shell tools installation (shfmt, shellcheck)
# =============================================================================

install_shell_tools() {
  log_step "Installing Shell tools..."

  local install_cmd=""

  case "$PACKAGE_MANAGER" in
  apt)
    install_cmd="apt-get install -y shellcheck"
    # shfmt needs go or download binary
    if cmd_exists go; then
      go install mvdan.cc/sh/v3/cmd/shfmt@latest
    else
      log_info "Installing shfmt from binary..."
      local shfmt_version="v3.8.0"
      local shfmt_url="https://github.com/mvdan/sh/releases/download/${shfmt_version}/shfmt_${shfmt_version}_linux_amd64"
      curl -sSL "$shfmt_url" -o /usr/local/bin/shfmt
      chmod +x /usr/local/bin/shfmt
    fi
    ;;
  dnf | yum)
    install_cmd="dnf install -y shellcheck"
    # Install shfmt from binary
    local shfmt_version="v3.8.0"
    local shfmt_url="https://github.com/mvdan/sh/releases/download/${shfmt_version}/shfmt_${shfmt_version}_linux_amd64"
    curl -sSL "$shfmt_url" -o /usr/local/bin/shfmt
    chmod +x /usr/local/bin/shfmt
    ;;
  pacman)
    install_cmd="pacman -S --noconfirm shellcheck shfmt"
    ;;
  brew)
    install_cmd="brew install shellcheck shfmt"
    ;;
  apk)
    install_cmd="apk add --no-cache shellcheck shfmt"
    ;;
  *)
    log_error "Unsupported package manager: $PACKAGE_MANAGER"
    return 1
    ;;
  esac

  # Install shellcheck
  if ! cmd_exists shellcheck; then
    log_info "Installing shellcheck..."
    eval "$install_cmd"
  else
    log_success "shellcheck: already installed"
  fi

  # Install shfmt
  if ! cmd_exists shfmt; then
    log_info "Installing shfmt..."
    case "$PACKAGE_MANAGER" in
    apt)
      if ! cmd_exists go; then
        apt-get install -y golang-go
      fi
      go install mvdan.cc/sh/v3/cmd/shfmt@latest
      ;;
    *)
      # Already handled above
      ;;
    esac
    # Ensure shfmt is in PATH
    if [[ -f "$HOME/go/bin/shfmt" ]]; then
      ln -sf "$HOME/go/bin/shfmt" /usr/local/bin/shfmt 2>/dev/null || true
    fi
  else
    log_success "shfmt: already installed"
  fi

  # Verify installation
  if cmd_exists shellcheck && cmd_exists shfmt; then
    log_success "Shell tools installed successfully!"
    log_success "  - shellcheck: $(shellcheck --version | head -1)"
    log_success "  - shfmt: $(shfmt --version)"
  else
    log_warn "Some shell tools may not be installed"
  fi
}
