#!/bin/bash
# Mission 05 starter: search files faster than Finder.
#
# Run:
#   bash search_toolkit_starter.sh
#   bash search_toolkit_starter.sh MARINA

set -u

SEARCH_DIR="$HOME/mac-cli-for-kids/playground/mission_05"
TERM="${1:-MARINA}"

echo "Search folder:"
echo "  $SEARCH_DIR"
echo ""

if [ ! -d "$SEARCH_DIR" ]; then
    echo "Could not find the mission folder."
    echo "Try running this after cloning the repo into ~/mac-cli-for-kids."
    exit 1
fi

echo "1. Count files:"
find "$SEARCH_DIR" -type f | wc -l
echo ""

echo "2. Find report files:"
find "$SEARCH_DIR" -name "report_*.txt"
echo ""

echo "3. Search for:"
echo "  $TERM"
grep -Rni "$TERM" "$SEARCH_DIR" 2>/dev/null || echo "No matches found."
echo ""

echo "TODO:"
echo "  Change TERM, add more find patterns, and turn this into your own toolkit."
