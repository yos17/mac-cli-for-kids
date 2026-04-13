#!/bin/bash
# =============================================================
# reset_terminal.sh — Restore .zshrc to pre-setup state
#
# Usage: bash scripts/reset_terminal.sh
# =============================================================

ZSHRC="$HOME/.zshrc"
BACKUP="$HOME/.zshrc.before_mac_cli_for_kids"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

echo ""
echo -e "${CYAN}${BOLD}Terminal Setup — Reset${NC}"
echo ""

if [ ! -f "$BACKUP" ]; then
    echo -e "${YELLOW}No backup found at $BACKUP${NC}"
    echo ""
    echo "Options:"
    echo "  1. The setup script was never run — nothing to restore."
    echo "  2. You already restored once and the backup was cleaned up."
    echo ""
    echo "If you still want to remove the config manually:"
    echo "  open -a TextEdit ~/.zshrc"
    echo "  Delete everything between the two MAC CLI FOR KIDS markers."
    exit 0
fi

echo "This will replace your current ~/.zshrc with the backup from before setup."
echo ""
echo -e "  Current:  ${YELLOW}$ZSHRC${NC}"
echo -e "  Backup:   ${YELLOW}$BACKUP${NC}"
echo ""
echo -n "Are you sure? (y/n): "
read confirm

if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
    echo ""
    echo "Cancelled. Nothing changed."
    exit 0
fi

cp "$BACKUP" "$ZSHRC"
rm "$BACKUP"

echo ""
echo -e "${GREEN}✓ .zshrc restored from backup${NC}"
echo -e "${GREEN}✓ Backup file removed${NC}"
echo ""
echo "To apply the restored config now:"
echo -e "  ${BOLD}source ~/.zshrc${NC}"
echo ""
echo "Or just open a new Terminal window."
echo ""
