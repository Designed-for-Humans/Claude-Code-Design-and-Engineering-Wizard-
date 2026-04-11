#!/usr/bin/env bash
set -euo pipefail

# Design System Wizard — Installer
# Installs the /design skill into your project's .claude/skills/ directory

SKILL_NAME="design-system-wizard"
SKILL_DIR=".claude/skills/${SKILL_NAME}"
REPO_URL="https://raw.githubusercontent.com/Designed-for-Humans/Claude-Code-Design-and-Engineering-Wizard-/main/skill"

FILES=(
  "SKILL.md"
  "ONBOARDING.md"
  "CHECKLISTS.md"
  "TOKENS.md"
  "ACCESSIBILITY.md"
  "PATTERNS.md"
  "COMPONENTS.md"
)

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo ""
echo -e "${BLUE}Design System Wizard${NC} — Installation"
echo "============================================"
echo ""

# Check: must be in a git repo
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo -e "${RED}Error:${NC} Not inside a git repository."
  echo "Navigate to your project root and try again."
  exit 1
fi

# Check: existing installation
if [ -d "$SKILL_DIR" ]; then
  echo -e "${YELLOW}Warning:${NC} ${SKILL_DIR} already exists."
  read -rp "Overwrite existing installation? [y/N] " answer
  if [[ ! "$answer" =~ ^[Yy]$ ]]; then
    echo "Installation cancelled."
    exit 0
  fi
  rm -rf "$SKILL_DIR"
fi

# Create skill directory
mkdir -p "$SKILL_DIR"

# Download files
echo -e "Downloading skill files..."
DOWNLOAD_CMD=""
if command -v curl >/dev/null 2>&1; then
  DOWNLOAD_CMD="curl -sfL"
elif command -v wget >/dev/null 2>&1; then
  DOWNLOAD_CMD="wget -qO-"
else
  echo -e "${RED}Error:${NC} Neither curl nor wget found. Install one and try again."
  exit 1
fi

FAILED=0
for file in "${FILES[@]}"; do
  if $DOWNLOAD_CMD "${REPO_URL}/${file}" > "${SKILL_DIR}/${file}" 2>/dev/null; then
    echo -e "  ${GREEN}✓${NC} ${file}"
  else
    echo -e "  ${RED}✗${NC} ${file} — download failed"
    FAILED=1
  fi
done

if [ "$FAILED" -eq 1 ]; then
  echo ""
  echo -e "${RED}Some files failed to download.${NC}"
  echo "Try cloning the repo instead:"
  echo "  git clone https://github.com/Designed-for-Humans/Claude-Code-Design-and-Engineering-Wizard-.git"
  echo "  cp -r Claude-Code-Design-and-Engineering-Wizard-/skill/ ${SKILL_DIR}/"
  exit 1
fi

echo ""
echo -e "${GREEN}Installation complete!${NC}"
echo ""
echo "============================================"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo ""
echo "  1. Set up your design system at:"
echo -e "     ${GREEN}https://systems.designedforhumans.tech${NC}"
echo ""
echo "  2. Connect the MCP server (Pro feature):"
echo -e "     Sign in at the web app and go to ${YELLOW}Settings > MCP${NC}"
echo -e "     for your connection command."
echo ""
echo "  3. Use the skill in Claude Code:"
echo -e "     ${YELLOW}/design build a dashboard with sidebar navigation${NC}"
echo ""
echo "  Or without MCP — export your AI file from the web app"
echo "  and place it in your project root."
echo ""
echo "============================================"
echo ""
