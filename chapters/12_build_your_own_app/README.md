# CASE FILE #12 — "The Grand Finale"
**Terminal Detective Agency | Clearance Level: DIRECTOR**

---

## 🔍 MISSION BRIEFING

**INCOMING TRANSMISSION — DIRECTOR CHEN — MAXIMUM PRIORITY**

Agent,

You've made it.

Eleven missions. Eleven code pieces. A complete transformation from someone who had never opened Terminal to someone who can navigate the filesystem blindfolded, write real automation scripts, talk to the internet from the command line, lock and encrypt sensitive files, and customize every aspect of their working environment.

That's not small. Most people — most *adults* — never get there.

Now comes the final mission. The one that was always waiting at the end.

**Your final assignment: build MyBot.**

MyBot is a real, menu-driven personal assistant application that runs from your terminal. Not a homework exercise. Not a toy. A working CLI app — the same kind of application that real developers build at real companies. It has a configuration system, multiple feature modules, a main menu loop, and it does actual things that matter to you.

When you finish building it, you'll launch it with one word from anywhere on your Mac.

And when you're done with that — find the final code piece (#12), collect it alongside the eleven you already have, and assemble them all into the complete secret phrase. Then open `FINAL_TREASURE.txt` for the message waiting for you there.

**Your mission objectives:**
1. Read your case briefing and review all your collected clues
2. Study the starter script and understand how it's structured
3. Build all five required modules: briefing, diary, internet, files, and your own custom feature
4. Put everything together in a working main application
5. Run the Secret Code Assembler to reveal the complete phrase
6. Open the Final Treasure

**Access your case files:**
```bash
cd playground/mission_12
```

**Read your final case briefing:**
```bash
cat playground/mission_12/case_briefing.txt
```

---

## 📚 DETECTIVE TRAINING: Building a Real Application

### Architecture — The Blueprint Comes First

Before writing a single line of code, professional programmers **plan the structure**. They ask: What does this application need to do? How should those features be organized? Which parts are shared, and which parts stand alone?

This planning phase is called **architecture** — the art of designing how the pieces fit together before building any of them.

Here's the architecture for MyBot:

```
mybot/
├── mybot.sh          ← the main program (the entry point — where everything starts)
├── config.sh         ← your settings (name, voice, colors — defined once, used everywhere)
└── modules/
    ├── briefing.sh   ← the morning briefing feature
    ├── diary.sh      ← diary read/write features
    ├── internet.sh   ← internet status checker
    └── files.sh      ← file exploration tools
```

This structure has a name: **modular architecture**. Each feature lives in its own file. The main program loads all the modules, then runs a menu. You pick an option, the right function runs. When it finishes, you return to the menu. The loop continues until you decide to exit.

### Why Modular Architecture?

You could put everything in one giant `mybot.sh` file. Many beginners do. So why split it up?

**1. Easier to read.** When `mybot.sh` is 50 lines long instead of 500, anyone can understand it at a glance. The details live in the module files where they belong.

**2. Easier to debug.** A bug in the diary feature is in `diary.sh`. You don't have to hunt through hundreds of lines to find it.

**3. Easier to extend.** Want to add a weather feature? Create `modules/weather.sh`, write the function, and add one line to `mybot.sh` to load it. Nothing else changes.

**4. Easier to collaborate.** You could hand someone `modules/internet.sh` and ask them to improve the internet checker, without them needing to understand the rest of the app.

**5. Easier to reuse.** The `briefing()` function you write for MyBot could be dropped into any other script. It's a self-contained unit.

This is how every large real-world software application is built. Programs that run the internet, power smartphones, and control spacecraft are all made of modules that communicate with each other through defined interfaces.

### How `source` Makes Modules Work

The main program loads its modules using `source`:

```bash
source "$SCRIPT_DIR/config.sh"
source "$SCRIPT_DIR/modules/briefing.sh"
source "$SCRIPT_DIR/modules/diary.sh"
```

`source` runs a file's contents in the current shell session. It's like typing all those lines yourself at the current prompt. After `source "$SCRIPT_DIR/modules/briefing.sh"`, the `do_briefing()` function is available as if you'd defined it right here.

This is different from running a script normally (like `bash script.sh`), which creates a new subprocess. That subprocess has its own environment, and when it ends, its functions and variables disappear. `source` keeps everything in the same environment.

### Finding the Script's Own Location

When `mybot.sh` runs, it needs to find the modules folder relative to itself. But `mybot.sh` might be called from any directory. How does it know where it is?

```bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
```

Let's unpack this:
- `${BASH_SOURCE[0]}` — the path to the currently executing script
- `dirname "${BASH_SOURCE[0]}"` — the directory portion of that path (strips the filename)
- `cd "$(dirname ...)"` — change into that directory
- `pwd` — print the absolute path of where we just went
- `$(...)` — run the command inside and use its output

The whole thing: "go to the directory containing this script, then print its absolute path." After this, `$SCRIPT_DIR` is the full absolute path to the `mybot/` folder, no matter where the script was launched from.

### Menu-Driven Interfaces — The Core Pattern

A menu-driven interface is one of the most useful patterns in all of programming. The user sees a list of numbered options, types a choice, the program does something, and returns to the menu. Repeat until the user exits.

You already know `case` statements from Mission 8. Here's the full menu pattern:

```bash
while true; do
    echo "1. Option one"
    echo "2. Option two"
    echo "q. Quit"
    echo -n "Your choice: "
    read choice

    case "$choice" in
        1) function_for_option_one ;;
        2) function_for_option_two ;;
        q|Q) exit 0 ;;
        *) echo "Unknown option. Try again." ;;
    esac
done
```

The `while true` creates an infinite loop. The only way out is `exit 0` (or `break`). The `case` statement routes each input to the right function. The `*)` catches anything that didn't match any option — always include this for graceful error handling.

This same pattern, in various forms, runs every app that has a menu — from ATM machines to command-line tools at tech companies.

### `case` Statement — Deep Understanding

`case` is a multi-way branch: test one variable against multiple patterns and run the matching block.

```bash
case "$variable" in
    "exact_value")
        echo "Matched exact_value"
        ;;
    pattern*)
        echo "Matched anything starting with 'pattern'"
        ;;
    value1|value2)
        echo "Matched either value1 or value2"
        ;;
    [0-9])
        echo "Matched a single digit"
        ;;
    *)
        echo "Nothing else matched — this is the default"
        ;;
esac
```

Key rules:
- Each pattern block ends with `;;` — think of it as "stop here"
- Patterns can use wildcards: `*` (any characters), `?` (one character), `[abc]` (character class)
- Patterns can be ORed with `|`: `yes|y|YES)` matches any of those three
- The `*)` default case is optional but strongly recommended — always handle unexpected input

### Configuration Files — The Settings Pattern

The `config.sh` file holds all your settings in one place. The main program loads it first:

```bash
source "$SCRIPT_DIR/config.sh"
```

After that, every module can use `$MY_NAME`, `$MY_VOICE`, `$CYAN`, `$NC` — all defined in one place, used everywhere.

The key principle: **define once, use everywhere**. If you want to change your agent name, change it in `config.sh`. Every part of the app automatically uses the new value. You never have to search through multiple files to update the same thing.

This is the Single Source of Truth principle — one of the most important ideas in software engineering.

### Color Codes in Shell Scripts

The color variables in `config.sh` use ANSI escape sequences:

```bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'   # No Color (reset)
```

`\033` is the escape character (also written as `\e` or `\x1b`). The `[0;31m` part tells the terminal which color to use. `NC` resets back to normal.

To use them in `echo`, you must add the `-e` flag (enables escape sequences):

```bash
echo -e "${GREEN}This text is green${NC} and this is normal."
echo -e "${BOLD}${CYAN}Bold cyan text${NC}"
```

Without `-e`, the escape sequences print literally as `\033[0;32m` instead of showing color.

### Local Variables in Functions

When you define variables inside a function, you should make them `local` to avoid accidentally changing global variables with the same name:

```bash
do_something() {
    local message="hello"     # local — only exists inside this function
    global_var="changed"      # NOT local — changes the variable everywhere!
    echo "$message"
}
```

Use `local` for any variable that's only needed inside a function. This prevents subtle bugs where one function accidentally stomps on another function's data.

---

## 🧪 FIELD WORK

Before building your own version of MyBot, study what the agency has prepared.

### Step 1 — Review Your Mission History

```bash
# Read your final case briefing
cat playground/mission_12/case_briefing.txt

# Review all the clues you've collected
cat playground/mission_12/all_clues.txt
```

The `all_clues.txt` file has a complete table of all 12 missions and their code pieces. If you've been following along, you should have eleven pieces already. Check which one you still need.

### Step 2 — Walk Through Your Case File Archive

```bash
# List all case summaries
ls playground/mission_12/case_files/

# Read a few to remember what you learned
cat playground/mission_12/case_files/case_01.txt
cat playground/mission_12/case_files/case_05.txt
cat playground/mission_12/case_files/case_09.txt
```

These summaries show you how far you've traveled. Mission 1 you learned to open Terminal. By Mission 9 you were talking to APIs on the internet.

### Step 3 — Study the Starter Script

```bash
# Read the template the agency prepared
cat playground/mission_12/mystery_solution_template.sh

# Make it executable and run it
chmod +x playground/mission_12/mystery_solution_template.sh
./playground/mission_12/mystery_solution_template.sh
```

What does it do already? What's missing? The template is a skeleton — you'll flesh it out into the complete application.

### Step 4 — Preview the Final Treasure

You can read `FINAL_TREASURE.txt` now if you want a peek at what's waiting, but the experience will be better once you've earned it through the mission:

```bash
ls playground/mission_12/
```

You can see `FINAL_TREASURE.txt` listed there. It'll be waiting for you when the time comes.

---

## 🎯 MISSION: Build MyBot — Your Personal Detective Assistant

Work through each step. Follow them in order — each step builds on the previous one.

### Step 1 — Set Up the Project Structure

```bash
mkdir -p ~/mybot/modules
ls ~/mybot/   # Should show a modules/ folder
```

### Step 2 — Create the Configuration File

```bash
nano ~/mybot/config.sh
```

```bash
#!/bin/bash
# config.sh — MyBot settings
# Edit these values to personalize your detective assistant!

MY_NAME="Agent"           # YOUR name or code name goes here
MY_VOICE="Samantha"       # Your favorite say voice from Mission 1
DIARY_FILE="$HOME/diary/journal.txt"
BOT_NAME="MyBot"

# ANSI Color Codes
# These are loaded once here; every module can use them
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'   # No Color — reset to normal
```

Customize `MY_NAME` with your actual agent name. Change `MY_VOICE` if you discovered a better voice in Mission 1.

### Step 3 — Build the Briefing Module

```bash
nano ~/mybot/modules/briefing.sh
```

```bash
#!/bin/bash
# modules/briefing.sh — Morning briefing

do_briefing() {
    local DATE_FULL=$(date +"%A, %B %d, %Y")
    local HOUR=$(date +"%H")

    # Choose greeting based on time of day
    if [ "$HOUR" -lt 12 ]; then
        local GREETING="Good morning"
    elif [ "$HOUR" -lt 17 ]; then
        local GREETING="Good afternoon"
    else
        local GREETING="Good evening"
    fi

    # Random fact database — add your own!
    local FACTS=(
        "A group of flamingos is called a flamboyance."
        "Honey never expires — archaeologists found 3000-year-old honey in Egyptian tombs."
        "Octopuses have three hearts and blue blood."
        "The unicorn is the national animal of Scotland."
        "Bananas are technically berries. Strawberries are not."
        "Crows can recognize individual human faces and hold grudges for years."
        "A day on Venus is longer than a year on Venus."
        "Wombats produce cube-shaped poop — the only animals in the world that do."
        "There are more stars in the universe than grains of sand on all of Earth's beaches."
        "Sharks are older than trees — they've been swimming for 450 million years."
    )
    local RANDOM_FACT="${FACTS[$((RANDOM % ${#FACTS[@]}))]}"

    echo ""
    echo -e "${CYAN}╔══════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}${BOLD}      MORNING BRIEFING FOR $MY_NAME           ${NC}${CYAN}║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${YELLOW}$GREETING, $MY_NAME!${NC}"
    echo -e "  ${GREEN}Today is $DATE_FULL${NC}"
    echo ""
    echo -e "  ${PURPLE}Today's Fun Fact:${NC}"
    echo "  $RANDOM_FACT"
    echo ""

    # Read the fact aloud in the background (& means don't wait for it)
    say -v "$MY_VOICE" "$GREETING $MY_NAME! Today is $(date +'%A'). Fun fact: $RANDOM_FACT" &

    echo -e "${CYAN}──────────────────────────────────────────${NC}"
}
```

### Step 4 — Build the Diary Module

```bash
nano ~/mybot/modules/diary.sh
```

```bash
#!/bin/bash
# modules/diary.sh — Diary functions

diary_menu() {
    mkdir -p "$(dirname "$DIARY_FILE")"

    echo ""
    echo -e "${PURPLE}╔═══════════════╗${NC}"
    echo -e "${PURPLE}║     DIARY     ║${NC}"
    echo -e "${PURPLE}╚═══════════════╝${NC}"
    echo ""
    echo "  1. Write a new entry"
    echo "  2. Read recent entries"
    echo "  3. Search diary"
    echo "  4. Count entries and words"
    echo "  b. Back to main menu"
    echo ""
    echo -n "  Choice: "
    read diary_choice

    case "$diary_choice" in
        1)
            echo ""
            echo "What would you like to write?"
            echo "(Press Enter twice when done)"
            local entry=""
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
                echo -e "${GREEN}Entry saved to $DIARY_FILE${NC}"
                say -v "$MY_VOICE" "Diary entry saved!" &
            else
                echo "No entry saved — it was empty."
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
            echo -n "  Search for what word or phrase? "
            read search_word
            if [ -f "$DIARY_FILE" ]; then
                echo ""
                grep -n -i --color=auto "$search_word" "$DIARY_FILE" | head -20
            fi
            ;;
        4)
            if [ -f "$DIARY_FILE" ]; then
                local COUNT=$(grep -c "^===" "$DIARY_FILE")
                local WORDS=$(wc -w < "$DIARY_FILE")
                echo ""
                echo -e "  ${GREEN}Total diary entries: $COUNT${NC}"
                echo -e "  ${GREEN}Total words written: $WORDS${NC}"
            else
                echo "No diary yet!"
            fi
            ;;
        b|B) return ;;
    esac
}
```

### Step 5 — Build the Internet Module

```bash
nano ~/mybot/modules/internet.sh
```

```bash
#!/bin/bash
# modules/internet.sh — Internet checker

check_internet() {
    echo ""
    echo -e "${CYAN}╔═══════════════════════╗${NC}"
    echo -e "${CYAN}║    INTERNET CHECK     ║${NC}"
    echo -e "${CYAN}╚═══════════════════════╝${NC}"
    echo ""

    # Quick connectivity test to Google's DNS (8.8.8.8)
    if ping -c 1 -W 2 8.8.8.8 > /dev/null 2>&1; then
        echo -e "  ${GREEN}✓ Internet: Connected${NC}"
    else
        echo -e "  ${RED}✗ Internet: No connection detected${NC}"
        return
    fi

    # Measure ping speed (three pings to google.com)
    local PING_TIME=$(ping -c 3 google.com 2>/dev/null | tail -1 | awk -F'/' '{print $5}' | cut -d'.' -f1)
    if [ -n "$PING_TIME" ]; then
        if [ "$PING_TIME" -lt 50 ]; then
            local SPEED_LABEL="Excellent"
            local SPEED_COLOR="$GREEN"
        elif [ "$PING_TIME" -lt 100 ]; then
            local SPEED_LABEL="Good"
            local SPEED_COLOR="$YELLOW"
        else
            local SPEED_LABEL="Slow"
            local SPEED_COLOR="$RED"
        fi
        echo -e "  ${SPEED_COLOR}Ping: ${PING_TIME}ms ($SPEED_LABEL)${NC}"
    fi

    # Get your public IP address
    local PUBLIC_IP=$(curl -s --max-time 3 ifconfig.me 2>/dev/null)
    if [ -n "$PUBLIC_IP" ]; then
        echo -e "  ${BLUE}Your public IP: $PUBLIC_IP${NC}"
    fi

    echo ""
}
```

### Step 6 — Build the Files Module

```bash
nano ~/mybot/modules/files.sh
```

```bash
#!/bin/bash
# modules/files.sh — File utilities

files_menu() {
    echo ""
    echo -e "${PURPLE}╔══════════════════╗${NC}"
    echo -e "${PURPLE}║    FILE TOOLS    ║${NC}"
    echo -e "${PURPLE}╚══════════════════╝${NC}"
    echo ""
    echo "  1. Count files in home folder"
    echo "  2. Find my largest files"
    echo "  3. Find recently changed files"
    echo "  4. Search for a file by name"
    echo "  b. Back to main menu"
    echo ""
    echo -n "  Choice: "
    read files_choice

    case "$files_choice" in
        1)
            local TOTAL=$(find ~ -type f 2>/dev/null | wc -l | tr -d ' ')
            echo ""
            echo -e "  ${GREEN}Total files in your home folder: $TOTAL${NC}"
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
            echo ""
            ;;
        3)
            echo ""
            echo "  Modified in the last 24 hours:"
            find ~ -type f -mtime -1 2>/dev/null | grep -v ".DS_Store" | head -15
            echo ""
            ;;
        4)
            echo -n "  Search for filename (wildcards ok, e.g. *.pdf): "
            read search_name
            echo ""
            find ~ -name "$search_name" 2>/dev/null | head -20
            echo ""
            ;;
        b|B) return ;;
    esac
}
```

### Step 7 — Build the Main Program

This is the heart of MyBot. Every module comes together here.

```bash
nano ~/mybot/mybot.sh
```

```bash
#!/bin/bash
# mybot.sh — MyBot Personal Detective Assistant
# Usage: bash ~/mybot/mybot.sh
# Or after adding alias: mybot

# ── LOAD CONFIG AND ALL MODULES ──────────────────────────────
# Find the absolute path of the folder containing this script.
# This works no matter where you call mybot from.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/config.sh"
source "$SCRIPT_DIR/modules/briefing.sh"
source "$SCRIPT_DIR/modules/diary.sh"
source "$SCRIPT_DIR/modules/internet.sh"
source "$SCRIPT_DIR/modules/files.sh"

# ── BANNER ───────────────────────────────────────────────────
show_banner() {
    clear
    echo ""
    echo -e "${BOLD}${CYAN}"
    echo "  ╔═══════════════════════════════════════╗"
    echo "  ║                                       ║"
    echo "  ║           M Y   B O T                 ║"
    echo "  ║     Personal Detective Assistant      ║"
    echo "  ║                                       ║"
    echo "  ╚═══════════════════════════════════════╝"
    echo -e "${NC}"
    echo -e "  Hello, ${YELLOW}$MY_NAME${NC}! I am ${BOT_NAME}. Ready to assist."
    echo ""
}

# ── MAIN MENU ────────────────────────────────────────────────
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
    echo -e "  ${YELLOW}7.${NC} Surprise Me!"
    echo -e "  ${RED}q.${NC} Quit"
    echo ""
    echo -n "  Enter choice: "
}

# ── RANDOM FACT ──────────────────────────────────────────────
do_random_fact() {
    local FACTS=(
        "The first computer programmer was Ada Lovelace — a woman — in 1843."
        "The first computer bug was a real bug: a moth stuck in a relay in 1947."
        "Python was named after Monty Python's Flying Circus, not the snake."
        "There are more lines of code in a modern iPhone than in the Apollo moon program."
        "The first domain name ever registered was Symbolics.com in 1985."
        "The @ symbol was chosen for email addresses because it was rarely used in names."
        "Cleopatra lived closer in time to the Moon landing than to the building of the pyramids."
        "A snail can sleep for three years at a stretch."
        "Nintendo was founded in 1889 — originally as a playing card company."
        "The average person walks about 100,000 miles in their lifetime — enough to circle Earth four times."
    )
    local FACT="${FACTS[$((RANDOM % ${#FACTS[@]}))]}"
    echo ""
    echo -e "  ${PURPLE}Did you know?${NC}"
    echo "  $FACT"
    echo ""
    say -v "$MY_VOICE" "$FACT" &
}

# ── MAIN LOOP ────────────────────────────────────────────────
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
            echo -e "  ${YELLOW}Goodbye, $MY_NAME! The agency is always here when you need it.${NC}"
            echo ""
            say -v "$MY_VOICE" "Goodbye $MY_NAME, stay safe out there." &
            exit 0
            ;;
        *)
            echo -e "  ${RED}Unknown option: '$choice'. Try a number from the menu above.${NC}"
            ;;
    esac

    echo ""
    echo -n "  Press Enter to return to menu..."
    read
    show_banner
done
```

### Step 8 — Make Everything Executable

```bash
chmod +x ~/mybot/mybot.sh
chmod +x ~/mybot/modules/*.sh
```

### Step 9 — Run Your Application

```bash
bash ~/mybot/mybot.sh
```

Try every menu option. Does the morning briefing display correctly? Does the diary save entries? Does the internet check show your connection status?

### Step 10 — Add It as a Permanent Alias

```bash
echo 'alias mybot="bash ~/mybot/mybot.sh"' >> ~/.zshrc
source ~/.zshrc
mybot
```

Now you can launch your personal detective assistant with a single word from anywhere on your Mac.

---

## Completing the Five Required Features

Your MyBot needs these five features to be complete.

### Feature 1 — Morning Briefing ✓
Already built in `modules/briefing.sh` and wired to menu option 1.

### Feature 2 — Case File Browser

Add this to your files module or create `~/mybot/modules/cases.sh`:

```bash
case_browser() {
    local CASE_DIR="$HOME/playground/mission_12/case_files"

    echo ""
    echo -e "${CYAN}=== CASE FILE ARCHIVE ===${NC}"

    if [ ! -d "$CASE_DIR" ]; then
        echo "  Case file directory not found at: $CASE_DIR"
        return
    fi

    echo ""
    echo "  Available case files:"
    ls "$CASE_DIR" | nl -ba   # nl adds line numbers

    echo ""
    echo -n "  Enter case number to read (or b to go back): "
    read case_choice

    if [ "$case_choice" = "b" ] || [ "$case_choice" = "B" ]; then
        return
    fi

    local files=("$CASE_DIR"/*)
    local selected="${files[$((case_choice - 1))]}"

    if [ -f "$selected" ]; then
        echo ""
        echo -e "${YELLOW}=== $(basename "$selected") ===${NC}"
        cat "$selected"
        echo ""
    else
        echo -e "  ${RED}Invalid choice.${NC}"
    fi
}
```

Add it as menu option 8 in `mybot.sh`:
```bash
echo -e "  ${YELLOW}8.${NC} Case File Browser"
# ...in the case statement:
8) case_browser ;;
```

If you created a separate `cases.sh` file, source it in `mybot.sh`:
```bash
source "$SCRIPT_DIR/modules/cases.sh"
```

### Feature 3 — Clue Searcher

Add this function (to `files.sh` or its own module):

```bash
clue_searcher() {
    echo ""
    echo -e "${CYAN}=== CLUE SEARCHER ===${NC}"
    echo ""
    echo -n "  Search for what word or phrase? "
    read search_term

    if [ -z "$search_term" ]; then
        echo "  No search term entered."
        return
    fi

    echo ""
    echo "  Searching all playground files for: '$search_term'"
    echo ""

    local found=0
    grep -r --include="*.txt" --include="*.sh" -l "$search_term" ~/playground/ 2>/dev/null | while read file; do
        echo -e "  ${GREEN}Found in:${NC} $file"
        grep -n "$search_term" "$file" | head -3 | sed 's/^/    /'
        echo ""
        found=1
    done

    if [ "$found" -eq 0 ]; then
        echo "  No matches found for '$search_term'"
    fi
}
```

Add as menu option 9.

### Feature 4 — Secret Code Assembler

This is the big one. Add this function:

```bash
assemble_codes() {
    echo ""
    echo -e "${BOLD}${CYAN}╔══════════════════════════════════════════╗${NC}"
    echo -e "${BOLD}${CYAN}║          SECRET CODE ASSEMBLER           ║${NC}"
    echo -e "${BOLD}${CYAN}╚══════════════════════════════════════════╝${NC}"
    echo ""

    local code_files=(
        "$HOME/playground/mission_01/secret_code_piece.txt"
        "$HOME/playground/mission_02/secret_code_piece.txt"
        "$HOME/playground/mission_03/secret_code_piece.txt"
        "$HOME/playground/mission_04/secret_code_piece.txt"
        "$HOME/playground/mission_05/.hidden/secret_code_piece.txt"
        "$HOME/playground/mission_06/secret_code_piece.txt"
        "$HOME/playground/mission_07/secret_code_piece.txt"
        "$HOME/playground/mission_08/secret_code_piece.txt"
        "$HOME/playground/mission_09/secret_code_piece.txt"
        "$HOME/playground/mission_10/secret_code_piece.txt"
        "$HOME/playground/mission_11/secret_code_piece.txt"
        "$HOME/playground/mission_12/secret_code_piece.txt"
    )

    local phrase=""
    local i=1
    local missing=0

    for file in "${code_files[@]}"; do
        if [ -f "$file" ]; then
            local word=$(cat "$file" | tr -d '[:space:]')
            echo -e "  Piece $i:  ${GREEN}$word${NC}"
            phrase="$phrase $word"
        else
            echo -e "  Piece $i:  ${RED}[NOT FOUND — check $(dirname "$file")]${NC}"
            missing=$((missing + 1))
        fi
        i=$((i + 1))
    done

    echo ""
    if [ "$missing" -eq 0 ]; then
        echo -e "${BOLD}${YELLOW}  ★ Complete phrase: $phrase ★${NC}"
        echo ""
        echo -e "  ${GREEN}All 12 pieces collected! The mission is complete.${NC}"
        say -v "$MY_VOICE" "Congratulations! The complete phrase is: $phrase" &
    else
        echo -e "  ${YELLOW}  Assembled so far:$phrase${NC}"
        echo -e "  ${RED}  $missing piece(s) still missing.${NC}"
    fi
    echo ""
}
```

Add as menu option 10.

### Feature 5 — Your Custom Feature

This is yours to design. Here are four detailed options — pick one (or invent your own):

**Option A — Quick Calculator:**
```bash
do_calculator() {
    echo ""
    echo -e "${CYAN}=== QUICK CALCULATOR ===${NC}"
    echo ""
    echo "  Enter a math expression (e.g., 5 * 7 or 100 / 4 or 2 ** 8):"
    echo -n "  > "
    read expr

    # $(( )) evaluates math in bash
    local result=$(echo "$((expr))" 2>/dev/null)

    if [ $? -eq 0 ] && [ -n "$result" ]; then
        echo -e "  ${GREEN}Result: $result${NC}"
    else
        echo -e "  ${RED}Could not calculate. Try: 5+3, 10*7, 100/4${NC}"
    fi
    echo ""
}
```

**Option B — Weather Check:**
```bash
get_weather() {
    echo ""
    echo -e "${CYAN}=== WEATHER CHECK ===${NC}"
    echo -n "  Which city? "
    read city
    echo ""
    curl -s "wttr.in/${city}?format=3" 2>/dev/null || echo "  Could not reach weather service."
    echo ""
}
```

**Option C — Countdown Timer:**
```bash
do_timer() {
    echo ""
    echo -e "${CYAN}=== COUNTDOWN TIMER ===${NC}"
    echo -n "  How many seconds? "
    read seconds

    if ! [[ "$seconds" =~ ^[0-9]+$ ]]; then
        echo "  Please enter a number."
        return
    fi

    echo "  Timer started for ${seconds} seconds..."
    local remaining=$seconds
    while [ "$remaining" -gt 0 ]; do
        echo -ne "  ${YELLOW}$remaining...${NC}\r"
        sleep 1
        remaining=$((remaining - 1))
    done
    echo ""
    echo -e "  ${GREEN}TIME'S UP!${NC}"
    say -v "$MY_VOICE" "Time is up!" &
    echo ""
}
```

**Option D — Random Word from Dictionary:**
```bash
random_word() {
    echo ""
    echo -e "${CYAN}=== WORD OF THE MOMENT ===${NC}"
    echo ""
    if [ -f /usr/share/dict/words ]; then
        local word=$(grep "^[a-z]" /usr/share/dict/words | shuf -n 1)
        echo -e "  Your word: ${YELLOW}$word${NC}"
        say -v "$MY_VOICE" "Your word is: $word" &
    else
        echo "  Dictionary not found on this system."
    fi
    echo ""
}
```

Add your chosen feature as menu option 11 in `mybot.sh`.

---

## Testing Your Complete Application

Go through every feature methodically:

```bash
mybot

# Test each option:
# 1 — Morning briefing: shows date, greeting, fact, reads aloud
# 2 — Diary: write an entry, read it back, search for a word
# 3 — Internet check: shows connected, ping time, public IP
# 4 — File tools: count files, search by name
# 5 — Opens Finder to your home folder
# 6 — Shows current time
# 7 — Random fact
# 8 — Case file browser: lists and opens case files
# 9 — Clue searcher: finds text in playground files
# 10 — Code assembler: shows all 12 pieces and complete phrase
# 11 — Your custom feature
# q — Goodbye message and exit
```

If something doesn't work, the error message almost always tells you what's wrong. Read it carefully before trying to fix it.

---

## The Final Code Piece and the Treasure

```bash
cat playground/mission_12/secret_code_piece.txt
```

Now assemble all twelve:

```bash
# Option 1 — Use the Secret Code Assembler inside MyBot (menu option 10)
mybot

# Option 2 — Read them manually and write out the phrase
cat playground/mission_12/all_clues.txt
```

Once you have the complete phrase, read it aloud. The Terminal Detective Agency has been building toward this message since Mission 1.

And now — the Final Treasure:

```bash
cat playground/mission_12/FINAL_TREASURE.txt
```

---

## 🏆 BONUS MISSIONS

### Bonus Mission 1 — Help System

Add a `?` or `h` option to MyBot's main menu that explains each feature:

```bash
show_help() {
    echo ""
    echo -e "${CYAN}=== MYBOT HELP ===${NC}"
    echo ""
    echo "  Menu options:"
    echo "  1. Morning Briefing  — date, greeting, and a fun fact read aloud"
    echo "  2. Diary             — write, read, and search diary entries"
    echo "  3. Internet Check    — test connection, ping, and public IP"
    echo "  4. File Tools        — explore files, find large files, search by name"
    echo "  5. Open in Finder    — opens your home folder graphically"
    echo "  6. Time              — current date and time"
    echo "  7. Surprise          — random interesting fact"
    echo "  8. Case Files        — browse your mission case summaries"
    echo "  9. Clue Searcher     — search through playground files"
    echo " 10. Code Assembler    — collect and display all 12 code pieces"
    echo " 11. [Your Feature]    — [describe your custom addition]"
    echo "  q. Quit              — exit MyBot"
    echo ""
}
```

### Bonus Mission 2 — Save Case Notes

Add a feature for taking timestamped case notes separate from your diary:

```bash
take_notes() {
    local notes_file="$HOME/case_notes.txt"
    echo ""
    echo -e "${CYAN}=== CASE NOTES ===${NC}"
    echo ""
    echo "  Type your note (Enter twice to save):"

    local note=""
    while IFS= read -r line; do
        [ -z "$line" ] && break
        note+="$line"$'\n'
    done

    if [ -n "$note" ]; then
        {
            echo "--- $(date +'%A, %B %d at %I:%M %p') ---"
            echo "$note"
            echo ""
        } >> "$notes_file"
        echo -e "  ${GREEN}Note saved to $notes_file${NC}"
    else
        echo "  No note saved — it was empty."
    fi
}
```

### Bonus Mission 3 — Startup Statistics

Make the banner show interesting stats when MyBot opens:

```bash
show_banner() {
    clear
    local file_count=$(find ~ -type f 2>/dev/null | wc -l | tr -d ' ')
    local diary_count=0
    [ -f "$DIARY_FILE" ] && diary_count=$(grep -c "^===" "$DIARY_FILE")

    echo ""
    echo -e "${BOLD}${CYAN}"
    echo "  ╔═══════════════════════════════════════╗"
    echo "  ║                                       ║"
    printf "  ║  %-37s║\n" "MyBot — Agent $MY_NAME"
    echo "  ║                                       ║"
    printf "  ║  Files on system: %-20s║\n" "$file_count"
    printf "  ║  Diary entries:   %-20s║\n" "$diary_count"
    printf "  ║  Today:           %-20s║\n" "$(date +'%b %d, %Y')"
    echo "  ║                                       ║"
    echo "  ╚═══════════════════════════════════════╝"
    echo -e "${NC}"
}
```

### Bonus Mission 4 — Multi-Account Greetings

Make config.sh load different settings based on who's logged in:

```bash
# Add to the bottom of config.sh:
CURRENT_USER=$(whoami)

case "$CURRENT_USER" in
    sophia)
        MY_NAME="Agent Sophia"
        MY_VOICE="Samantha"
        ;;
    mom|dad)
        MY_NAME="Director"
        MY_VOICE="Alex"
        ;;
    *)
        MY_NAME="$CURRENT_USER"
        MY_VOICE="Fred"
        ;;
esac
```

---

## 🔐 CODE PIECE UNLOCKED!

**Code Piece #12: ON**

```bash
cat playground/mission_12/secret_code_piece.txt
```

Twelve pieces. The final message:

```bash
# Run the Code Assembler in MyBot (option 10), or read them all manually:
cat playground/mission_12/all_clues.txt
```

And the treasure that's been waiting:

```bash
cat playground/mission_12/FINAL_TREASURE.txt
```

---

## ⚡ POWERS UNLOCKED — THE COMPLETE INVENTORY

This is every skill you have earned. The full list, across all twelve missions.

### Mission-by-Mission

| Mission | You Learned To... |
|---------|------------------|
| **1** | Open Terminal, run basic commands, make your Mac speak with `say`, check date/time, use `man` |
| **2** | Navigate the entire filesystem, understand absolute vs relative paths, use `cd`, `ls`, `pwd` |
| **3** | Create, copy, move, and delete files and folders; understand the filesystem structure |
| **4** | Read and write files, build a diary, use redirects `>` and `>>`, use `nano`, `cat`, `head`, `tail`, `wc` |
| **5** | Find any file anywhere with `find`, search file contents with `grep`, understand hidden files |
| **6** | Chain commands with pipes `|`, transform text with `sort`, `uniq`, `cut`, `tr`, `awk`, `sed` |
| **7** | Write real shell scripts with shebangs, variables, `read` input, `if/else` logic, make scripts executable with `chmod +x` |
| **8** | Automate repetitive work with `for` and `while` loops, `case` statements, `sleep`, `break`, `continue` |
| **9** | Talk to the internet from Terminal with `curl` and `ping`, parse JSON, call APIs, download files |
| **10** | Customize your entire terminal environment: aliases, functions, prompts, colors, `.zshrc`, `PATH`, `export` |
| **11** | Control file access with `chmod` (octal and symbolic), decode base64, encrypt/decrypt with AES-256 |
| **12** | Build a complete multi-feature CLI application with modular architecture, config files, and a menu loop |

### The Complete Command Dictionary

Every command you now know:

`alias` · `awk` · `base64` · `break` · `cal` · `case` · `cat` · `cd` · `chmod` · `clear` · `continue` · `cp` · `curl` · `cut` · `date` · `echo` · `export` · `find` · `for` · `grep` · `head` · `if` · `less` · `ls` · `man` · `mkdir` · `mv` · `nano` · `nl` · `open` · `openssl` · `ping` · `printf` · `pwd` · `read` · `rm` · `say` · `sed` · `sleep` · `sort` · `source` · `tail` · `touch` · `tr` · `uniq` · `until` · `wc` · `while` · `whoami`

Over forty-five commands. Each one a precision tool in your detective kit.

### The Core Concepts You Own

- **Filesystem navigation** — absolute paths, relative paths, the home directory, hidden files
- **Standard I/O** — stdin, stdout, stderr, redirection (`>`, `>>`), pipes (`|`)
- **Shell scripting** — variables, conditionals, loops, functions, positional parameters
- **Text processing** — grep patterns, sort/uniq pipelines, awk field extraction, sed substitution
- **Networking** — HTTP requests with curl, ping and latency, IP addresses, APIs and JSON
- **Security** — file permissions (rwx, octal mode, symbolic mode), encryption vs encoding, AES-256
- **Configuration** — `.zshrc`, aliases, PATH, environment variables, export, source
- **Application design** — modular architecture, single source of truth, menu-driven interfaces, defensive coding

---

## 🌟 What Comes Next

You have finished Terminal Quest. But this is the beginning of a much longer adventure, not the end of anything.

### Learn a Programming Language

The shell is powerful, but other languages open different doors:

- **Python** — reads almost like English, has libraries for everything, is the most popular language for data science, automation, and AI
- **Swift** — Apple's language for building Mac, iPhone, and iPad apps; if you want to put something in the App Store, this is the path
- **JavaScript** — runs in every browser in the world; the language of the web
- **Ruby** — elegant and expressive; wonderful for building tools and web services

### Go Deeper Into the Command Line

- **Git** — the version control system used by every programmer on Earth. It's a time machine for your code: every version saved, every change recorded, easy to collaborate with others
- **vim** — the most powerful text editor ever made. The learning curve is steep (some people quit on day one). The payoff is that you can edit files with incredible speed, entirely from the keyboard
- **awk and sed** — you touched these in Mission 6. Going deeper turns you into a text-processing expert. Analyzing logs, transforming data, extracting patterns — all effortlessly
- **Regular expressions (regex)** — a language for describing patterns in text. Used by grep, sed, awk, and almost every programming language. Learning regex makes searching and transforming text feel like a superpower

### Build Real Projects

Ideas matched to what you now know:
- A personal website (HTML, CSS, JavaScript — and a shell script to deploy it)
- An automation script that organizes files on your Mac automatically
- A custom CLI tool that solves one specific problem in your life
- A Python program that uses everything you learned here, but with more complex logic
- A Mac app with a graphical interface (Swift + Xcode)

### Read These

- *The Linux Command Line* by William Shotts — the best deep-dive into shell and tools, and it's free online at linuxcommand.org
- *Learning Python* by Mark Lutz — comprehensive introduction to Python
- *The Unix Programming Environment* by Kernighan & Pike — written by the inventors of Unix; still one of the best books on how computers work

The command line isn't a relic from the past. It's one of the most enduring, powerful interfaces ever designed. The people who know it well have a capability that most users — and many professional programmers — simply don't have.

You have it now. It belongs to you.

---

## 📬 A Note from Director Chen

Agent,

You graduated today.

When you started Mission 1, you were looking at a blinking cursor and wondering what it was for. Now you know it's one of the most powerful interfaces ever created — a direct line to your computer's full capability, bypassing the friendly buttons and menus that were built for people who never wanted to go deeper.

You went deeper.

You learned that files aren't icons — they're objects in a hierarchical tree you can navigate like a map you've memorized. You learned that text isn't just words — it's data you can sort, filter, pipe, transform, count, search, and analyze in seconds. You learned that automation isn't magic — it's just instructions, written once, executed whenever you need them.

You built real tools. An internet checker. A morning briefing script. An encrypted message system. A full CLI application. These aren't exercises. They're programs.

The hardest part of this whole journey wasn't learning commands or syntax. It was deciding to try. Keeping going when the terminal said "command not found" and you didn't know why. Reading the error message instead of closing the window.

That's the detective mindset. That's what makes someone genuinely good at this.

The agency is proud to have you.

*— Director Chen*
*Terminal Detective Agency*

---

## 💌 A Special Note — From the Creator

*The following was written by the person who made this book. It belongs at the end.*

---

This book was made for my daughter.

Not because she asked for it. But because I wanted her to have a way into the thing I love about computers — not the apps, not the websites, not the interfaces built for casual use, but the actual machinery underneath. The part where you talk directly to the computer and it does exactly what you say.

I wanted it to feel like an adventure, not a lesson. So there's a mystery. And a secret agency. And code pieces scattered through twelve missions. Because if the journey is fun, you don't notice how far you've traveled.

If you're reading this, you traveled far.

You made it through twelve missions. You collected twelve code pieces. You built real tools and learned real skills. The command line was a foreign place when you started — an empty black rectangle with a blinking cursor that seemed to ask "what do you want from me?" Now it's home. You know how to answer that question.

I am proud of you. Not because you finished the book.

Because you opened Terminal in the first place. That takes courage. Most people — most *adults* — see that cursor and close the window and go back to something familiar. They never find out what's on the other side.

You found out.

Go build something. Automate something annoying. Create a tool that nobody else has but you needed. Write a script that makes your day a little better every day. Show someone else what a pipe does, and watch their face when they realize the shell can chain commands together like puzzle pieces.

The command line is yours now.

I can't wait to see what you do with it.

*— Dad (Yosia)*

*P.S. I love you. You've always been braver than you think.*

---

*THE END*

*— Terminal Detective Agency, Case Files 1–12 —*
*All twelve cases solved. All twelve code pieces collected.*
*Mission complete.*
