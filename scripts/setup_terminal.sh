#!/bin/bash
# =============================================================
# setup_terminal.sh — Terminal Setup for Joanna
# Sets up a clean, colourful Terminal with handy shortcuts
#
# Usage: bash scripts/setup_terminal.sh
# Undo:  bash scripts/reset_terminal.sh
# =============================================================

set -e

ZSHRC="$HOME/.zshrc"
BACKUP="$HOME/.zshrc.before_detective_academy"
REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PLAYGROUND="$REPO_DIR/playground"

# --- Colors for the installer output ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

echo ""
echo -e "${CYAN}${BOLD}╔══════════════════════════════════════════╗${NC}"
echo -e "${CYAN}${BOLD}║        Terminal Setup for Joanna         ║${NC}"
echo -e "${CYAN}${BOLD}╚══════════════════════════════════════════╝${NC}"
echo ""

# --- Step 1: Backup existing .zshrc ---
if [ -f "$ZSHRC" ]; then
    if [ -f "$BACKUP" ]; then
        echo -e "${YELLOW}⚠ A backup already exists at $BACKUP${NC}"
        echo -n "  Overwrite the old backup? (y/n): "
        read confirm
        if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
            echo ""
            echo -e "${YELLOW}Setup cancelled. Your files are unchanged.${NC}"
            echo "  To restore a previous backup: bash scripts/reset_terminal.sh"
            exit 0
        fi
    fi
    cp "$ZSHRC" "$BACKUP"
    echo -e "${GREEN}✓ Backed up existing .zshrc → .zshrc.before_mac_cli_for_kids${NC}"
else
    echo -e "${GREEN}✓ No existing .zshrc — creating fresh one${NC}"
    touch "$ZSHRC"
fi

# --- Step 2: Write the config block ---
cat >> "$ZSHRC" << ZSHRC_BLOCK

# =======================================================
# MAC CLI FOR KIDS — JOANNA'S TERMINAL SETUP
# Added by setup_terminal.sh — remove with reset_terminal.sh
# =======================================================

# --- Prompt: Joanna ~/current/path $ ---
autoload -U colors && colors
PROMPT='%F{green}Joanna%f %F{blue}%~%f %F{cyan}\$%f '

# --- Colorful ls ---
alias ls='ls -G'
alias ll='ls -lhG'
alias la='ls -lahG'

# --- Navigation ---
alias ..='cd ..'
alias ...='cd ../..'

# --- Shortcuts ---
MAC_CLI_REPO="$REPO_DIR"
MAC_CLI_PLAYGROUND="$PLAYGROUND"

# Go to the playground
missions() {
    cd "\$MAC_CLI_PLAYGROUND"
    echo "📂 Missions available:"
    ls "\$MAC_CLI_PLAYGROUND"
}

# Read the briefing file for the current mission folder
briefing() {
    if [ -f "./case_briefing.txt" ]; then
        cat ./case_briefing.txt
    else
        echo "No case_briefing.txt found here."
        echo "Try: cd \$MAC_CLI_PLAYGROUND/mission_01"
    fi
}

# Show a random CLI tip
hint() {
    local tips=(
        "Tab completion saves typing — press Tab after a few letters to autocomplete."
        "Up arrow repeats your last command. Keep pressing for older ones."
        "Ctrl+C cancels a running command if it gets stuck."
        "Use 'pwd' any time you feel lost — it shows exactly where you are."
        "Pipe commands together with | to chain them: ls | wc -l counts files."
        "The * wildcard matches anything: ls *.txt lists all text files."
        "man command shows the manual for any command. Press q to quit."
        "Ctrl+L clears the screen (same as the clear command)."
        "Use 2>/dev/null to hide error messages when searching with find."
        "Double-check with ls before using rm — there's no undo!"
        "grep -r 'word' . searches for a word in all files in this folder."
        "echo \$PATH shows where your shell looks for commands."
        "chmod +x script.sh makes a script runnable as ./script.sh"
        "Use >> to append to a file, > to overwrite it. Know the difference!"
        "history shows every command you've typed. history | grep 'find' filters it."
    )
    local idx=\$((RANDOM % \${#tips[@]}))
    echo ""
    echo -e "💡 \033[1;33mTip:\033[0m \${tips[\$idx]}"
    echo ""
}

# Find and show the secret code for the current mission folder
secret() {
    if [ -f "./.secret_code.txt" ]; then
        echo ""
        echo "🔐 Secret code found!"
        echo "   Word: \$(cat ./.secret_code.txt)"
        echo ""
    else
        local found_secret="\$(find . -maxdepth 2 -name '.secret_code.txt' 2>/dev/null | head -1)"
        if [ -n "\$found_secret" ]; then
            echo ""
            echo "🔐 Secret code found at \$found_secret:"
            echo "   Word: \$(cat \$found_secret)"
            echo ""
        else
            echo "No .secret_code.txt here. Navigate into a mission folder first."
            echo "Try: cd \$MAC_CLI_PLAYGROUND/mission_01"
        fi
    fi
}

# Show all collected secret codes across all missions
codes() {
    echo ""
    echo -e "\033[1;36m╔══════════════════════════════════════╗\033[0m"
    echo -e "\033[1;36m║       SECRET CODE COLLECTION         ║\033[0m"
    echo -e "\033[1;36m╚══════════════════════════════════════╝\033[0m"
    echo ""
    local total=0
    local found=0
    local phrase=""
    for i in \$(seq -w 1 12); do
        local num=\$((10#\$i))
        local folder="\$MAC_CLI_PLAYGROUND/mission_\$(printf '%02d' \$num)"
        total=\$((total + 1))
        if [ -f "\$folder/.secret_code.txt" ]; then
            local word="\$(cat \$folder/.secret_code.txt)"
            printf "  Mission %2d: \033[1;32m%-20s\033[0m ✓\n" "\$num" "\$word"
            phrase="\$phrase \$word"
            found=\$((found + 1))
        else
            printf "  Mission %2d: \033[0;90m%-20s\033[0m\n" "\$num" "[ not found yet ]"
        fi
    done
    echo ""
    echo -e "  Collected: \033[1;33m\$found / \$total\033[0m"
    if [ "\$found" -eq "\$total" ]; then
        echo ""
        echo -e "  \033[1;32m🎉 ALL CODES COLLECTED!\033[0m"
        echo -e "  \033[1;33mFinal message:\033[0m\$phrase"
    fi
    echo ""
}

# Show a tree-style directory map (with fallback if tree isn't installed)
map() {
    local target="\${1:-.}"
    if command -v tree &>/dev/null; then
        tree -C "\$target"
    else
        # Pure-bash fallback tree view
        echo "\$target"
        find "\$target" -not -path '*/\.*' | sort | sed -e "s|[^/]*/|  |g" -e "s|  \([^  ]\)| └─ \1|"
    fi
}

# Colorized grep — highlight matches in red
clue() {
    if [ -z "\$1" ]; then
        echo "Usage: clue 'search term' [file or folder]"
        echo "Example: clue 'MARINA' ."
        return 1
    fi
    local term="\$1"
    local location="\${2:-.}"
    grep -r --color=always -n "\$term" "\$location" 2>/dev/null || echo "No matches found for '\$term'"
}

# --- Welcome message on every new Terminal window ---
echo ""
echo -e "Hi Joanna! Type \033[1;33mmissions\033[0m to get started."
echo ""

# =======================================================
# END MAC CLI FOR KIDS — JOANNA'S TERMINAL SETUP
# =======================================================
ZSHRC_BLOCK

echo -e "${GREEN}✓ Config written to .zshrc${NC}"
echo ""

# --- Step 3: Summary ---
echo -e "${BOLD}${CYAN}Setup complete! New commands available:${NC}"
echo ""
echo -e "  ${YELLOW}missions${NC}    — jump to the playground folder"
echo -e "  ${YELLOW}briefing${NC}    — read the briefing for this mission"
echo -e "  ${YELLOW}hint${NC}        — show a random CLI tip"
echo -e "  ${YELLOW}secret${NC}      — reveal this mission's secret code"
echo -e "  ${YELLOW}codes${NC}       — show all codes collected so far"
echo -e "  ${YELLOW}map${NC}         — display a folder tree"
echo -e "  ${YELLOW}clue 'word'${NC} — colorized search through files"
echo ""
echo -e "${BOLD}Prompt will look like:${NC}"
echo -e "  ${GREEN}Joanna${NC} ${BLUE}~/mac-cli-for-kids${NC} ${CYAN}\$${NC}"
echo ""
echo -e "To activate now (or just open a new Terminal window):"
echo -e "  ${BOLD}source ~/.zshrc${NC}"
echo ""
echo -e "To undo all of this: ${BOLD}bash scripts/reset_terminal.sh${NC}"
echo ""
