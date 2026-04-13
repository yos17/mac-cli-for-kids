#!/bin/bash
# ================================================
# MYBOT STARTER — MISSION 12
# Terminal Detective Agency Personal Assistant
# ================================================
# This is your skeleton script. Your job:
# Fill in the BLANK sections to make MyBot work!
# ================================================

# --- SETTINGS (fill these in!) ---
MY_NAME="________"          # YOUR name or codename here
MY_VOICE="Samantha"         # your favorite voice from Mission 1

# --- COLORS (already done for you) ---
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m'   # reset

# --- BANNER (fill in the blank!) ---
show_banner() {
    clear
    echo ""
    echo -e "${CYAN}╔═══════════════════════════════════╗${NC}"
    echo -e "${CYAN}║         M Y   B O T               ║${NC}"
    echo -e "${CYAN}║  Terminal Detective Assistant     ║${NC}"
    echo -e "${CYAN}╚═══════════════════════════════════╝${NC}"
    echo ""
    echo -e "  Hello, ${YELLOW}$MY_NAME${NC}! What can I do for you?"
    echo ""
}

# --- GREETING FUNCTION (fill in the blank!) ---
do_greeting() {
    # BLANK: Get the current hour using: date +"%H"
    # BLANK: If hour < 12, say "Good morning"
    #        If hour < 17, say "Good afternoon"
    #        Otherwise, say "Good evening"
    # BLANK: Print the greeting and today's date
    # BLANK: Use say to speak the greeting aloud
    echo "TODO: Add greeting logic here!"
}

# --- FUN FACT FUNCTION (already mostly done!) ---
do_fun_fact() {
    FACTS=(
        "A group of flamingos is called a flamboyance."
        "Honey never expires — 3000-year-old honey was found in Egyptian tombs."
        "Octopuses have three hearts and blue blood."
        "The unicorn is the national animal of Scotland."
        "Bananas are technically berries. Strawberries are not."
    )
    # BLANK: Pick a random fact from the array
    # Hint: RANDOM_FACT="${FACTS[$((RANDOM % ${#FACTS[@]}))]}"
    # BLANK: Print and say the fact
    echo "TODO: Add random fact picker here!"
}

# --- MAIN MENU (fill in the blank!) ---
show_menu() {
    echo -e "${YELLOW}  What would you like to do?${NC}"
    echo ""
    echo "  1. Morning Greeting"
    echo "  2. Fun Fact"
    echo "  3. What time is it?"
    echo "  4. ________ (add your own!)"
    echo "  q. Quit"
    echo ""
    echo -n "  Your choice: "
}

# --- MAIN LOOP (already done — study this!) ---
show_banner

while true; do
    show_menu
    read choice

    case "$choice" in
        1) do_greeting ;;
        2) do_fun_fact ;;
        3)
            echo ""
            echo -e "  ${CYAN}$(date +'%I:%M %p on %A, %B %d, %Y')${NC}"
            echo ""
            ;;
        4)
            # BLANK: Add your own feature here!
            echo "Coming soon! Add your own feature."
            ;;
        q|Q)
            echo ""
            echo -e "  ${YELLOW}Goodbye, $MY_NAME!${NC}"
            say -v "$MY_VOICE" "Goodbye $MY_NAME!" 2>/dev/null
            echo ""
            exit 0
            ;;
        *)
            echo -e "  ${RED}Unknown option. Try again!${NC}"
            ;;
    esac

    echo ""
    echo -n "  Press Enter to continue..."
    read
    show_banner
done
