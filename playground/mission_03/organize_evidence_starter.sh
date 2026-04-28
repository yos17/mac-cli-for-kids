#!/bin/bash
# Mission 03 starter: organize an evidence room.
#
# Run from anywhere:
#   bash organize_evidence_starter.sh
#
# It creates a safe practice folder in your home directory, then leaves TODOs
# for you to finish with mkdir, mv, cp, and rm.

set -u

LAB_DIR="${1:-$HOME/evidence_room_practice}"

echo "Creating practice evidence room at:"
echo "  $LAB_DIR"
echo ""

mkdir -p "$LAB_DIR"
cd "$LAB_DIR" || exit 1

# Starter files to organize.
touch photo_001.txt photo_002.txt photo_003.txt
touch note_alpha.txt note_beta.txt
touch report_01.txt report_02.txt
touch junk_file.txt

# Starter folders. Add more if you need them.
mkdir -p Photos Notes Reports Archive

echo "Starter files:"
ls
echo ""

echo "TODO:"
echo "  1. Move photo files into Photos/"
echo "  2. Move note files into Notes/"
echo "  3. Move report files into Reports/"
echo "  4. Decide what to do with junk_file.txt"
echo ""
echo "Hint: try commands like:"
echo "  mv photo_001.txt Photos/"
echo "  mv note_*.txt Notes/"
