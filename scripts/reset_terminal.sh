#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
#  Terminal Detective Academy — Reset Script
#  Restores .zshrc from backup created by setup_terminal.sh
# ─────────────────────────────────────────────────────────────

ZSHRC="$HOME/.zshrc"
BACKUP="$HOME/.zshrc.detective_backup"

echo ""
echo "🔄 Terminal Detective Academy — Reset"
echo "────────────────────────────────────"
echo ""

if [ ! -f "$BACKUP" ]; then
  echo "⚠️  No backup found at $BACKUP"
  echo "   Nothing to restore."
  echo ""
  echo "   If you want to remove just the detective block,"
  echo "   open ~/.zshrc and delete everything between:"
  echo "   # Terminal Detective Academy — added by setup_terminal.sh"
  echo "   ...and the closing line of that block."
  exit 1
fi

cp "$BACKUP" "$ZSHRC"
rm "$BACKUP"

echo "✅ Restored .zshrc from backup."
echo "   Backup file removed."
echo ""
echo "   Open a new Terminal window to see your original settings."
echo ""
