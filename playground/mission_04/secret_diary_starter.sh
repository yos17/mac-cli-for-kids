#!/bin/bash
# Mission 04 starter: create a secret text diary.
#
# Run:
#   bash secret_diary_starter.sh

set -u

DIARY_DIR="$HOME/detective_diary"
DIARY_FILE="$DIARY_DIR/journal.txt"

mkdir -p "$DIARY_DIR"

echo "Secret Detective Diary"
echo "Write one line, then press Enter:"
read -r entry

{
    echo "=== $(date '+%Y-%m-%d %H:%M') ==="
    echo "$entry"
    echo ""
} >> "$DIARY_FILE"

# Mission 11 explains this fully. For now, it means "only I can read/write it."
chmod 600 "$DIARY_FILE" 2>/dev/null || true

echo ""
echo "Saved to:"
echo "  $DIARY_FILE"
echo ""
echo "Read it with:"
echo "  cat \"$DIARY_FILE\""
