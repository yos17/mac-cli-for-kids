# Mission 12 — The Grand Finale

## Mission Briefing

*Director Chen stands at the front of the room. "You've done it," she says. "Navigation. File operations. Reading and writing. Searching. Pipes. Scripts. Loops. The internet. Customization. Encryption. You know it all." She slides a folder across the table. "One mission left: build your own app. And when you're done — collect your 12 code pieces and decode the final message."*

This is it. The final mission.

You're going to build **MyBot** — a real, menu-driven personal assistant app that runs from your terminal. All your skills, combined into one program.

**Your starter file is in `playground/mission_12/mybot_starter.sh`. The final reward is in `congratulations.txt.enc`.**

### What You'll Build
- A menu-driven app with numbered choices
- Functions for each feature
- A clean main loop that keeps running until you exit
- Your own custom features

---

## Architecture First

Before writing code, good programmers **plan**. Here's the structure:

```
mybot/
├── mybot.sh          ← the main program
├── config.sh         ← your settings
└── modules/
    ├── briefing.sh   ← morning briefing
    ├── diary.sh      ← diary functions
    ├── internet.sh   ← internet checker
    └── files.sh      ← file organizer
```

The main program loads modules, then shows a menu. You pick an option, it runs the right function, then returns to the menu.

---

## Setting Up the Project

```bash
mkdir -p ~/mybot/modules
cd ~/mybot
```

---

## The Config File

```bash
nano ~/mybot/config.sh
```

```bash
#!/bin/bash
# config.sh — MyBot settings

MY_NAME="Sophia"          # YOUR name!
MY_VOICE="Samantha"       # your favorite voice
DIARY_FILE="$HOME/detective_diary.txt"
BOT_NAME="MyBot"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
BOLD='\033[1m'
NC='\033[0m'   # reset
```

---

## The Briefing Module

```bash
nano ~/mybot/modules/briefing.sh
```

```bash
#!/bin/bash
# modules/briefing.sh — Morning briefing

do_briefing() {
    local DATE_FULL=$(date +"%A, %B %d, %Y")
    local HOUR=$(date +"%H")

    if [ "$HOUR" -lt 12 ]; then
        local GREETING="Good morning"
    elif [ "$HOUR" -lt 17 ]; then
        local GREETING="Good afternoon"
    else
        local GREETING="Good evening"
    fi

    local FACTS=(
        "A group of flamingos is called a flamboyance."
        "Honey never expires — archaeologists found 3000-year-old honey."
        "Octopuses have three hearts and blue blood."
        "The unicorn is the national animal of Scotland."
        "Bananas are technically berries. Strawberries are not."
        "Crows can recognize human faces and hold grudges."
    )
    local FACT="${FACTS[$((RANDOM % ${#FACTS[@]}))]}"

    echo ""
    echo -e "${CYAN}╔══════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}${BOLD}            MORNING BRIEFING               ${NC}${CYAN}║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${YELLOW}$GREETING, $MY_NAME!${NC}"
    echo -e "  ${GREEN}$DATE_FULL${NC}"
    echo ""
    echo -e "  ${PURPLE}Fun Fact:${NC}"
    echo "  $FACT"
    echo ""

    say -v "$MY_VOICE" "$GREETING $MY_NAME! $FACT" &
    echo -e "${CYAN}──────────────────────────────────────────${NC}"
}
```

---

## The Diary Module

```bash
nano ~/mybot/modules/diary.sh
```

```bash
#!/bin/bash
# modules/diary.sh — Diary functions

diary_menu() {
    echo ""
    echo -e "${PURPLE}=== DIARY ===${NC}"
    echo "  1. Write a new entry"
    echo "  2. Read recent entries"
    echo "  3. Search diary"
    echo "  b. Back"
    echo ""
    echo -n "Choice: "
    read diary_choice

    case "$diary_choice" in
        1)
            echo "What happened today? (press Enter twice when done)"
            entry=""
            while IFS= read -r line; do
                [ -z "$line" ] && break
                entry+="$line"$'\n'
            done
            if [ -n "$entry" ]; then
                {
                    echo "=== $(date +'%A, %B %d, %Y') ==="
                    echo "$entry"
                    echo "---"
                } >> "${DIARY_FILE:-~/detective_diary.txt}"
                echo -e "${GREEN}Entry saved!${NC}"
            fi
            ;;
        2)
            tail -30 "${DIARY_FILE:-~/detective_diary.txt}" 2>/dev/null || echo "No diary yet!"
            ;;
        3)
            echo "Search for:"
            read search_word
            grep -n -i "$search_word" "${DIARY_FILE:-~/detective_diary.txt}" 2>/dev/null | head -20
            ;;
        b|B) return ;;
    esac
}
```

---

## The Main Program

```bash
nano ~/mybot/mybot.sh
```

```bash
#!/bin/bash
# mybot.sh — MyBot Personal Assistant

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/config.sh"
source "$SCRIPT_DIR/modules/briefing.sh"
source "$SCRIPT_DIR/modules/diary.sh"

show_banner() {
    clear
    echo ""
    echo -e "${BOLD}${CYAN}"
    echo "  ╔═══════════════════════════════════════╗"
    echo "  ║                                       ║"
    echo "  ║           M Y   B O T                 ║"
    echo "  ║     Personal Terminal Assistant       ║"
    echo "  ║                                       ║"
    echo "  ╚═══════════════════════════════════════╝"
    echo -e "${NC}"
    echo -e "  Hello, ${YELLOW}$MY_NAME${NC}! I am $BOT_NAME."
    echo ""
}

show_menu() {
    echo ""
    echo -e "${BOLD}  What would you like to do?${NC}"
    echo ""
    echo -e "  ${YELLOW}1.${NC} Morning Briefing"
    echo -e "  ${YELLOW}2.${NC} Diary"
    echo -e "  ${YELLOW}3.${NC} What time is it?"
    echo -e "  ${YELLOW}4.${NC} Open Home Folder in Finder"
    echo -e "  ${YELLOW}5.${NC} Fun Fact"
    echo -e "  ${RED}q.${NC} Quit"
    echo ""
    echo -n "  Enter choice: "
}

do_random_fact() {
    local FACTS=(
        "The first computer programmer was Ada Lovelace — in 1843."
        "The first computer bug was a real moth, stuck in a relay in 1947."
        "Python was named after Monty Python, not the snake."
        "Nintendo was founded in 1889 as a playing card company."
        "Cleopatra lived closer to the Moon landing than to the pyramids."
    )
    local FACT="${FACTS[$((RANDOM % ${#FACTS[@]}))]}"
    echo ""
    echo -e "  ${PURPLE}Did you know?${NC}"
    echo "  $FACT"
    echo ""
    say -v "$MY_VOICE" "$FACT" &
}

show_banner

while true; do
    show_menu
    read choice

    case "$choice" in
        1) do_briefing ;;
        2) diary_menu ;;
        3)
            echo ""
            echo -e "  ${CYAN}$(date +'%I:%M %p on %A, %B %d, %Y')${NC}"
            echo ""
            ;;
        4)
            open ~
            echo -e "  ${GREEN}Opened your home folder in Finder!${NC}"
            ;;
        5) do_random_fact ;;
        q|Q|quit|exit)
            echo ""
            echo -e "  ${YELLOW}Goodbye, $MY_NAME!${NC}"
            say -v "$MY_VOICE" "Goodbye $MY_NAME!" &
            echo ""
            exit 0
            ;;
        *)
            echo -e "  ${RED}Unknown option. Try again!${NC}"
            ;;
    esac

    echo ""
    echo -n "  Press Enter to return to menu..."
    read
    show_banner
done
```

---

## Running MyBot

```bash
chmod +x ~/mybot/mybot.sh
chmod +x ~/mybot/modules/*.sh
bash ~/mybot/mybot.sh
```

Add to `.zshrc`:
```bash
echo 'alias mybot="bash ~/mybot/mybot.sh"' >> ~/.zshrc
source ~/.zshrc
mybot
```

---

## Try It! — Quick Experiments

**Experiment 1:** Look at the starter file before diving into the full version:
```bash
cat playground/mission_12/mybot_starter.sh
```

Can you fill in the BLANK sections? Try it before looking at the full version above!

**Experiment 2:** Try every menu option in the full MyBot.

**Experiment 3:** Check the all_code_pieces sheet:
```bash
cat playground/mission_12/all_code_pieces.txt
```

Do you have all 12 code words?

---

## Your Mission — Complete MyBot AND the 12-Code Mystery

**Step 1:** Build and run MyBot using the full code above.

**Step 2:** Study the starter file (for reference):
```bash
cat playground/mission_12/mybot_starter.sh
```

**Step 3:** Collect all your code pieces. Use `ls -la` in each playground folder and `cat .secret_code.txt`.

Quick shortcut to see all code words:
```bash
grep "Code word:" playground/mission_*/.secret_code.txt
```

**Step 4:** Arrange them in order (Mission 1 through 12). What do they spell?

**Step 5:** Decode the final message:
```bash
cat playground/mission_12/congratulations.txt.enc | base64 -d
```

**Step 6:** Find this mission's hidden code:
```bash
ls -la playground/mission_12/
cat playground/mission_12/.secret_code.txt
```

---

## Challenges

### Challenge 1 — Add a Calculator

Add a menu option (6) called "Quick Calculator":
1. Ask the user for a math expression (like `5 * 7`)
2. Calculate with `echo $(($expr))`
3. Print the result

### Challenge 2 — Weather Widget

Add a weather option using `curl`:

```bash
get_weather() {
    echo "Which city?"
    read city
    curl -s "wttr.in/${city}?format=3"
}
```

### Challenge 3 — Cat Fact of the Day

Add a menu option that fetches a random cat fact:

```bash
do_cat_fact() {
    echo ""
    echo "  Cat Fact:"
    curl -s "https://catfact.ninja/fact" | grep -o '"fact":"[^"]*"' | cut -d'"' -f4
    echo ""
}
```

### Challenge 4 — Make It Your Own

Add one feature that YOU would actually use every day. Ideas:
- A countdown timer (from Mission 8)
- A to-do list (add and view items in a file)
- A random word from the dictionary
- A music player: `afplay ~/Music/somesong.mp3`

---

## Solutions

Solutions are in the [solutions folder](solutions/README.md).

---

## Powers Unlocked

This mission combined everything. Here is your full inventory:

| Mission | What You Can Do |
|---------|----------------|
| 1 | Open Terminal, basic commands, find hidden files |
| 2 | Navigate the filesystem like a detective |
| 3 | Create, copy, move, delete files and folders |
| 4 | Read and write files, decode base64 |
| 5 | Find any file, search inside files with grep |
| 6 | Chain commands with pipes, analyze data |
| 7 | Write real scripts with variables |
| 8 | Use loops and logic to automate anything |
| 9 | Talk to the internet from Terminal |
| 10 | Customize your terminal, build your lair |
| 11 | Set permissions, encode and encrypt |
| 12 | Build a complete CLI application |

---

*You built an app.*

*Not a toy. A real, working, menu-driven application. This is what programmers do. And you did it.*

---

## What Comes Next?

You have completed Terminal Quest: Detective Academy. But this is the beginning, not the end.

**Learn a programming language:**
- **Python** — reads almost like English, can do almost anything
- **Swift** — Apple's language for Mac and iPhone apps
- **Ruby** — elegant and fun

**Go deeper into the command line:**
- **Git** — the version control tool every programmer uses
- **vim** — the most powerful text editor
- **awk and sed** — advanced text processing

**Build real projects:**
- A website (HTML + CSS + JavaScript)
- A game (Python with pygame)
- Automate something annoying in your life with a shell script

The command line is not going anywhere. The people who know it well have a superpower most people do not.

*You have it now.*

---

*— Dad (Yosia)*

*P.S. I am proud of you. Not because you finished the missions, but because you opened Terminal in the first place. That takes courage. Most adults won't do it.*

*You did.*
