#!/usr/bin/env bash
# =============================================================================
# bootstrap-sync.sh — Bootstrap the agentic framework into an existing project
#
# Installs two things into your project:
#   1. scripts/sync-framework.sh  — bidirectional sync with this repo
#   2. .agentic-framework/        — isolated local clone (git-ignored)
#
# Then runs an initial pull so agents/, skills/, mcp-servers/, templates/,
# shared/, and select docs/ content are immediately available.
#
# Usage — run from within the framework repo clone:
#   ./scripts/bootstrap-sync.sh /path/to/my-project
#
# Usage — one-liner from anywhere (no local checkout needed):
#   curl -fsSL https://raw.githubusercontent.com/clausfonnesbech/agentic-framework/main/scripts/bootstrap-sync.sh \
#     | bash -s -- /path/to/my-project
#
# If no path is given, the current directory is used.
# =============================================================================

set -euo pipefail

FRAMEWORK_REPO="https://github.com/clausfonnesbech/agentic-framework.git"
FRAMEWORK_BRANCH="main"
RAW_BASE="https://raw.githubusercontent.com/clausfonnesbech/agentic-framework/main"

BOLD='\033[1m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
RESET='\033[0m'

info()    { echo -e "${CYAN}→ $*${RESET}"; }
success() { echo -e "${GREEN}✓ $*${RESET}"; }
warn()    { echo -e "${YELLOW}⚠  $*${RESET}"; }

# --------------------------------------------------------------------------- #
TARGET="${1:-$PWD}"

if [[ ! -d "$TARGET" ]]; then
  echo "Error: target directory '$TARGET' does not exist."
  exit 1
fi

TARGET="$(cd "$TARGET" && pwd)"   # normalize to absolute path
SCRIPTS_DIR="$TARGET/scripts"
FRAMEWORK_DIR="$TARGET/.agentic-framework"
GITIGNORE="$TARGET/.gitignore"

echo ""
echo -e "${BOLD}Agentic Framework Bootstrap${RESET}"
echo -e "Target project: ${CYAN}$TARGET${RESET}"
echo ""

# --------------------------------------------------------------------------- #
# 1. Create scripts/ and install sync-framework.sh
# --------------------------------------------------------------------------- #
info "Installing scripts/sync-framework.sh ..."
mkdir -p "$SCRIPTS_DIR"

# If running from a local clone of the framework repo, copy directly.
# Otherwise, download from GitHub.
SELF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -f "$SELF_DIR/sync-framework.sh" ]]; then
  cp "$SELF_DIR/sync-framework.sh" "$SCRIPTS_DIR/sync-framework.sh"
else
  curl -fsSL "$RAW_BASE/scripts/sync-framework.sh" -o "$SCRIPTS_DIR/sync-framework.sh"
fi
chmod +x "$SCRIPTS_DIR/sync-framework.sh"
success "scripts/sync-framework.sh installed."

# --------------------------------------------------------------------------- #
# 2. Add .agentic-framework/ to .gitignore
# --------------------------------------------------------------------------- #
info "Updating .gitignore ..."
if [[ -f "$GITIGNORE" ]]; then
  if grep -qF ".agentic-framework/" "$GITIGNORE"; then
    warn ".agentic-framework/ already in .gitignore — skipping."
  else
    echo "" >> "$GITIGNORE"
    echo "# Agentic framework local clone (managed by scripts/sync-framework.sh)" >> "$GITIGNORE"
    echo ".agentic-framework/" >> "$GITIGNORE"
    success ".gitignore updated."
  fi
else
  cat > "$GITIGNORE" <<'EOF'
# Agentic framework local clone (managed by scripts/sync-framework.sh)
.agentic-framework/
EOF
  success ".gitignore created."
fi

# --------------------------------------------------------------------------- #
# 3. Clone the framework repo
# --------------------------------------------------------------------------- #
if [[ -d "$FRAMEWORK_DIR/.git" ]]; then
  warn ".agentic-framework/ already cloned — skipping clone."
else
  info "Cloning agentic-framework into .agentic-framework/ ..."
  git clone "$FRAMEWORK_REPO" "$FRAMEWORK_DIR"
  success "Framework cloned."
fi

# --------------------------------------------------------------------------- #
# 4. Initial pull — populate agents/, skills/, mcp-servers/, etc.
# --------------------------------------------------------------------------- #
info "Running initial sync (pull) ..."
"$SCRIPTS_DIR/sync-framework.sh" pull

# --------------------------------------------------------------------------- #
echo ""
echo -e "${BOLD}${GREEN}Bootstrap complete!${RESET}"
echo ""
echo "Your project now has:"
echo "  scripts/sync-framework.sh   — run push/pull/status at any time"
echo "  .agentic-framework/         — isolated framework clone (git-ignored)"
echo "  agents/   skills/   mcp-servers/   templates/   shared/"
echo ""
echo "Next steps:"
echo "  ./scripts/sync-framework.sh pull    # pull latest framework updates"
echo "  ./scripts/sync-framework.sh push    # push your local changes back"
echo "  ./scripts/sync-framework.sh status  # preview pending changes"
echo ""
