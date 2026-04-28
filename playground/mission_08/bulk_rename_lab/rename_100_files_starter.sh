#!/bin/bash
# Mission 08 starter: rename 100 files instantly.
#
# Run after create_100_files_starter.sh:
#   bash rename_100_files_starter.sh

set -u

TARGET_DIR="${1:-$HOME/rename_100_lab}"

if [ ! -d "$TARGET_DIR" ]; then
    echo "Practice folder not found:"
    echo "  $TARGET_DIR"
    echo "Run create_100_files_starter.sh first."
    exit 1
fi

counter=1

for file in "$TARGET_DIR"/*.txt; do
    [ -e "$file" ] || continue

    new_name=$(printf "evidence_%03d.txt" "$counter")
    mv "$file" "$TARGET_DIR/$new_name"

    counter=$((counter + 1))
done

echo "Renamed $((counter - 1)) files."
echo ""
echo "Preview:"
ls "$TARGET_DIR" | head
