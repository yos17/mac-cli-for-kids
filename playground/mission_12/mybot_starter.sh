#!/bin/bash
# ============================================================
# MyBot — Your Personal Terminal Assistant
# Detective Academy — Mission 12 Starter Script
#
# INSTRUCTIONS:
# This script is a skeleton. Your job is to fill in the
# TODO sections to make MyBot fully functional!
#
# When done, make it executable and run it:
#   chmod +x mybot_starter.sh
#   ./mybot_starter.sh
# ============================================================

# --- CONFIGURATION ---
# TODO: Change BOT_NAME to whatever you want to call your bot!
BOT_NAME="MyBot"
BOT_VERSION="1.0"
DETECTIVE_NAME="Detective Recruit"  # TODO: Change to your name

# The file where MyBot saves notes
NOTES_FILE="$HOME/mybot_notes.txt"

# ============================================================
# FUNCTION: show_welcome
# Displays a welcome banner when MyBot starts
# ============================================================
show_welcome() {
    echo "============================================"
    echo "  Welcome to $BOT_NAME v$BOT_VERSION"
    echo "  Hello, $DETECTIVE_NAME!"
    echo "  $(date '+%A, %B %d %Y — %H:%M')"
    echo "============================================"
    echo ""
}

# ============================================================
# FUNCTION: show_menu
# Shows the list of available commands
# ============================================================
show_menu() {
    echo "What would you like to do?"
    echo ""
    echo "  1) Check the weather"
    echo "  2) Show my public IP address"
    echo "  3) Save a quick note"
    echo "  4) Read my saved notes"
    echo "  5) Show current disk usage"
    echo "  6) Tell me a fun fact"       # TODO: Implement this!
    echo "  7) Secret detective mode"    # TODO: Implement this!
    echo "  q) Quit MyBot"
    echo ""
    printf "Enter your choice: "
}

# ============================================================
# FUNCTION: check_weather
# Fetches weather info using curl
# ============================================================
check_weather() {
    echo ""
    echo "--- Current Weather ---"
    # TODO: The curl command to get weather goes here.
    # HINT: Use the wttr.in service from Mission 09!
    # The URL was: https://wttr.in/?format=3
    curl -s "https://wttr.in/?format=3" 2>/dev/null || echo "Could not reach weather service. Are you online?"
    echo ""
}

# ============================================================
# FUNCTION: check_ip
# Shows the user's public IP address
# ============================================================
check_ip() {
    echo ""
    echo "--- Your Public IP Address ---"
    # TODO: Fill in the curl command to get your IP.
    # HINT: Use the api.ipify.org service from Mission 09!
    curl -s "https://api.ipify.org" 2>/dev/null || echo "Could not fetch IP. Are you online?"
    echo ""
    echo ""
}

# ============================================================
# FUNCTION: save_note
# Saves a note to the notes file
# ============================================================
save_note() {
    echo ""
    printf "Enter your note: "
    read -r user_note
    # TODO: Add code to save the note to $NOTES_FILE
    # HINT: Use echo and >> to APPEND (not overwrite!) to the file
    # HINT: Also add a timestamp! Use: $(date '+%Y-%m-%d %H:%M')
    echo "[$(date '+%Y-%m-%d %H:%M')] $user_note" >> "$NOTES_FILE"
    echo "Note saved!"
    echo ""
}

# ============================================================
# FUNCTION: read_notes
# Displays all saved notes
# ============================================================
read_notes() {
    echo ""
    echo "--- Your Saved Notes ---"
    if [ -f "$NOTES_FILE" ]; then
        # TODO: Add code to display the notes
        # HINT: Use cat to read the file
        cat "$NOTES_FILE"
    else
        echo "(No notes saved yet. Use option 3 to add one!)"
    fi
    echo ""
}

# ============================================================
# FUNCTION: show_disk_usage
# Shows available disk space
# ============================================================
show_disk_usage() {
    echo ""
    echo "--- Disk Usage ---"
    # TODO: Add the command to show disk usage in human-readable format
    # HINT: The alias from Mission 10 was: df -h
    df -h
    echo ""
}

# ============================================================
# FUNCTION: fun_fact
# TODO: Implement this function!
# Make it print a random fun fact about computers or detectives.
# HINT: Store 5 facts in an array, then pick one randomly.
# ============================================================
fun_fact() {
    echo ""
    echo "--- Fun Fact ---"
    # TODO: Replace this with a real random fun fact!
    # Here's a starter array for you to fill in:
    facts=(
        "TODO: Add your first fun fact here!"
        "TODO: Add a second fun fact!"
        "TODO: Add a third one!"
        "The first computer bug was an actual bug — a moth stuck in a relay at Harvard in 1947."
        "The Terminal you're using today is descended from terminals that used actual paper, not screens."
    )
    # Pick a random fact:
    random_index=$((RANDOM % ${#facts[@]}))
    echo "${facts[$random_index]}"
    echo ""
}

# ============================================================
# MAIN LOOP
# This keeps MyBot running until the user types 'q' to quit
# ============================================================
show_welcome

while true; do
    show_menu
    read -r choice
    echo ""

    case $choice in
        1) check_weather ;;
        2) check_ip ;;
        3) save_note ;;
        4) read_notes ;;
        5) show_disk_usage ;;
        6) fun_fact ;;
        7)
            # TODO: Implement secret detective mode!
            # Ideas: show a random case file, display the network log,
            # run a grep search, or show something creative.
            echo "--- SECRET DETECTIVE MODE ---"
            echo "TODO: Implement this! What should it do?"
            echo "(Maybe show the network log? Or a random clue?)"
            echo ""
            ;;
        q|Q)
            echo "Goodbye, $DETECTIVE_NAME. Stay sharp!"
            echo ""
            exit 0
            ;;
        *)
            echo "Unknown command: '$choice'. Try again."
            echo ""
            ;;
    esac
done

# ============================================================
# END OF MyBot
# ============================================================
