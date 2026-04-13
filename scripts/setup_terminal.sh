#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
#  Terminal Detective Academy — Setup Script
#  Run once to give Joanna a detective-themed Terminal experience
# ─────────────────────────────────────────────────────────────

set -e

ZSHRC="$HOME/.zshrc"
BACKUP="$HOME/.zshrc.detective_backup"
PLAYGROUND="$(cd "$(dirname "$0")/.." && pwd)/playground"

echo ""
echo "🔍 Terminal Detective Academy — Setup"
echo "────────────────────────────────────"
echo ""

# ── Backup existing .zshrc ───────────────────────────────────
if [ -f "$ZSHRC" ]; then
  if [ -f "$BACKUP" ]; then
    echo "⚠️  A backup already exists at $BACKUP"
    echo "   Skipping backup to avoid overwriting a previous one."
    echo "   (Run scripts/reset_terminal.sh first if you want a fresh setup.)"
  else
    cp "$ZSHRC" "$BACKUP"
    echo "✅ Backed up existing .zshrc → $BACKUP"
  fi
else
  echo "ℹ️  No existing .zshrc found — creating a new one."
  touch "$ZSHRC"
fi

# ── Write detective config block ─────────────────────────────
cat >> "$ZSHRC" << DETECTIVE_CONFIG

# ════════════════════════════════════════════════════════════
#  Terminal Detective Academy — added by setup_terminal.sh
# ════════════════════════════════════════════════════════════

# ── Colorful ls output ──────────────────────────────────────
export LSCOLORS="GxFxCxDxBxegedabagacad"
export CLICOLOR=1
alias ls='ls -G'

# ── Detective prompt ─────────────────────────────────────────
# Shows: 🔍 Detective Joanna ~/current/folder $
detective_prompt() {
  local dir="\$(pwd | sed \"s|^\$HOME|~|\")"
  echo "🔍 Detective Joanna \$dir \$ "
}
setopt PROMPT_SUBST
PS1='\$(detective_prompt)'

# ── Helpful aliases ──────────────────────────────────────────

# Go to the playground (missions home base)
missions() {
  cd "$PLAYGROUND" && echo "📁 You're at HQ. Missions available:" && ls
}

# Read the current mission's briefing
briefing() {
  local brief="\$(pwd)/case_briefing.txt"
  if [ -f "\$brief" ]; then
    cat "\$brief"
  else
    echo "📋 No case_briefing.txt found here."
    echo "   Navigate into a mission folder first (e.g., cd mission_02)"
  fi
}

# Show a random CLI tip
hint() {
  local tips=(
    "💡 Use 'ls -a' to see hidden files (ones that start with a dot)."
    "💡 Press Tab to auto-complete a filename — saves a lot of typing!"
    "💡 Use 'cd ..' to go back up one folder level."
    "💡 The up arrow key shows your last command."
    "💡 'pwd' tells you exactly where you are right now."
    "💡 Pipe commands with | to chain them together: ls | grep clue"
    "💡 Use 'cat filename.txt' to read a file without opening an editor."
    "💡 'man command' shows the manual for any command."
    "💡 Ctrl+C cancels a running command if you get stuck."
    "💡 Use 'history' to see all the commands you've typed before."
  )
  local count=\${#tips[@]}
  local index=\$(( RANDOM % count ))
  echo "\${tips[\$index]}"
}

# Find and read the secret code in the current mission folder
secret() {
  local code="\$(find . -maxdepth 1 -name '.secret_code.txt' 2>/dev/null)"
  if [ -n "\$code" ]; then
    echo "🔓 Secret code found!"
    cat "\$code"
  else
    echo "🔒 No .secret_code.txt here. Keep investigating..."
    echo "   Hint: secret files start with a dot. Try 'ls -a'"
  fi
}

# Show all collected secret codes across all missions
codes() {
  echo "🗂️  Secret Codes Collected:"
  echo "──────────────────────────"
  local found=0
  for i in \$(seq -w 1 12); do
    local mission="$PLAYGROUND/mission_\$i"
    local codefile="\$mission/.secret_code.txt"
    if [ -d "\$mission" ]; then
      if [ -f "\$codefile" ]; then
        local word=\$(cat "\$codefile" | tr -d '[:space:]')
        echo "  Mission \$i: \$word ✅"
        found=\$((found + 1))
      else
        echo "  Mission \$i: ??? (not yet found)"
      fi
    fi
  done
  echo ""
  echo "Found \$found / 12 codes"
}

# Show directory tree using find
map() {
  local depth="\${1:-3}"
  echo "🗺️  Directory map (depth \$depth):"
  find . -maxdepth "\$depth" | sort | sed -e 's|[^/]*/|  |g' -e 's|  \([^  ]\)|── \1|'
}

# Colorful grep alias for finding clues
alias clue='grep --color=always'

# ── Welcome message ──────────────────────────────────────────
echo ""
echo "🔍 Welcome back, Detective Joanna!"
echo "   Type 'missions' to start your next case."
echo ""

# ════════════════════════════════════════════════════════════
DETECTIVE_CONFIG

echo ""
echo "✅ Detective Terminal setup complete!"
echo ""
echo "────────────────────────────────────"
echo "  Next steps:"
echo ""
echo "  1. Open a NEW Terminal window (or tab)"
echo "  2. Type:  missions"
echo "  3. Pick your mission and start investigating!"
echo ""
echo "  Your detective commands:"
echo "    missions  — go to the missions playground"
echo "    briefing  — read the current mission's case file"
echo "    hint      — get a random CLI tip"
echo "    secret    — reveal the hidden secret code"
echo "    codes     — show all codes you've collected"
echo "    map       — show a directory tree"
echo "    clue      — search for text in files (colorful grep)"
echo ""
echo "  To undo: bash scripts/reset_terminal.sh"
echo "────────────────────────────────────"
echo ""
