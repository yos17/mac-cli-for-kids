# Mission 12 — Build Your Own App

## Mission Briefing

*Final transmission from Commander Chen...*

> "Detective.
>
> This is it.
>
> Over eleven missions you have learned to navigate the filesystem, create and destroy files, read and write data, find anything with grep and find, chain commands with pipes, write scripts with variables and arrays, use loops and logic to automate repetitive work, talk to the internet, customize your terminal, set permissions, hide files, and encrypt messages.
>
> You have decoded intercepted messages. You have automated the evidence room. You have built a network investigator. You have created your personal command center.
>
> Now you put all of it together.
>
> Today you build **MyBot** — a real, menu-driven personal assistant application that runs from your terminal. A starter file is waiting for you in your case files. What you build from that starting point is up to you.
>
> When you finish, you will collect the final secret code and complete your Detective Academy graduation certificate. All twelve codes. All twelve missions.
>
> This is what you have been working toward.
>
> — Commander Chen"

---

## Your Case Files

Report to the graduation lab:

```bash
cd ~/mac-cli-for-kids/mission_12
ls -la
```

You should see:

```
all_code_pieces.txt   ← your graduation certificate — fill in all 12 codes
mybot_starter.sh      ← the starter script for MyBot (has TODOs for you to complete)
congratulations.txt   ← a final message, readable only when you have earned it
.secret_code.txt      ← hidden! (your final code word — find it last)
```

Read the starter script first:

```bash
cat mybot_starter.sh
```

This file has a working structure with placeholder `TODO` comments showing you exactly what needs to be built. Read through it completely before writing a single line of code. Good programmers read before they code.

Look at your graduation certificate:

```bash
cat all_code_pieces.txt
```

Twelve spaces. Twelve missions. If you have been collecting the secret codes along the way, you already have 11 of them written down. This mission provides the last one. When all 12 are filled in, you are done.

---

## Architecture First

Before writing code, good programmers **plan**. Here is the structure of MyBot:

```
mybot/
├── mybot.sh          ← the main program (menu and main loop)
├── config.sh         ← your settings (name, voice, colors)
└── modules/
    ├── briefing.sh   ← morning briefing function
    ├── diary.sh      ← diary entry functions
    ├── internet.sh   ← internet checker function
    └── files.sh      ← file tools function
```

The main program loads the modules, then shows a menu. You choose an option. It runs the right function. When it finishes, you return to the menu. This pattern — a main loop with a menu — is how hundreds of real-world CLI applications work.

---

## Setting Up the Project

```bash
mkdir -p ~/mybot/modules
```

The `mybot_starter.sh` in your case files is designed to be copied into `~/mybot/mybot.sh` as your starting point. But let us build the full version piece by piece so you understand every part.

---

## The Config File

```bash
nano ~/mybot/config.sh
```

```bash
#!/bin/bash
# config.sh — MyBot settings
# Edit these values to personalize your bot!

MY_NAME="Sophia"             # your name here
MY_VOICE="Samantha"          # your favorite voice from Mission 1
DIARY_FILE="$HOME/diary/journal.txt"
BOT_NAME="MyBot"

# Color codes (used throughout all modules)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'    # No Color — always reset to this at the end of colored text
```

---

## The Briefing Module

```bash
nano ~/mybot/modules/briefing.sh
```

```bash
#!/bin/bash
# modules/briefing.sh — Morning briefing function

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
        "Fingerprints were first used as evidence in 1892."
        "Sherlock Holmes was inspired by a real doctor named Joseph Bell."
        "The FBI was founded in 1908 with just 34 agents."
        "A bloodhound can follow a scent trail over 300 hours old."
        "Honey never expires — archaeologists found 3000-year-old honey."
        "Octopuses have three hearts and blue blood."
        "Crows can recognize human faces and hold grudges for years."
        "Wombats produce cube-shaped poop — the only animals that do."
        "There are more stars in the universe than grains of sand on Earth."
        "Sharks are older than trees — they have existed for 450 million years."
    )
    local RANDOM_FACT="${FACTS[$((RANDOM % ${#FACTS[@]}))]}"

    echo ""
    echo -e "${CYAN}╔══════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}${BOLD}      DETECTIVE ACADEMY DAILY BRIEFING    ${NC}${CYAN}║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${YELLOW}$GREETING, Detective $MY_NAME!${NC}"
    echo -e "  ${GREEN}Today is $DATE_FULL${NC}"
    echo ""
    echo -e "  ${PURPLE}Intelligence Report:${NC}"
    echo "  $RANDOM_FACT"
    echo ""

    say -v "$MY_VOICE" "$GREETING Detective $MY_NAME! Today is $(date +'%A'). Intelligence report: $RANDOM_FACT" &

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
    echo -e "${PURPLE}=== CASE JOURNAL ===${NC}"
    echo "  1. Write a new entry"
    echo "  2. Read recent entries"
    echo "  3. Search journal"
    echo "  4. Count entries"
    echo "  b. Back to main menu"
    echo ""
    echo -n "Choice: "
    read diary_choice

    case "$diary_choice" in
        1)
            echo ""
            echo "What happened today? (press Enter twice when done)"
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
                say -v "$MY_VOICE" "Journal entry saved." &
            else
                echo "No entry saved (nothing written)."
            fi
            ;;
        2)
            if [ -f "$DIARY_FILE" ]; then
                echo ""
                echo -e "${CYAN}--- Last 30 lines of your journal ---${NC}"
                tail -30 "$DIARY_FILE"
            else
                echo "No journal yet. Write your first entry!"
            fi
            ;;
        3)
            echo "Search for what word or phrase?"
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
                echo -e "  ${GREEN}Total words written: $WORDS${NC}"
            else
                echo "No journal yet!"
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
# modules/internet.sh — Internet checker and weather

check_internet() {
    echo ""
    echo -e "${CYAN}=== NETWORK STATUS ===${NC}"

    if ping -c 1 -W 2 8.8.8.8 > /dev/null 2>&1; then
        echo -e "  ${GREEN}Internet: Connected${NC}"
    else
        echo -e "  ${RED}Internet: No connection${NC}"
        return
    fi

    PING_TIME=$(ping -c 3 google.com 2>/dev/null | tail -1 | awk -F'/' '{print $5}' | cut -d'.' -f1)
    if [ -n "$PING_TIME" ]; then
        if [ "$PING_TIME" -lt 50 ]; then
            echo -e "  ${GREEN}Ping: ${PING_TIME}ms (Excellent)${NC}"
        elif [ "$PING_TIME" -lt 100 ]; then
            echo -e "  ${YELLOW}Ping: ${PING_TIME}ms (Good)${NC}"
        else
            echo -e "  ${RED}Ping: ${PING_TIME}ms (Slow)${NC}"
        fi
    fi

    PUBLIC_IP=$(curl -s --max-time 3 icanhazip.com 2>/dev/null)
    if [ -n "$PUBLIC_IP" ]; then
        echo -e "  ${BLUE}Public IP: $PUBLIC_IP${NC}"
    fi

    echo ""
}

get_weather() {
    echo "Which city do you want the weather for?"
    read city
    echo ""
    echo -e "${CYAN}Weather for $city:${NC}"
    curl -s "wttr.in/${city}?format=3" 2>/dev/null || echo "  (Could not fetch weather — check your connection)"
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
    echo "  2. Find largest files"
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

Now the most important file — `mybot.sh`. This is the heart of the application:

```bash
nano ~/mybot/mybot.sh
```

```bash
#!/bin/bash
# mybot.sh — MyBot Personal Detective Assistant
# Usage: bash ~/mybot/mybot.sh
# Or after chmod +x: ~/mybot/mybot.sh

# Load config and modules (all paths relative to this script's location)
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
    echo "  ╔═══════════════════════════════════════════╗"
    echo "  ║                                           ║"
    echo "  ║      M Y   B O T                         ║"
    echo "  ║      Detective Academy — Personal HQ      ║"
    echo "  ║                                           ║"
    echo "  ╚═══════════════════════════════════════════╝"
    echo -e "${NC}"
    echo -e "  Welcome back, ${YELLOW}Detective $MY_NAME${NC}. Standing by."
    echo ""
}

# === MAIN MENU ===
show_menu() {
    echo ""
    echo -e "${BOLD}  Select your operation:${NC}"
    echo ""
    echo -e "  ${YELLOW}1.${NC} Morning Briefing"
    echo -e "  ${YELLOW}2.${NC} Case Journal"
    echo -e "  ${YELLOW}3.${NC} Network Status"
    echo -e "  ${YELLOW}4.${NC} Weather Report"
    echo -e "  ${YELLOW}5.${NC} File Tools"
    echo -e "  ${YELLOW}6.${NC} Open Home Folder in Finder"
    echo -e "  ${YELLOW}7.${NC} What time is it?"
    echo -e "  ${YELLOW}8.${NC} Intelligence feed (random fact)"
    echo -e "  ${RED}q.${NC} Go dark (quit)"
    echo ""
    echo -n "  Enter choice: "
}

# === RANDOM INTELLIGENCE FACT ===
do_intel_fact() {
    local FACTS=(
        "The first computer programmer was Ada Lovelace in 1843."
        "The first computer bug was a real bug — a moth in a relay in 1947."
        "Python was named after Monty Python, not the snake."
        "There are more lines of code in a modern iPhone than in the Apollo program."
        "The first domain name ever registered was Symbolics.com in 1985."
        "Nintendo was founded in 1889 as a playing card company."
        "Cleopatra lived closer in time to the Moon landing than to the pyramids."
        "A snail can sleep for three years."
        "The unicorn is the national animal of Scotland."
        "Bananas are technically berries. Strawberries are not."
    )
    local FACT="${FACTS[$((RANDOM % ${#FACTS[@]}))]}"
    echo ""
    echo -e "  ${PURPLE}Intelligence Feed:${NC}"
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
        4) get_weather ;;
        5) files_menu ;;
        6)
            open ~
            echo -e "  ${GREEN}Home folder opened in Finder.${NC}"
            ;;
        7)
            echo ""
            echo -e "  ${CYAN}$(date +'%I:%M %p on %A, %B %d, %Y')${NC}"
            echo ""
            ;;
        8) do_intel_fact ;;
        q|Q|quit|exit)
            echo ""
            echo -e "  ${YELLOW}Going dark, Detective $MY_NAME. Stay safe out there.${NC}"
            echo ""
            say -v "$MY_VOICE" "Going dark, Detective $MY_NAME." &
            exit 0
            ;;
        *)
            echo -e "  ${RED}Unknown command: '$choice'. Try again.${NC}"
            ;;
    esac

    echo ""
    echo -n "  Press Enter to return to headquarters..."
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

Or add it as an alias in your `.zshrc` (from Mission 10) so you can launch it with a single word:

```bash
echo 'alias mybot="bash ~/mybot/mybot.sh"' >> ~/.zshrc
source ~/.zshrc
mybot
```

Now `mybot` is a real command on your computer.

---

## Using `mybot_starter.sh`

Your case files include `~/mac-cli-for-kids/mission_12/mybot_starter.sh`. Open it and compare it to what you just built:

```bash
cat ~/mac-cli-for-kids/mission_12/mybot_starter.sh
```

The starter file has `# TODO` comments in the places you would normally fill in. It is a template showing the structure of a real application — the same pattern professional developers use when starting a new project.

Try building a second bot from that starter file instead of copy-pasting the full version above. Fill in each `TODO` yourself. This is the harder, more rewarding path.

---

## Try It! — Quick Experiments

**Experiment 1:** Go through every menu option. Try options 1 through 8. Write a journal entry. Check your network status. See what the file tools show about your home folder.

**Experiment 2:** Customize the banner. Open `~/mybot/mybot.sh` in nano and change the `show_banner` function. Make the banner say something more personal — your name, your detective rank, an ASCII art design.

**Experiment 3:** Change the voice in `~/mybot/config.sh` to your favorite from Mission 1. Does the briefing update automatically the next time you run MyBot? It should — because all modules load config from the same file.

**Experiment 4:** Change `BOT_NAME` in `config.sh` to a custom name for your assistant. What would you call your personal terminal bot?

---

## Challenges

### Case #1201 — Add a Quick Calculator

Add a new menu option (9) called "Quick Calculator". It should:
1. Ask the user for a math expression (like `5 * 7` or `100 / 4`)
2. Calculate it with `echo "$(($expr))"`
3. Print the result with a label

```bash
do_calculator() {
    echo ""
    echo "Enter a math expression (e.g. 5 * 7 or 100 / 4):"
    read expr
    result=$(echo "$((expr))")
    echo -e "  ${GREEN}Result: $result${NC}"
    echo ""
}
```

Add it to the modules, add a menu entry, add a case in the main loop.

### Case #1202 — Weather Widget

The internet module already has a `get_weather` function (option 4). Now improve it: after showing the one-line summary, ask if the user wants the full forecast:

```bash
echo "Show full 3-day forecast? (y/n)"
read full
if [ "$full" = "y" ]; then
    curl -s "wttr.in/${city}"
fi
```

### Case #1203 — Quote of the Day

Add a menu option that fetches an inspirational quote from the api.github.com/zen endpoint (which you already know from Mission 9). Every time you pick this option, you get a different short piece of programming wisdom. No external dependencies needed — you already have `curl`.

### Case #1204 — Make It Yours

Add one feature that YOU would actually use every day. Some ideas:
- A countdown timer (reuse Mission 8's while-loop countdown)
- A to-do list (add tasks to a file, view them, mark them done)
- A random word from the dictionary: `grep "." /usr/share/dict/words | shuf -n 1`
- A music player: `afplay ~/Music/somesong.mp3`
- A random quote from `~/mac-cli-for-kids/mission_07/names.txt` to pick a detective partner for the day

The only rule: it has to be something that makes you want to open MyBot.

---

## The Graduation Certificate

Open your certificate file:

```bash
cat ~/mac-cli-for-kids/mission_12/all_code_pieces.txt
```

There are 12 slots — one for each mission's secret code word. Fill them all in. If you collected the codes as you went, you already have all of them except the last one.

Now find the final code:

```bash
cd ~/mac-cli-for-kids/mission_12
ls -a
```

Find `.secret_code.txt` and read it. That is your twelfth and final word.

Once you have all 12 words written down in order, read `congratulations.txt`:

```bash
cat ~/mac-cli-for-kids/mission_12/congratulations.txt
```

The twelve words together form a sentence. If you have been collecting them in order from Mission 1 through Mission 12, that sentence is your graduation message from the Detective Academy.

---

## Solutions

Solutions are in the [solutions folder](solutions/README.md).

---

## Powers Unlocked

This mission combined everything from the entire book. Here is the full inventory of what you now know:

| Mission | What You Can Do |
|---------|----------------|
| 1 | Open Terminal, use basic commands, make your Mac speak |
| 2 | Navigate the filesystem like a professional |
| 3 | Create, copy, move, and delete files and folders |
| 4 | Read and write files, build a diary |
| 5 | Find any file, search inside files with grep |
| 6 | Chain commands with pipes, sort and count and analyze data |
| 7 | Write real scripts with variables, arrays, and shebangs |
| 8 | Use loops and logic to automate repetitive work |
| 9 | Talk to the internet from Terminal, read network logs |
| 10 | Customize your terminal into a personal command center |
| 11 | Set permissions, hide files, encode and encrypt messages |
| 12 | Build a complete, menu-driven CLI application |

---

## What Comes Next?

You have finished Terminal Quest: Detective Academy. But this is the beginning, not the end.

**Learn a programming language:**
- **Python** — reads almost like English, can do almost anything. Your shell skills transfer directly.
- **Ruby** — elegant and fun. Similar to Python, with a different philosophy.
- **Swift** — Apple's language for building Mac and iPhone apps. Xcode is free.

**Go deeper into the command line:**
- **Git** — the version control tool every programmer on the planet uses. Essential.
- **vim** — the most powerful text editor (steep learning curve, enormous payoff)
- **awk and sed** — advanced text processing tools that make Mission 6's pipes look simple

**Build real projects:**
- A website (HTML + CSS + JavaScript)
- A game (Python with pygame)
- A Mac app (Swift + Xcode)
- A script that automates something genuinely annoying in your daily life

**Read:**
- *The Linux Command Line* — William Shotts (free at linuxcommand.org)
- *Learning Python* — Mark Lutz
- *The Unix Programming Environment* — Kernighan and Pike (the original masters)

The command line is not going anywhere. It has been the foundation of computing for fifty years and it will be for fifty more. The people who know it deeply have a superpower that most people — including most adults — do not have.

You have it now.

---

*You built an app.*

*Not a toy. Not a homework exercise. A real, working, menu-driven application that runs on your computer and does things that actually matter to you. You wrote the config file, the modules, the main loop — all of it.*

*This is what programmers do. You did it.*

*Detective Academy graduation is confirmed.*

---

*— Yosia*

*P.S. Be proud of yourself. Not because you finished the book, but because you opened Terminal in the first place. That takes courage. Most adults will not do it.*

*You did.*
