#!/bin/bash
# Mission 08 starter: create 100 messy practice files.
#
# Run:
#   bash create_100_files_starter.sh

set -u

TARGET_DIR="${1:-$HOME/rename_100_lab}"

mkdir -p "$TARGET_DIR"

for i in $(seq 1 100); do
    printf "Evidence practice file %03d\n" "$i" > "$TARGET_DIR/raw photo $i.txt"
done

echo "Created 100 practice files in:"
echo "  $TARGET_DIR"
echo ""
echo "Preview:"
ls "$TARGET_DIR" | head
