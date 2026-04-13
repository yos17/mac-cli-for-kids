# Mission 12 — Solutions

## Challenge 1 — Personalize It

Here are two example features you could add to MyBot:

### Feature A: Random Compliment Generator

Add this function and a menu option `10`:

```bash
give_compliment() {
    clear_header
    echo -e "${BOLD}🌟 Compliment of the Day${RESET}"
    echo ""
    compliments=(
        "You're amazing and I mean it."
        "You learned Terminal. Most adults can't say that."
        "Your code is getting better every day."
        "You are creative, smart, and curious."
        "The fact that you finished 12 missions says everything."
        "You turned a blinking cursor into something powerful. That's you."
    )
    idx=$((RANDOM % ${#compliments[@]}))
    echo -e "${YELLOW}${compliments[$idx]}${RESET}"
    say "${compliments[$idx]}"
    press_enter
}
```

Then add to the menu:
```
10. 🌟  Get a compliment
```

And in the `case` block:
```bash
10) give_compliment ;;
```

### Feature B: Word Counter for Diary

```bash
diary_stats() {
    clear_header
    echo -e "${BOLD}📊 Diary Statistics${RESET}"
    echo ""
    if [ -f "$DIARY" ]; then
        entries=$(grep -c "^===" "$DIARY")
        words=$(wc -w < "$DIARY")
        lines=$(wc -l < "$DIARY")
        echo -e "Total entries: ${CYAN}$entries${RESET}"
        echo -e "Total words:   ${CYAN}$words${RESET}"
        echo -e "Total lines:   ${CYAN}$lines${RESET}"
        echo ""
        echo -e "${YELLOW}Most recent entry:${RESET}"
        grep "^===" "$DIARY" | tail -1
    else
        echo "No diary found yet."
    fi
    press_enter
}
```

---

## Challenge 2 — Color Themes

Add a theme selector by changing the color variables and adding a menu option:

```bash
set_theme() {
    clear_header
    echo -e "${BOLD}🎨 Choose a Color Theme${RESET}"
    echo ""
    echo "1. Cyan/Yellow (default)"
    echo "2. Green Hacker"
    echo "3. Purple/Pink"
    echo ""
    read -p "Choose theme (1-3): " theme_choice

    case $theme_choice in
        1)
            HEADER_COLOR='\033[0;36m'   # cyan
            ACCENT_COLOR='\033[1;33m'   # yellow
            echo "Theme: Cyan/Yellow applied."
            ;;
        2)
            HEADER_COLOR='\033[0;32m'   # green
            ACCENT_COLOR='\033[0;32m'   # green
            echo "Theme: Green Hacker applied."
            ;;
        3)
            HEADER_COLOR='\033[0;35m'   # magenta
            ACCENT_COLOR='\033[1;35m'   # bright magenta
            echo "Theme: Purple/Pink applied."
            ;;
        *)
            echo "Invalid choice, keeping current theme."
            ;;
    esac

    echo "BOT_THEME=$theme_choice" >> "$HOME/.mybot_config"
    press_enter
}
```

---

## Challenge 3 — The Daily Report

```bash
daily_report() {
    clear_header
    echo -e "${BOLD}📋 Daily Report — $(date +"%A, %B %d, %Y")${RESET}"
    echo ""

    # Diary count
    if [ -f "$DIARY" ]; then
        entries=$(grep -c "^===" "$DIARY")
        echo -e "📖 Diary entries: ${CYAN}$entries${RESET}"
    else
        echo -e "📖 Diary: ${YELLOW}not started yet${RESET}"
    fi

    # Internet + IP
    if ping -c 1 -W 2 8.8.8.8 > /dev/null 2>&1; then
        public_ip=$(curl -s --max-time 5 https://api.ipify.org 2>/dev/null)
        echo -e "🌐 Internet: ${GREEN}connected${RESET} (IP: ${CYAN}$public_ip${RESET})"
    else
        echo -e "🌐 Internet: ${RED}not connected${RESET}"
    fi

    # Top 3 file types in Downloads
    echo ""
    echo -e "${BOLD}📂 Top file types in Downloads:${RESET}"
    ls ~/Downloads | grep -o "\.[a-zA-Z0-9]*$" | sort | uniq -c | sort -rn | head -3

    # Compliment
    echo ""
    compliments=("Keep it up!" "You're doing great." "Another great day!")
    echo -e "✨ ${YELLOW}${compliments[$((RANDOM % 3))]}${RESET}"

    press_enter
}
```

---

## Challenge 4 — Make It Your Own

This challenge has no single "correct" answer — it's entirely yours!

Some ideas other students have added:
- A random trivia question
- A reminder list (add/view/clear reminders)
- A simple calculator using `$(( ))`
- A countdown to a birthday or special event
- A daily word-of-the-day from a list
- A mini game (guess the number)

Here's a starter for a **number guessing game** in case you want inspiration:

```bash
guess_game() {
    clear_header
    echo -e "${BOLD}🎮 Guess the Number!${RESET}"
    echo ""
    secret=$((RANDOM % 10 + 1))
    echo "I'm thinking of a number between 1 and 10."
    echo ""
    attempts=0

    while true; do
        read -p "Your guess: " guess
        attempts=$((attempts + 1))

        if [ "$guess" -eq "$secret" ] 2>/dev/null; then
            echo -e "${GREEN}🎉 Correct! You got it in $attempts guess(es)!${RESET}"
            say "Correct! Well done!"
            break
        elif [ "$guess" -lt "$secret" ] 2>/dev/null; then
            echo -e "${YELLOW}Too low! Try higher.${RESET}"
        else
            echo -e "${YELLOW}Too high! Try lower.${RESET}"
        fi
    done

    press_enter
}
```

The best MyBot is the one you built yourself. Add things that make *your* life better and *your* Terminal more fun.

---

*You've completed all 12 missions. The Terminal is yours.*
