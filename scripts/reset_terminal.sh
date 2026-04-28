#!/bin/bash
# =============================================================
# reset_terminal.sh — Restore .zshrc to pre-setup state
#
# Usage: bash scripts/reset_terminal.sh
# =============================================================

ZSHRC="$HOME/.zshrc"
BACKUP="$HOME/.zshrc.before_mac_cli_for_kids"
LEGACY_BACKUP="$HOME/.zshrc.before_detective_academy"
CODE_LOG="$HOME/.terminal_quest_codes"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

echo ""
echo -e "${CYAN}${BOLD}Terminal Setup — Reset${NC}"
echo ""

if [ ! -f "$BACKUP" ] && [ -f "$LEGACY_BACKUP" ]; then
    BACKUP="$LEGACY_BACKUP"
fi

if [ ! -f "$BACKUP" ]; then
    echo -e "${YELLOW}No backup found at $BACKUP${NC}"
    echo ""
    echo "Options:"
    echo "  1. The setup script was never run — nothing to restore."
    echo "  2. You already restored once and the backup was cleaned up."
    echo ""
    if [ -f "$ZSHRC" ] && grep -q "MAC CLI FOR KIDS — JOANNA'S TERMINAL SETUP" "$ZSHRC"; then
        echo "A MAC CLI FOR KIDS block still exists in ~/.zshrc."
        echo -n "Remove just that block now? (y/n): "
        read confirm

        if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
            TMP_ZSHRC="$(mktemp)"
            awk '
                /^# END MAC CLI FOR KIDS — JOANNA'\''S TERMINAL SETUP/ { skip=0; next }
                /^# .*MAC CLI FOR KIDS — JOANNA'\''S TERMINAL SETUP/ { skip=1; next }
                !skip { print }
            ' "$ZSHRC" > "$TMP_ZSHRC"
            mv "$TMP_ZSHRC" "$ZSHRC"
            rm -f "$CODE_LOG"
            echo ""
            echo -e "${GREEN}✓ Removed MAC CLI FOR KIDS block from .zshrc${NC}"
            echo -e "${GREEN}✓ Removed local code collection, if it existed${NC}"
        fi
    else
        echo "If you still want to remove the config manually:"
        echo "  open -a TextEdit ~/.zshrc"
        echo "  Delete everything between the two MAC CLI FOR KIDS markers."
    fi
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
rm -f "$CODE_LOG"

echo ""
echo -e "${GREEN}✓ .zshrc restored from backup${NC}"
echo -e "${GREEN}✓ Backup file removed${NC}"
echo -e "${GREEN}✓ Local code collection removed${NC}"
echo ""
echo "To apply the restored config now:"
echo -e "  ${BOLD}source ~/.zshrc${NC}"
echo ""
echo "Or just open a new Terminal window."
echo ""
