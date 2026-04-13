#!/bin/zsh
# ╔═══════════════════════════════════════════════╗
# ║  MYBOT — Your Personal Detective Assistant    ║
# ║  Terminal Detective Agency                    ║
# ║  Mission 12: Build Your Own App               ║
# ╚═══════════════════════════════════════════════╝
#
# INSTRUCTIONS: Complete the TODOs below to build your bot!

AGENT_NAME="Agent"  # TODO: Change to your name!

# --- MAIN MENU ---
show_menu() {
    clear
    echo "╔═══════════════════════════════════╗"
    echo "║  Welcome, $AGENT_NAME!            "
    echo "║  What would you like to do?       ║"
    echo "╠═══════════════════════════════════╣"
    echo "║  1. Morning Briefing               ║"
    echo "║  2. Search for Clues               ║"
    echo "║  3. View Case Files                ║"
    echo "║  4. Assemble Secret Code           ║"
    echo "║  5. Exit                           ║"
    echo "╚═══════════════════════════════════╝"
    echo -n "Choose (1-5): "
}

# --- MORNING BRIEFING ---
morning_briefing() {
    echo "Good morning, $AGENT_NAME!"
    echo "Today is: $(date)"
    echo "Status: ON DUTY"
    # TODO: Add more briefing info here!
}

# --- SEARCH FOR CLUES ---
search_clues() {
    echo -n "Enter keyword to search: "
    read keyword
    # TODO: Use grep to search playground files for the keyword
    echo "Searching..."
}

# --- VIEW CASE FILES ---
view_cases() {
    # TODO: List and display files from playground/mission_12/case_files/
    echo "Loading case files..."
}

# --- ASSEMBLE SECRET CODE ---
assemble_code() {
    echo "Assembling your secret code pieces..."
    # TODO: cat all secret_code_piece.txt files from each mission
    echo "Hint: grep -r 'YOUR WORD' playground/"
}

# --- MAIN LOOP ---
while true; do
    show_menu
    read choice
    case $choice in
        1) morning_briefing ;;
        2) search_clues ;;
        3) view_cases ;;
        4) assemble_code ;;
        5) echo "Goodbye, $AGENT_NAME! Stay safe out there."; exit 0 ;;
        *) echo "Invalid choice. Try again." ;;
    esac
    echo ""
    echo "Press Enter to continue..."
    read
done
