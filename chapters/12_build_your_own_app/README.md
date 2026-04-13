# Mission 12 — Build Your Own App

## Mission Briefing

This is it. The final mission.

Over the past 11 missions, you've learned to navigate the filesystem, create and destroy files, read and write data, find anything, chain commands together, write scripts, use loops and logic, talk to the internet, customize your environment, and even encrypt messages.

Now you put it all together.

You're going to build **MyBot** — a real, menu-driven personal assistant app that runs from your terminal. It will do multiple things: show your briefing, write diary entries, check the internet, organize files, and more. All from a single command.

This is the program programmers call a **CLI app** (Command Line Interface application). Real companies build these.

### What You'll Build
- A menu-driven app with numbered choices
- Functions for each feature (morning briefing, diary, internet check, etc.)
- A config system for your name and settings
- A clean main loop that keeps running until you exit

---

## Architecture First

Before writing code, good programmers **plan**. Here's the structure of MyBot:

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

The main program loads the modules, then shows a menu. You pick an option, it runs the right function. When done, it returns to the menu.

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

Type this:

```bash
#!/bin/bash
# config.sh — MyBot settings
# Edit these values to personalize your bot!

MY_NAME="Sophia"
MY_VOICE="Samantha"       # your favorite say voice
DIARY_FILE="$HOME/diary/journal.txt"
BOT_NAME="MyBot"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'   # No Color (reset)
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
        "A day on Venus is longer than a year on Venus."
        "Wombats produce cube-shaped poop. They are the only animals that do."
        "There are more stars in the universe than grains of sand on Earth."
        "Sharks are older than trees — they have been around for 450 million years."
    )
    local RANDOM_FACT="${FACTS[$((RANDOM % ${#FACTS[@]}))]}"

    echo ""
    echo -e "${CYAN}╔══════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}${BOLD}        MORNING BRIEFING FOR $MY_NAME         ${NC}${CYAN}║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${YELLOW}$GREETING, $MY_NAME!${NC}"
    echo -e "  ${GREEN}Today is $DATE_FULL${NC}"
    echo ""
    echo -e "  ${PURPLE}Fun Fact:${NC}"
    echo "  $RANDOM_FACT"
    echo ""

    say -v "$MY_VOICE" "$GREETING $MY_NAME! Today is $(date +'%A'). Fun fact: $RANDOM_FACT" &

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
    mkdir -p "$(dirname "$DIARY_FILE")"

    echo ""
    echo -e "${PURPLE}=== DIARY ===${NC}"
    echo "  1. Write a new entry"
    echo "  2. Read recent entries"
    echo "  3. Search diary"
    echo "  4. Count entries"
    echo "  b. Back to main menu"
    echo ""
    echo -n "Choice: "
    read diary_choice

    case "$diary_choice" in
        1)
            echo ""
            echo "What would you like to write?"
            echo "(Press Enter twice when done)"
            entry=""
            while IFS= read -r line; do
                [ -z "$line" ] && break
                entry+="$line"$'\n'
            done

            if [ -n "$entry" ]; then
                {
                    echo "=== $(date +'%A, %B %d, %Y at %I:%M %p') ==="
                    echo ""
                    echo "$entry"
                    echo "---"
                    echo ""
                } >> "$DIARY_FILE"
                echo -e "${GREEN}Entry saved!${NC}"
                say -v "$MY_VOICE" "Diary entry saved!" &
            else
                echo "No entry saved (was empty)."
            fi
            ;;
        2)
            if [ -f "$DIARY_FILE" ]; then
                echo ""
                echo -e "${CYAN}--- Last 30 lines of your diary ---${NC}"
                tail -30 "$DIARY_FILE"
            else
                echo "No diary yet! Write your first entry."
            fi
            ;;
        3)
            echo "Search for what word?"
            read search_word
            if [ -f "$DIARY_FILE" ]; then
                echo ""
                grep -n -i "$search_word" "$DIARY_FILE" | head -20
            fi
            ;;
        4)
            if [ -f "$DIARY_FILE" ]; then
                COUNT=$(grep -c "^===" "$DIARY_FILE")
                WORDS=$(wc -w < "$DIARY_FILE")
                echo ""
                echo -e "  ${GREEN}Total entries: $COUNT${NC}"
                echo -e "  ${GREEN}Total words: $WORDS${NC}"
            else
                echo "No diary yet!"
            fi
            ;;
        b|B)
            return
            ;;
    esac
}
```

---

## The Internet Module

```bash
nano ~/mybot/modules/internet.sh
```

```bash
#!/bin/bash
# modules/internet.sh — Internet checker

check_internet() {
    echo ""
    echo -e "${CYAN}=== INTERNET CHECK ===${NC}"

    if ping -c 1 -W 2 8.8.8.8 > /dev/null 2>&1; then
        echo -e "  ${GREEN}✓ Internet: Connected${NC}"
    else
        echo -e "  ${RED}✗ Internet: No connection${NC}"
        return
    fi

    PING_TIME=$(ping -c 3 google.com 2>/dev/null | tail -1 | awk -F'/' '{print $5}' | cut -d'.' -f1)
    if [ -n "$PING_TIME" ]; then
        if [ "$PING_TIME" -lt 50 ]; then
            SPEED_LABEL="Excellent"
            SPEED_COLOR="$GREEN"
        elif [ "$PING_TIME" -lt 100 ]; then
            SPEED_LABEL="Good"
            SPEED_COLOR="$YELLOW"
        else
            SPEED_LABEL="Slow"
            SPEED_COLOR="$RED"
        fi
        echo -e "  ${SPEED_COLOR}Ping: ${PING_TIME}ms ($SPEED_LABEL)${NC}"
    fi

    PUBLIC_IP=$(curl -s --max-time 3 ifconfig.me 2>/dev/null)
    if [ -n "$PUBLIC_IP" ]; then
        echo -e "  ${BLUE}Public IP: $PUBLIC_IP${NC}"
    fi

    echo ""
}
```

---

## The Files Module

```bash
nano ~/mybot/modules/files.sh
```

```bash
#!/bin/bash
# modules/files.sh — File utilities

files_menu() {
    echo ""
    echo -e "${PURPLE}=== FILE TOOLS ===${NC}"
    echo "  1. Count files in home folder"
    echo "  2. Find my largest files"
    echo "  3. Find recently changed files"
    echo "  4. Search for a file by name"
    echo "  b. Back to main menu"
    echo ""
    echo -n "Choice: "
    read files_choice

    case "$files_choice" in
        1)
            TOTAL=$(find ~ -type f 2>/dev/null | wc -l | tr -d ' ')
            echo ""
            echo -e "  ${GREEN}Total files in home folder: $TOTAL${NC}"
            echo ""
            echo "  Top 5 file types:"
            find ~ -type f 2>/dev/null | grep -o "\.[a-zA-Z0-9]*$" | sort | uniq -c | sort -rn | head -5 | while read count ext; do
                echo "    $ext: $count files"
            done
            ;;
        2)
            echo ""
            echo "  Files over 100MB:"
            find ~ -type f -size +100M 2>/dev/null | head -10
            ;;
        3)
            echo ""
            echo "  Modified in last 24 hours:"
            find ~ -type f -mtime -1 2>/dev/null | grep -v ".DS_Store" | head -15
            ;;
        4)
            echo "Search for filename (wildcards ok, e.g. *.pdf):"
            read search_name
            echo ""
            find ~ -name "$search_name" 2>/dev/null | head -20
            ;;
        b|B)
            return
            ;;
    esac
}
```

---

## The Main Program

Now the most important file — `mybot.sh`:

```bash
nano ~/mybot/mybot.sh
```

```bash
#!/bin/bash
# mybot.sh — MyBot Personal Assistant
# Usage: bash ~/mybot/mybot.sh
# Or: chmod +x ~/mybot/mybot.sh  then  ~/mybot/mybot.sh

# Load config and modules
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/config.sh"
source "$SCRIPT_DIR/modules/briefing.sh"
source "$SCRIPT_DIR/modules/diary.sh"
source "$SCRIPT_DIR/modules/internet.sh"
source "$SCRIPT_DIR/modules/files.sh"

# === BANNER ===
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
    echo -e "  Hello, ${YELLOW}$MY_NAME${NC}! I am $BOT_NAME. How can I help?"
    echo ""
}

# === MAIN MENU ===
show_menu() {
    echo ""
    echo -e "${BOLD}  What would you like to do?${NC}"
    echo ""
    echo -e "  ${YELLOW}1.${NC} Morning Briefing"
    echo -e "  ${YELLOW}2.${NC} Diary"
    echo -e "  ${YELLOW}3.${NC} Check Internet"
    echo -e "  ${YELLOW}4.${NC} File Tools"
    echo -e "  ${YELLOW}5.${NC} Open Home Folder in Finder"
    echo -e "  ${YELLOW}6.${NC} What time is it?"
    echo -e "  ${YELLOW}7.${NC} Surprise me!"
    echo -e "  ${RED}q.${NC} Quit"
    echo ""
    echo -n "  Enter choice: "
}

# === RANDOM FUN FACT ===
do_random_fact() {
    local FACTS=(
        "The first computer programmer was Ada Lovelace — a woman — in 1843."
        "The first computer bug was a real bug: a moth stuck in a relay in 1947."
        "Python was named after Monty Python, not the snake."
        "There are more lines of code in a modern iPhone than in the Apollo moon program."
        "The first domain name ever registered was Symbolics.com in 1985."
        "The @ symbol was chosen for email because it was rarely used and would not appear in names."
        "Cleopatra lived closer in time to the Moon landing than to the building of the pyramids."
        "A snail can sleep for three years."
        "Nintendo was founded in 1889 — originally as a playing card company."
    )
    local FACT="${FACTS[$((RANDOM % ${#FACTS[@]}))]}"
    echo ""
    echo -e "  ${PURPLE}Did you know?${NC}"
    echo "  $FACT"
    echo ""
    say -v "$MY_VOICE" "$FACT" &
}

# === MAIN LOOP ===
show_banner

while true; do
    show_menu
    read choice

    case "$choice" in
        1) do_briefing ;;
        2) diary_menu ;;
        3) check_internet ;;
        4) files_menu ;;
        5)
            open ~
            echo -e "  ${GREEN}Opened your home folder in Finder!${NC}"
            ;;
        6)
            echo ""
            echo -e "  ${CYAN}$(date +'%I:%M %p on %A, %B %d, %Y')${NC}"
            echo ""
            ;;
        7) do_random_fact ;;
        q|Q|quit|exit)
            echo ""
            echo -e "  ${YELLOW}Goodbye, $MY_NAME! See you next time.${NC}"
            echo ""
            say -v "$MY_VOICE" "Goodbye $MY_NAME!" &
            exit 0
            ;;
        *)
            echo -e "  ${RED}I do not understand '$choice'. Try again!${NC}"
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

Make everything executable:

```bash
chmod +x ~/mybot/mybot.sh
chmod +x ~/mybot/modules/*.sh
```

Run it:

```bash
bash ~/mybot/mybot.sh
```

Or add it to your `.zshrc` aliases (from Mission 10):

```bash
echo 'alias mybot="bash ~/mybot/mybot.sh"' >> ~/.zshrc
source ~/.zshrc
mybot
```

Now you can launch your personal assistant with a single word!

---

## Try It! — Quick Experiments

**Experiment 1:** Try every menu option. Go through each option at least once. Make sure your diary entry saves. Check the internet. Open Finder.

**Experiment 2:** Customize the banner. Edit `mybot.sh` and change the banner to say something more personal — your name, a subtitle, an emoji pattern.

**Experiment 3:** Change the voice in `config.sh` to your favorite voice from Mission 1. Does the briefing update automatically?

---

## Challenges

### Challenge 1 — Add a Calculator

Add a new menu option (8) called "Quick Calculator". It should:
1. Ask the user for a math expression (like `5 * 7` or `100 / 4`)
2. Calculate it using `echo "$((expression))"`
3. Print the result

**Hint:** `echo $((5 * 7))` prints `35`. Store the user's input with `read expr` and compute with `echo $(($expr))`.

### Challenge 2 — Weather Widget

Add a weather option using `curl`. The service `wttr.in` provides weather in the terminal:

```bash
get_weather() {
    echo "Which city?"
    read city
    echo ""
    curl -s "wttr.in/${city}?format=3"
    echo ""
}
```

Add this to `modules/internet.sh`, then add a menu option that calls it.

### Challenge 3 — Quote of the Day

Add a menu option that fetches an inspirational quote:

```bash
do_quote() {
    echo ""
    echo "  Quote of the moment:"
    curl -s "https://api.quotable.io/random" 2>/dev/null | python3 -c "
import sys, json
data = json.load(sys.stdin)
print('  \"' + data['content'] + '\"')
print('  — ' + data['author'])
" 2>/dev/null || echo "  Could not fetch quote (check your internet connection)"
    echo ""
}
```

### Challenge 4 — Make It Your Own

Add one feature that YOU would actually use every day. Some ideas:
- A countdown timer (reuse Mission 8's countdown script)
- A simple to-do list (add and view items stored in a file)
- A music player using `afplay ~/Music/somesong.mp3`
- A random word from the dictionary: `grep "." /usr/share/dict/words | shuf -n 1`

The only rule: it has to be something that makes you want to open MyBot.

---

## Solutions

Solutions are in the [solutions folder](solutions/README.md).

---

## Powers Unlocked

This mission combined everything from the whole book. Here is the full inventory of what you now know:

| Mission | What You Can Do |
|---------|----------------|
| 1 | Open Terminal, use basic commands, make your Mac speak |
| 2 | Navigate the filesystem like a pro |
| 3 | Create, copy, move, and delete files and folders |
| 4 | Read and write files, build a diary |
| 5 | Find any file, search inside files with grep |
| 6 | Chain commands with pipes, sort/count/analyze data |
| 7 | Write real scripts with variables and shebangs |
| 8 | Use loops and logic to automate repetitive work |
| 9 | Talk to the internet from Terminal |
| 10 | Customize your terminal to be your own space |
| 11 | Set permissions, hide files, encrypt messages |
| 12 | Build a complete CLI application |

---

*You built an app.*

*Not a toy. Not a homework exercise. A real, working, menu-driven application that runs on your computer and does things that matter to you.*

*This is what programmers do. And you did it.*

---

## What Comes Next?

You have finished Terminal Quest. But this is really the beginning, not the end. Here are some places to go from here:

**Learn a programming language:**
- **Python** — reads almost like English, can do almost anything
- **Ruby** — elegant and fun (check out *Ruby: The Kernighan Way* in this series!)
- **Swift** — Apple's language for building Mac and iPhone apps

**Go deeper into the command line:**
- **Git** — the version control tool every programmer uses
- **vim** — the most powerful text editor (steep learning curve, incredible payoff)
- **awk and sed** — advanced text processing tools

**Build real projects:**
- A website (HTML + CSS + JavaScript)
- A game (Python with pygame)
- A Mac app (Swift + Xcode)
- Automate something annoying in your daily life with a shell script

**Read:**
- *The Unix Programming Environment* — Kernighan & Pike (the original masters)
- *The Linux Command Line* — William Shotts (free at linuxcommand.org)
- *Learning Python* — Mark Lutz

The command line is not going anywhere. The people who know it well have a superpower that most people do not.

You have it now.

---

*— Dad (Yosia)*

*P.S. I am proud of you. Not because you finished the book, but because you opened Terminal in the first place. That takes courage. Most adults will not do it.*

*You did.*
