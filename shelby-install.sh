#!/usr/bin/env bash
# ============================================================
#   ____  _   _ _____ _     ______   __
#  / ___|| | | | ____| |   | __ ) \ / /
#  \___ \| |_| |  _| | |   |  _ \\ V /
#   ___) |  _  | |___| |___| |_) || |
#  |____/|_| |_|_____|_____|____/ |_|
#
#   Shelby Quickstart — 1-Click Installer
#   by .87🌵 | x.com/ofalamin | t.me/Labs87
# ============================================================

set -euo pipefail

# ── Colours ──────────────────────────────────────────────────
RESET="\033[0m"
BOLD="\033[1m"
PURPLE="\033[0;35m"
CYAN="\033[0;36m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
DIM="\033[2m"

# ── Helpers ───────────────────────────────────────────────────
banner() {
  echo ""
  echo -e "${PURPLE}${BOLD}╔══════════════════════════════════════════════════════════╗${RESET}"
  echo -e "${PURPLE}${BOLD}║          SHELBY QUICKSTART — 1-Click Installer           ║${RESET}"
  echo -e "${PURPLE}${BOLD}║          by .87🌵  |  t.me/Labs87  |  @ofalamin          ║${RESET}"
  echo -e "${PURPLE}${BOLD}╚══════════════════════════════════════════════════════════╝${RESET}"
  echo ""
}

step() {
  echo -e "\n${CYAN}${BOLD}━━━  $1${RESET}"
}

ok() {
  echo -e "  ${GREEN}✔${RESET}  $1"
}

warn() {
  echo -e "  ${YELLOW}⚠${RESET}  $1"
}

fail() {
  echo -e "\n  ${RED}✖  ERROR: $1${RESET}"
  echo -e "  ${DIM}If you're stuck, drop by t.me/Labs87 for help.${RESET}\n"
  exit 1
}

info() {
  echo -e "  ${DIM}→  $1${RESET}"
}

confirm() {
  read -rp "$(echo -e "  ${YELLOW}?${RESET}  $1 [y/N]: ")" ans
  [[ "$(echo "$ans" | tr '[:upper:]' '[:lower:]')" == "y" ]]
}

# ── OS Detection ─────────────────────────────────────────────
detect_os() {
  OS="$(uname -s)"
  case "$OS" in
    Linux*)   PLATFORM="linux"  ;;
    Darwin*)  PLATFORM="macos"  ;;
    *)        fail "Unsupported OS: $OS. Only Linux and macOS are supported." ;;
  esac
  ok "Platform: ${BOLD}$OS${RESET}"
}

# ── Dependency: git ───────────────────────────────────────────
check_git() {
  if ! command -v git &>/dev/null; then
    fail "git is not installed. Please install git and re-run this script."
  fi
  ok "git $(git --version | awk '{print $3}') found"
}

# ── Dependency: Node v22+ ─────────────────────────────────────
check_node() {
  if ! command -v node &>/dev/null; then
    warn "Node.js not found. Attempting to install via nvm…"
    install_node
    return
  fi

  NODE_VER=$(node -e "process.stdout.write(process.version.slice(1))")
  NODE_MAJOR=$(echo "$NODE_VER" | cut -d. -f1)

  if [[ "$NODE_MAJOR" -lt 22 ]]; then
    warn "Node.js v${NODE_VER} detected — v22+ is required."
    if confirm "Install Node v22 via nvm?"; then
      install_node
    else
      fail "Please upgrade Node.js to v22+ and re-run."
    fi
  else
    ok "Node.js v${NODE_VER} found"
  fi
}

install_node() {
  info "Installing nvm…"
  curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

  export NVM_DIR="$HOME/.nvm"
  # shellcheck source=/dev/null
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

  nvm install 22
  nvm use 22
  nvm alias default 22
  ok "Node.js v22 installed via nvm"
}

# ── Dependency: npm/pnpm ──────────────────────────────────────
check_pkg_manager() {
  if command -v pnpm &>/dev/null; then
    PKG="pnpm"
    ok "pnpm $(pnpm --version) found (preferred)"
  elif command -v npm &>/dev/null; then
    PKG="npm"
    ok "npm $(npm --version) found"
  else
    fail "No package manager found. Install npm or pnpm and re-run."
  fi
}

# ── Dependency: Shelby CLI ────────────────────────────────────
check_shelby_cli() {
  if command -v shelby &>/dev/null; then
    ok "Shelby CLI found: $(shelby --version 2>/dev/null || echo 'installed')"
  else
    warn "Shelby CLI not found."
    echo ""
    echo -e "  ${YELLOW}${BOLD}Install the Shelby CLI first:${RESET}"
    echo -e "  ${DIM}https://docs.shelby.xyz/tools/cli${RESET}"
    echo ""
    if confirm "Continue anyway? (you can install CLI after cloning)"; then
      warn "Continuing without Shelby CLI — install it before running npm run config"
    else
      fail "Please install the Shelby CLI first: https://docs.shelby.xyz/tools/cli"
    fi
  fi
}

# ── Dependency: Aptos CLI ─────────────────────────────────────
check_aptos_cli() {
  if command -v aptos &>/dev/null; then
    ok "Aptos CLI found: $(aptos --version 2>/dev/null | head -1 || echo 'installed')"
  else
    warn "Aptos CLI not found."
    echo ""
    echo -e "  ${YELLOW}${BOLD}Install the Aptos CLI first:${RESET}"
    echo -e "  ${DIM}https://aptos.dev/build/cli${RESET}"
    echo ""
    if confirm "Continue anyway? (you can install Aptos CLI after cloning)"; then
      warn "Continuing without Aptos CLI — install it before running npm run config"
    else
      fail "Please install the Aptos CLI first: https://aptos.dev/build/cli"
    fi
  fi
}

# ── Clone / Pull repo ─────────────────────────────────────────
REPO_URL="https://github.com/shelby/shelby-quickstart.git"
CLONE_DIR="shelby-quickstart"

setup_repo() {
  if [[ -d "$CLONE_DIR/.git" ]]; then
    warn "Directory '${CLONE_DIR}' already exists."
    if confirm "Pull latest changes instead of re-cloning?"; then
      cd "$CLONE_DIR"
      git pull
      ok "Repository updated"
      cd ..
    else
      info "Skipping clone — using existing directory."
    fi
  else
    info "Cloning shelby/shelby-quickstart…"
    git clone "$REPO_URL" "$CLONE_DIR"
    ok "Repository cloned → ./${CLONE_DIR}"
  fi
}

# ── Install deps + build ──────────────────────────────────────
build_project() {
  cd "$CLONE_DIR"

  step "Installing dependencies"
  $PKG install
  ok "Dependencies installed"

  step "Building project"
  $PKG run build
  ok "Build complete"
}

# ── Run config ────────────────────────────────────────────────
run_config() {
  echo ""
  echo -e "${PURPLE}${BOLD}╔══════════════════════════════════════════════════════════╗${RESET}"
  echo -e "${PURPLE}${BOLD}║                  Setup Complete! 🎉                      ║${RESET}"
  echo -e "${PURPLE}${BOLD}╚══════════════════════════════════════════════════════════╝${RESET}"
  echo ""
  echo -e "  ${GREEN}${BOLD}You're ready to go. Next steps:${RESET}"
  echo ""
  echo -e "  ${CYAN}1.${RESET}  ${BOLD}Configure your dev account:${RESET}"
  echo -e "      ${DIM}cd ${CLONE_DIR} && ${PKG} run config${RESET}"
  echo ""
  echo -e "  ${CYAN}2.${RESET}  ${BOLD}Fund your address:${RESET}"
  echo -e "      ${DIM}ShelbyUSD → https://docs.shelby.xyz/apis/faucet/shelbyusd${RESET}"
  echo -e "      ${DIM}Aptos     → https://docs.shelby.xyz/apis/faucet/aptos${RESET}"
  echo ""
  echo -e "  ${CYAN}3.${RESET}  ${BOLD}Try the CLI commands:${RESET}"
  echo -e "      ${DIM}${PKG} run upload   — upload a blob to Shelby${RESET}"
  echo -e "      ${DIM}${PKG} run list     — list blobs for an account${RESET}"
  echo -e "      ${DIM}${PKG} run download — download a blob locally${RESET}"
  echo -e "      ${DIM}${PKG} run dev      — watch mode for development${RESET}"
  echo ""
  echo -e "  ${DIM}📖  Docs:     https://docs.shelby.xyz/tools/cli${RESET}"
  echo -e "  ${DIM}💬  Community: t.me/Labs87${RESET}"
  echo -e "  ${DIM}🐦  Updates:  x.com/ofalamin${RESET}"
  echo ""

  if confirm "Launch 'npm run config' now to set up your account?"; then
    echo ""
    $PKG run config
  else
    info "Run '${PKG} run config' inside ./${CLONE_DIR} whenever you're ready."
  fi
}

# ── Entry point ───────────────────────────────────────────────
main() {
  clear
  banner

  step "Checking system requirements"
  detect_os
  check_git
  check_node
  check_pkg_manager
  check_shelby_cli
  check_aptos_cli

  step "Setting up Shelby Quickstart"
  setup_repo

  step "Installing & building"
  build_project

  run_config
}

main "$@"
