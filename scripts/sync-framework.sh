#!/usr/bin/env bash
# =============================================================================
# sync-framework.sh — Bidirectional sync with the agentic-framework repo
#
# Usage:
#   ./scripts/sync-framework.sh pull           # Update local files from GitHub
#   ./scripts/sync-framework.sh push [message] # Push local changes to GitHub
#   ./scripts/sync-framework.sh status         # Show pending changes (dry-run)
#   ./scripts/sync-framework.sh init           # First-time: (re)clone the framework
#
# How it works:
#   A clone of https://github.com/clausfonnesbech/agentic-framework is kept in
#   .agentic-framework/ (git-ignored from this project). rsync keeps the agent
#   setup directories in sync between that clone and the project root so that
#   VS Code / GitHub Copilot can always find files at the expected paths.
#
# Directories managed by the framework repo:
#   agents/   skills/   mcp-servers/   templates/   shared/
#
# Docs behaviour:
#   The framework owns specific docs subdirectories (02-challenges/, reframes/)
#   and root-level .md files in docs/. Project-specific docs subdirectories
#   (01-proposals/, 02-research/, etc.) are never touched by this script.
# =============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
FRAMEWORK_DIR="$PROJECT_DIR/.agentic-framework"
FRAMEWORK_REPO="https://github.com/clausfonnesbech/agentic-framework.git"
FRAMEWORK_BRANCH="main"

# Directories synced in full (both directions)
FULL_SYNC_DIRS=("agents" "skills" "mcp-servers" "templates" "shared")

# docs/ subdirectories that belong to the framework (not project work output)
FRAMEWORK_DOC_SUBDIRS=("02-challenges" "reframes")

# Root-level files inside docs/ owned by the framework
FRAMEWORK_DOC_FILES=(
  "AZURE-PYTHON-ENHANCEMENT-PLAN.md"
  "DEVELOPMENT-AGENTS-ENHANCEMENT-SUMMARY.md"
  "IMPLEMENTATION-SUMMARY.md"
)

# --------------------------------------------------------------------------- #
BOLD='\033[1m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
RESET='\033[0m'

info()    { echo -e "${CYAN}→ $*${RESET}"; }
success() { echo -e "${GREEN}✓ $*${RESET}"; }
warn()    { echo -e "${YELLOW}⚠  $*${RESET}"; }
# --------------------------------------------------------------------------- #

ensure_clone() {
  if [[ ! -d "$FRAMEWORK_DIR/.git" ]]; then
    info "Cloning agentic-framework into .agentic-framework/ ..."
    git clone "$FRAMEWORK_REPO" "$FRAMEWORK_DIR"
    success "Clone complete."
  fi
}

cmd_init() {
  if [[ -d "$FRAMEWORK_DIR/.git" ]]; then
    warn ".agentic-framework/ already exists. To re-clone, delete it first:"
    echo "  rm -rf .agentic-framework && ./scripts/sync-framework.sh init"
    exit 1
  fi
  ensure_clone
  success "Initialisation complete. Run './scripts/sync-framework.sh pull' to sync files."
}

cmd_pull() {
  ensure_clone
  info "Fetching latest from $FRAMEWORK_REPO ..."
  git -C "$FRAMEWORK_DIR" pull origin "$FRAMEWORK_BRANCH"
  echo ""

  # Sync full directories
  for dir in "${FULL_SYNC_DIRS[@]}"; do
    if [[ -d "$FRAMEWORK_DIR/$dir" ]]; then
      info "Syncing $dir/ ..."
      rsync -av --delete \
        "$FRAMEWORK_DIR/$dir/" \
        "$PROJECT_DIR/$dir/"
    fi
  done

  # Sync framework-owned docs subdirectories
  for subdir in "${FRAMEWORK_DOC_SUBDIRS[@]}"; do
    if [[ -d "$FRAMEWORK_DIR/docs/$subdir" ]]; then
      info "Syncing docs/$subdir/ ..."
      mkdir -p "$PROJECT_DIR/docs/$subdir"
      rsync -av --delete \
        "$FRAMEWORK_DIR/docs/$subdir/" \
        "$PROJECT_DIR/docs/$subdir/"
    fi
  done

  # Sync framework-owned root-level docs files
  for file in "${FRAMEWORK_DOC_FILES[@]}"; do
    if [[ -f "$FRAMEWORK_DIR/docs/$file" ]]; then
      info "Syncing docs/$file ..."
      rsync -av \
        "$FRAMEWORK_DIR/docs/$file" \
        "$PROJECT_DIR/docs/$file"
    fi
  done

  echo ""
  success "Pull complete. Agent framework files are up to date."
}

cmd_push() {
  local message="${1:-sync: update agent framework files}"
  ensure_clone

  # Sync full directories
  for dir in "${FULL_SYNC_DIRS[@]}"; do
    if [[ -d "$PROJECT_DIR/$dir" ]]; then
      info "Syncing $dir/ → .agentic-framework/$dir/ ..."
      rsync -av --delete \
        "$PROJECT_DIR/$dir/" \
        "$FRAMEWORK_DIR/$dir/"
    fi
  done

  # Sync framework-owned docs
  for subdir in "${FRAMEWORK_DOC_SUBDIRS[@]}"; do
    if [[ -d "$PROJECT_DIR/docs/$subdir" ]]; then
      info "Syncing docs/$subdir/ → framework ..."
      mkdir -p "$FRAMEWORK_DIR/docs/$subdir"
      rsync -av --delete \
        "$PROJECT_DIR/docs/$subdir/" \
        "$FRAMEWORK_DIR/docs/$subdir/"
    fi
  done
  for file in "${FRAMEWORK_DOC_FILES[@]}"; do
    if [[ -f "$PROJECT_DIR/docs/$file" ]]; then
      rsync -av \
        "$PROJECT_DIR/docs/$file" \
        "$FRAMEWORK_DIR/docs/$file"
    fi
  done

  echo ""
  info "Committing and pushing to $FRAMEWORK_REPO ..."
  git -C "$FRAMEWORK_DIR" add -A

  if git -C "$FRAMEWORK_DIR" diff --staged --quiet; then
    warn "No changes detected — nothing to push to the framework repo."
    exit 0
  fi

  git -C "$FRAMEWORK_DIR" commit -m "$message"
  git -C "$FRAMEWORK_DIR" push origin "$FRAMEWORK_BRANCH"
  echo ""
  success "Push complete. Changes are live at $FRAMEWORK_REPO"
}

cmd_status() {
  ensure_clone
  info "Fetching remote state (no changes applied) ..."
  git -C "$FRAMEWORK_DIR" fetch origin "$FRAMEWORK_BRANCH" 2>/dev/null

  echo ""
  echo -e "${BOLD}Incoming changes (framework → project):${RESET}"
  git -C "$FRAMEWORK_DIR" log HEAD..origin/"$FRAMEWORK_BRANCH" --oneline 2>/dev/null \
    || echo "  (none — already up to date)"

  echo ""
  echo -e "${BOLD}Local framework dir status:${RESET}"
  git -C "$FRAMEWORK_DIR" status --short

  echo ""
  echo -e "${BOLD}Diff between project and .agentic-framework (dry-run):${RESET}"
  for dir in "${FULL_SYNC_DIRS[@]}"; do
    if [[ -d "$PROJECT_DIR/$dir" && -d "$FRAMEWORK_DIR/$dir" ]]; then
      local_changes=$(rsync -avn --delete \
        "$PROJECT_DIR/$dir/" \
        "$FRAMEWORK_DIR/$dir/" \
        | grep -v '^\.$' | grep -v '^sending\|^sent\|^total' || true)
      if [[ -n "$local_changes" ]]; then
        echo "  $dir/:"
        echo "$local_changes" | sed 's/^/    /'
      fi
    fi
  done
}

# --------------------------------------------------------------------------- #
case "${1:-}" in
  pull)   cmd_pull ;;
  push)   cmd_push "${2:-}" ;;
  status) cmd_status ;;
  init)   cmd_init ;;
  *)
    echo ""
    echo -e "${BOLD}Usage:${RESET} ./scripts/sync-framework.sh <command>"
    echo ""
    echo "  pull              Pull latest framework files from GitHub → project"
    echo "  push [message]    Push local agent changes from project → GitHub"
    echo "  status            Show pending changes (dry-run, no writes)"
    echo "  init              (Re)clone the framework repo"
    echo ""
    echo "Synced directories: ${FULL_SYNC_DIRS[*]}"
    echo "Framework repo:     $FRAMEWORK_REPO"
    echo ""
    exit 1
    ;;
esac
