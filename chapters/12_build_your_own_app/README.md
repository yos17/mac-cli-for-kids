# Mission 12 — Build Your Own App

## Mission Briefing

This is it. The final mission.

You've learned 40+ commands, pipes, loops, logic, networking, customization, encryption, and scripting. You know how the file system works, how the internet works, how permissions work. You've built a diary, a file organizer, a talking Mac greeter, an internet checker, and an encrypted message vault.

Now you put it all together.

In this mission, you build **MyBot** — your personal command-line assistant. It has a menu, remembers your name, tells jokes, manages your diary, checks your internet, gives you a weather report, organizes your files, and says goodnight when you're done.

This isn't an exercise. This is your program. By the time you finish, you'll have something you'll actually use.

### What You'll Use
- Everything from Missions 1–11
- Shell functions and menus
- `read` for user input
- `case` for menu options
- Loops to keep the program running
- Color output and a nice UI

---

## Planning MyBot

Before writing code, real programmers plan what their program will do. MyBot needs:

1. A welcome screen with your name and the date
2. A menu with numbered options
3. Each option does something useful
4. The program loops — after each action, goes back to the menu
5. A quit option that says goodbye

Here's the plan:

```
=== MyBot — Personal Assistant ===
Welcome, Sophia! Today is Sunday, April 13.

What would you like to do?
  1. 📖 Read my diary
  2. ✏️  Add a diary entry
  3. 🌤  Check the weather
  4. 🌐 Check the internet
  5. 📂 Organize my Downloads
  6. 😄 Tell me a joke
  7. 🔍 Find a file
  8. ℹ️  System info
  9. 👋 Goodbye

Enter choice (1-9): _
```

Let's build it piece by piece.

---

## Building the Pieces

Before writing the full bot, let's test the key pieces.

### The Menu Loop

The heart of any menu-driven program:

```bash
while true; do
    echo "1. Option A"
    echo "2. Option B"
    echo "3. Quit"
    echo ""
    read -p "Enter choice: " choice

    case $choice in
        1) echo "You chose A" ;;
        2) echo "You chose B" ;;
        3) echo "Bye!"; break ;;
        *) echo "Invalid choice. Try again." ;;
    esac

    echo ""
done
```

`while true` loops forever. `break` exits it. The `case` statement handles each option cleanly.

### Reading User Input

```bash
read -p "What is your name? " name
echo "Hello, $name!"
```

`read -p "prompt" variable` prints the prompt and waits for the user to type something.

### Color Output

You can add color to make the UI look great:

```bash
# Define colors as variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'   # Reset to default

# Use them:
echo -e "${CYAN}Hello, ${BOLD}Sophia${RESET}${CYAN}!${RESET}"
echo -e "${GREEN}✓ Success${RESET}"
echo -e "${RED}✗ Error${RESET}"
```

`-e` in `echo` enables escape sequences like `\033[...`.

### A Nice Header

```bash
clear_header() {
    clear
    echo -e "${BOLD}${CYAN}================================${RESET}"
    echo -e "${BOLD}${CYAN}   MyBot — Personal Assistant   ${RESET}"
    echo -e "${BOLD}${CYAN}================================${RESET}"
    echo -e "Welcome, ${YELLOW}$BOT_NAME${RESET}! Today is ${GREEN}$(date +"%A, %B %d")${RESET}."
    echo ""
}
```

---

## The Complete MyBot Script

Here it is. This is a real, working program. Save it to `~/mybot.sh`.

```bash
nano ~/mybot.sh
```

Paste in this entire script:

```bash
#!/bin/bash
# ============================================================
# MyBot — Your Personal Terminal Assistant
# Written by: [Your Name Here]
# Built during: Mac CLI for Kids, Mission 12
# ============================================================

# --- Colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
BOLD='\033[1m'
RESET='\033[0m'

# --- Config ---
BOT_NAME="Sophia"          # Change this to your name!
DIARY="$HOME/diary/journal.txt"
BOT_VERSION="1.0"

# =====================
# HELPER FUNCTIONS
# =====================

clear_header() {
    clear
    echo -e "${BOLD}${CYAN}╔══════════════════════════════════════╗${RESET}"
    echo -e "${BOLD}${CYAN}║     MyBot — Personal Assistant       ║${RESET}"
    echo -e "${BOLD}${CYAN}╚══════════════════════════════════════╝${RESET}"
    echo -e "  Welcome, ${YELLOW}${BOLD}$BOT_NAME${RESET}! Today is ${GREEN}$(date +"%A, %B %d, %Y")${RESET}."
    echo ""
}

press_enter() {
    echo ""
    read -p "Press Enter to return to menu..."
}

# =====================
# MENU FUNCTIONS
# =====================

read_diary() {
    clear_header
    echo -e "${BOLD}📖 Your Diary${RESET}"
    echo ""
    if [ -f "$DIARY" ]; then
        cat "$DIARY"
    else
        echo -e "${YELLOW}No diary found.${RESET}"
        echo "Run 'Add a diary entry' to start your diary!"
        echo "(Diary will be created at: $DIARY)"
    fi
    press_enter
}

write_diary() {
    clear_header
    echo -e "${BOLD}✏️  Add a Diary Entry${RESET}"
    echo ""

    # Make sure the diary folder exists
    mkdir -p "$(dirname $DIARY)"

    echo -e "${CYAN}What happened today? (Press Enter twice when done)${RESET}"
    echo ""

    # Read multi-line input
    entry=""
    while IFS= read -r line; do
        [ -z "$line" ] && break
        entry="$entry$line\n"
    done

    if [ -n "$entry" ]; then
        echo "" >> "$DIARY"
        echo "=== $(date +"%A, %B %d, %Y") ===" >> "$DIARY"
        echo "" >> "$DIARY"
        printf "%b" "$entry" >> "$DIARY"
        echo "---" >> "$DIARY"

        echo -e "${GREEN}✓ Entry saved to your diary!${RESET}"
        say "Diary entry saved."
    else
        echo -e "${YELLOW}Nothing written.${RESET}"
    fi
    press_enter
}

check_weather() {
    clear_header
    echo -e "${BOLD}🌤  Weather Report${RESET}"
    echo ""
    echo -e "Fetching weather... ${CYAN}(requires internet)${RESET}"
    echo ""
    curl -s --max-time 10 "wttr.in/?format=3" 2>/dev/null || \
        echo -e "${RED}Could not get weather. Check your internet connection.${RESET}"
    echo ""
    press_enter
}

check_internet() {
    clear_header
    echo -e "${BOLD}🌐 Internet Status${RESET}"
    echo ""

    echo -n "Checking connection... "
    if ping -c 1 -W 2 8.8.8.8 > /dev/null 2>&1; then
        echo -e "${GREEN}✓ CONNECTED${RESET}"
        internet_ok=true
    else
        echo -e "${RED}✗ NO CONNECTION${RESET}"
        internet_ok=false
    fi

    echo -n "DNS check... "
    if ping -c 1 -W 2 google.com > /dev/null 2>&1; then
        echo -e "${GREEN}✓ WORKING${RESET}"
    else
        echo -e "${RED}✗ NOT WORKING${RESET}"
    fi

    # Local IP
    local_ip=$(ifconfig | grep "inet " | grep -v "127.0.0.1" | head -1 | awk '{print $2}')
    echo -e "Local IP:  ${CYAN}${local_ip:-not found}${RESET}"

    # Public IP
    if $internet_ok; then
        public_ip=$(curl -s --max-time 5 https://api.ipify.org 2>/dev/null)
        echo -e "Public IP: ${CYAN}${public_ip:-could not retrieve}${RESET}"
    fi

    press_enter
}

organize_downloads() {
    clear_header
    echo -e "${BOLD}📂 Organize Downloads${RESET}"
    echo ""

    DOWNLOADS="$HOME/Downloads"
    count=$(ls "$DOWNLOADS" | wc -l | tr -d ' ')
    echo -e "Your Downloads folder has ${YELLOW}$count items${RESET}."
    echo ""
    read -p "Organize them into subfolders? (y/n): " confirm

    if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
        echo "Cancelled."
        press_enter
        return
    fi

    mkdir -p "$DOWNLOADS/Photos" "$DOWNLOADS/Videos" \
             "$DOWNLOADS/Documents" "$DOWNLOADS/Music" "$DOWNLOADS/Other"

    moved=0
    for file in "$DOWNLOADS"/*; do
        [ -d "$file" ] && continue
        filename=$(basename "$file")
        ext=$(echo "${filename##*.}" | tr '[:upper:]' '[:lower:]')

        case "$ext" in
            jpg|jpeg|png|gif|heic|webp|bmp)
                dest="$DOWNLOADS/Photos" ;;
            mp4|mov|avi|mkv|m4v|wmv)
                dest="$DOWNLOADS/Videos" ;;
            mp3|m4a|flac|wav|aac)
                dest="$DOWNLOADS/Music" ;;
            txt|doc|docx|pdf|pages|md|rtf|csv)
                dest="$DOWNLOADS/Documents" ;;
            *)
                dest="$DOWNLOADS/Other" ;;
        esac

        mv "$file" "$dest/" 2>/dev/null
        moved=$((moved + 1))
    done

    echo ""
    echo -e "${GREEN}✓ Moved $moved files.${RESET}"
    echo ""
    echo "Photos:    $(ls "$DOWNLOADS/Photos/" 2>/dev/null | wc -l | tr -d ' ') files"
    echo "Videos:    $(ls "$DOWNLOADS/Videos/" 2>/dev/null | wc -l | tr -d ' ') files"
    echo "Music:     $(ls "$DOWNLOADS/Music/" 2>/dev/null | wc -l | tr -d ' ') files"
    echo "Documents: $(ls "$DOWNLOADS/Documents/" 2>/dev/null | wc -l | tr -d ' ') files"
    echo "Other:     $(ls "$DOWNLOADS/Other/" 2>/dev/null | wc -l | tr -d ' ') files"

    press_enter
}

tell_joke() {
    clear_header
    echo -e "${BOLD}😄 Random Joke${RESET}"
    echo ""

    # A few built-in jokes (kid-friendly!)
    jokes=(
        "Why don't scientists trust atoms?\nBecause they make up everything!"
        "What do you call a sleeping dinosaur?\nA dino-snore!"
        "Why did the programmer quit?\nBecause they didn't get arrays!"
        "What do you call a fish with no eyes?\nA fsh!"
        "Why did the computer go to the doctor?\nBecause it had a virus!"
        "What's a computer's favorite snack?\nMicrochips!"
        "Why did the terminal user cross the road?\nTo get to the other side of the firewall!"
        "How many programmers does it take to change a light bulb?\nNone — that's a hardware problem!"
    )

    # Pick a random joke
    joke_index=$((RANDOM % ${#jokes[@]}))
    IFS=$'\n' read -rd '' setup reply <<< "$(echo -e "${jokes[$joke_index]}")"

    echo -e "${CYAN}$setup${RESET}"
    echo ""
    sleep 1.5
    echo -e "${YELLOW}$reply${RESET}"
    echo ""
    say "${jokes[$joke_index]//\\n/ ... }"

    press_enter
}

find_file() {
    clear_header
    echo -e "${BOLD}🔍 File Finder${RESET}"
    echo ""
    read -p "What are you looking for? (filename or word): " search_term

    if [ -z "$search_term" ]; then
        echo "Nothing entered."
        press_enter
        return
    fi

    echo ""
    echo -e "Searching for '${CYAN}$search_term${RESET}'..."
    echo ""

    echo "--- Files with matching names ---"
    find ~ -iname "*${search_term}*" 2>/dev/null | head -10

    echo ""
    echo "--- Spotlight search (file contents too) ---"
    mdfind "$search_term" 2>/dev/null | head -10

    press_enter
}

system_info() {
    clear_header
    echo -e "${BOLD}ℹ️  System Info${RESET}"
    echo ""

    echo -e "${CYAN}Computer:${RESET}   $(scutil --get ComputerName 2>/dev/null || hostname)"
    echo -e "${CYAN}User:${RESET}       $(whoami)"
    echo -e "${CYAN}Date/Time:${RESET}  $(date +"%A, %B %d, %Y — %I:%M %p")"
    echo ""

    echo -e "${CYAN}Home folder:${RESET} $(du -sh ~ 2>/dev/null | cut -f1) used"
    echo -e "${CYAN}Downloads:${RESET}  $(ls ~/Downloads | wc -l | tr -d ' ') items"

    if [ -f "$DIARY" ]; then
        entries=$(grep -c "^===" "$DIARY" 2>/dev/null)
        echo -e "${CYAN}Diary:${RESET}      $entries entries"
    else
        echo -e "${CYAN}Diary:${RESET}      no diary yet"
    fi

    echo ""
    echo -e "${CYAN}Uptime:${RESET}"
    uptime

    press_enter
}

goodbye() {
    clear_header
    echo -e "${BOLD}${YELLOW}Goodbye, $BOT_NAME!${RESET}"
    echo ""
    echo -e "Thanks for using MyBot ${BOT_VERSION}."
    echo -e "Remember: ${CYAN}the Terminal is your superpower.${RESET}"
    echo ""
    say "Goodbye $BOT_NAME! See you next time."
    echo ""
    exit 0
}

# =====================
# FIRST RUN SETUP
# =====================

# Check if we have a saved name
if [ -f "$HOME/.mybot_config" ]; then
    source "$HOME/.mybot_config"
fi

# If no name saved, ask for it
if [ -z "$BOT_NAME" ] || [ "$BOT_NAME" = "Sophia" ]; then
    clear
    echo -e "${BOLD}${CYAN}Welcome to MyBot!${RESET}"
    echo ""
    read -p "What's your name? " input_name
    if [ -n "$input_name" ]; then
        BOT_NAME="$input_name"
        echo "BOT_NAME=\"$BOT_NAME\"" > "$HOME/.mybot_config"
    fi
fi

# Welcome message on first launch
say "Welcome, $BOT_NAME! MyBot is ready."

# =====================
# MAIN MENU LOOP
# =====================

while true; do
    clear_header
    echo -e "${BOLD}What would you like to do?${RESET}"
    echo ""
    echo -e "  ${CYAN}1.${RESET} 📖  Read my diary"
    echo -e "  ${CYAN}2.${RESET} ✏️   Add a diary entry"
    echo -e "  ${CYAN}3.${RESET} 🌤   Check the weather"
    echo -e "  ${CYAN}4.${RESET} 🌐  Check the internet"
    echo -e "  ${CYAN}5.${RESET} 📂  Organize my Downloads"
    echo -e "  ${CYAN}6.${RESET} 😄  Tell me a joke"
    echo -e "  ${CYAN}7.${RESET} 🔍  Find a file"
    echo -e "  ${CYAN}8.${RESET} ℹ️   System info"
    echo -e "  ${CYAN}9.${RESET} 👋  Goodbye"
    echo ""
    read -p "$(echo -e "${BOLD}Enter choice (1-9):${RESET} ")" choice
    echo ""

    case $choice in
        1) read_diary ;;
        2) write_diary ;;
        3) check_weather ;;
        4) check_internet ;;
        5) organize_downloads ;;
        6) tell_joke ;;
        7) find_file ;;
        8) system_info ;;
        9) goodbye ;;
        *) echo -e "${RED}Invalid choice. Please enter 1-9.${RESET}"; sleep 1 ;;
    esac
done
```

Make it executable and run it:

```bash
chmod +x ~/mybot.sh
bash ~/mybot.sh
```

---

## Extending MyBot

Once your basic bot is working, here are ways to make it even better:

### Add a Quote of the Day

Add this function and a menu option:

```bash
quote_of_day() {
    quotes=(
        "The best way to predict the future is to create it."
        "Code is like humor. When you have to explain it, it's bad."
        "First, solve the problem. Then, write the code."
        "Learning to write programs stretches your mind."
        "The computer was born to solve problems that did not exist before."
    )
    idx=$((RANDOM % ${#quotes[@]}))
    echo -e "${YELLOW}\"${quotes[$idx]}\"${RESET}"
    say "${quotes[$idx]}"
}
```

### Add a Timer

```bash
timer_function() {
    read -p "How many minutes? " mins
    seconds=$((mins * 60))
    echo "Timer set for $mins minutes."
    say "Timer started for $mins minutes."
    sleep "$seconds"
    echo -e "${GREEN}⏰ Time's up!${RESET}"
    say "Time is up!"
}
```

### Add a Habit Tracker

```bash
HABITS_FILE="$HOME/.mybot_habits"

log_habit() {
    read -p "Which habit did you do today? " habit
    echo "$(date +"%Y-%m-%d"): $habit" >> "$HABITS_FILE"
    echo -e "${GREEN}✓ Logged: $habit${RESET}"
}

show_habits() {
    echo -e "${BOLD}Your recent habits:${RESET}"
    tail -10 "$HABITS_FILE" 2>/dev/null || echo "(no habits logged yet)"
}
```

---

## Try It! — Quick Experiments

**Experiment 1:** Run MyBot and test every menu option. Does everything work?

**Experiment 2:** Change the `BOT_NAME` in the script to your real name. Or delete `~/.mybot_config` and let it ask you again:

```bash
rm ~/.mybot_config
bash ~/mybot.sh
```

**Experiment 3:** Add a 10th menu option. Pick one of the extensions above (Quote of the Day, Timer, or Habit Tracker) and add it to the menu.

**Experiment 4:** Make MyBot accessible as a command. Copy it to `~/bin/`:

```bash
mkdir -p ~/bin
cp ~/mybot.sh ~/bin/mybot
chmod +x ~/bin/mybot
```

Then make sure `~/bin` is in your PATH (add this to `.zshrc` if it isn't):

```bash
export PATH="$HOME/bin:$PATH"
```

Source `.zshrc` and then just type `mybot` from anywhere!

---

## Challenges

### Challenge 1 — Personalize It

Add at least two new features to MyBot that aren't already in the script. They can be anything — a calculator, a word counter for your diary, a list of your favorite commands, a random compliment generator, whatever you want.

### Challenge 2 — Add Color Themes

Add a "Change theme" menu option that lets you pick a color scheme for the bot's UI:
- Option 1: Cyan/Yellow (default)
- Option 2: Green hacker
- Option 3: Purple/Pink

**Hint:** Change the color variables and re-draw the header.

### Challenge 3 — The Daily Report

Add a menu option called "Daily Report" that automatically:
1. Shows today's date and time
2. Counts your diary entries
3. Shows your IP address
4. Lists the top 3 file types in Downloads
5. Gives you a compliment

All in one screen, no user input needed.

### Challenge 4 — Make It Your Own

This is the open-ended challenge. Look at your MyBot. What would make it genuinely useful for *your* life? Add it.

Think about:
- Things you check every day
- Tasks you do over and over
- Information you want fast
- Things that would be fun to have

Build it. This is your program. Make it yours.

---

## Solutions

Solutions are in the [solutions folder](solutions/README.md).

---

## Powers Unlocked

| Concept | How To Use It |
|---------|--------------|
| Main menu loop | `while true; do ... case $choice in ... esac; done` |
| Menu option | `N) function_name ;;` in the case statement |
| User input | `read -p "prompt" variable` |
| Color text | `echo -e "${COLOR}text${RESET}"` |
| Bold text | `echo -e "${BOLD}text${RESET}"` |
| Random item | `arr[RANDOM % ${#arr[@]}]` |
| Config file | `source ~/.mybot_config` to load saved settings |
| Clear screen | `clear` |
| Sleep | `sleep N` pauses for N seconds |
| Exit program | `exit 0` |

### The Complete Command Reference

You've learned over 50 commands across 12 missions. Here's the master list:

| Mission | Commands Learned |
|---------|-----------------|
| 1 | `whoami`, `date`, `echo`, `say`, `clear` |
| 2 | `pwd`, `ls`, `cd` |
| 3 | `mkdir`, `touch`, `cp`, `mv`, `rm` |
| 4 | `cat`, `less`, `head`, `tail`, `>`, `>>` |
| 5 | `find`, `grep`, `mdfind` |
| 6 | `\|`, `sort`, `uniq`, `wc`, `cut` |
| 7 | `bash`, variables, `read`, `$()` |
| 8 | `for`, `while`, `if/else`, `case`, `test` |
| 9 | `ping`, `curl`, `open`, `caffeinate` |
| 10 | `alias`, `.zshrc`, `PROMPT`, functions |
| 11 | `chmod`, `openssl`, `base64`, `tar` |
| 12 | Putting it all together |

---

## You Did It

Twelve missions. Forty-plus commands. Six real programs. One custom Terminal setup. And now, your own personal assistant.

When you opened Mission 1, you saw a blinking cursor and a black screen. You didn't know what it was. Now you do — and more than that, you know how to use it, customize it, and build things with it.

Most adults have never done what you just did.

The Terminal is yours now. What will you build next?

---

*"The most powerful tool you'll ever use fits in a window on your screen. You've learned to use it. Now go do something amazing."*

*— End of Mac CLI for Kids —*
