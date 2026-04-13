# CASE FILE #10 — "Your Secret Lair"
**Terminal Detective Agency | Clearance Level: OPERATIVE**

---

## 🔍 MISSION BRIEFING

**INCOMING TRANSMISSION — DIRECTOR CHEN**

Agent,

Every great detective needs a customized command center. Your workspace should reflect who you are — not some generic, factory-default setup that looks exactly like every other rookie's terminal.

Right now, your terminal looks just like every other agent's terminal. Same default colors. Same default prompt. Same anonymous cursor blinking in the dark. Anyone could be sitting at that terminal. There is nothing about it that says *this belongs to someone*.

By the end of this mission, that changes permanently.

Your terminal will have YOUR agency's color scheme. YOUR personal command shortcuts. YOUR prompt announcing your presence the moment Terminal opens. When you open a new window, it will greet you by name and snap to attention. Other agents will look at your setup and know: this is a professional's lair.

Think of `.zshrc` as the blueprint for your secret command center. Every gadget you want powered on, every shortcut you want loaded, every color you want displayed — you write it down once in `.zshrc`, and from that point forward, it all happens automatically the moment Terminal starts. Your lair is always ready for you.

This mission is also the most personal one in this whole book. There are no wrong answers here — only choices about what *you* want your workspace to feel and look like.

**Your mission objectives:**
1. Study the sample configuration and theme files in your case folder
2. Understand exactly how `.zshrc` controls your entire terminal environment
3. Build detective aliases that save you dozens of keystrokes every day
4. Create a custom PROMPT that announces your presence
5. Write a `briefing()` function that shows your status when you start work
6. Choose and apply one of the agency-approved color themes
7. Understand PATH, export, and the difference between the various dot-files

**Access your case files:**
```bash
cd playground/mission_10
```

**Read your mission briefing first:**
```bash
cat playground/mission_10/case_briefing.txt
```

---

## 📚 DETECTIVE TRAINING: Terminal Configuration

### The `.zshrc` File — Your Command Center Blueprint

Every time you open a new Terminal window, your shell (zsh — the Z shell, which all modern Macs use) goes through a startup sequence. Part of that startup is reading a file called `.zshrc` in your home folder. That file is your configuration — your settings, your shortcuts, your environment. Everything in it gets executed automatically, every single time Terminal opens.

Think of `.zshrc` like the boot sequence for your secret lair. You design it once. You set it up the way you want. And from that day on, every time you walk in, the lights come on, the monitors flicker to life, your tools are laid out exactly where you want them, and your name is up on the screen.

Open your `.zshrc` right now:

```bash
nano ~/.zshrc
```

It might have a few lines already (some Macs ship with basic PATH settings in there), or it might be nearly empty. Whatever is there, don't delete it — just scroll to the bottom. Everything you're about to add goes at the end.

Close it for now with `Ctrl+X`. You'll build it up step by step.

A few things to notice about `.zshrc`:
- The `.` at the start of the filename makes it a hidden file. That's why you normally can't see it in Finder or with a plain `ls` — you need `ls -a ~` to see it.
- The `~` means your home folder. So `~/.zshrc` is always the `.zshrc` in *your* home folder, no matter where you are in the filesystem.
- **Every line in `.zshrc` is a shell command.** When Terminal starts and reads this file, it's literally running every line as if you typed it yourself. If you add `alias ll="ls -la"`, that's like typing that alias command every single time you open Terminal.

### Studying the Sample Configuration

Before you start building your own setup, study the materials the agency has prepared. This is what good programmers do — they study existing code before writing new code.

```bash
# Read your mission briefing
cat playground/mission_10/case_briefing.txt

# Study the sample zshrc — this is a complete example of a professional setup
cat playground/mission_10/sample_zshrc

# Read the full list of recommended detective aliases
cat playground/mission_10/aliases.txt
```

The `sample_zshrc` shows you how all the pieces fit together — aliases, a custom prompt, color variables, and a `briefing()` function all working as one coherent system. The `aliases.txt` file organizes recommended shortcuts into four categories:

- **Navigation aliases** — move around the filesystem faster
- **Safety aliases** — protect yourself from accidental deletions and overwrites
- **Fun aliases** — small quality-of-life improvements
- **Detective specials** — agency-approved power moves for advanced work

You're going to pick the best ones and add them to your own `.zshrc`.

### Aliases — Building Your Personal Command Vocabulary

An **alias** is a custom shortcut command. You define a new word, and whenever you type that word, the shell expands it into whatever full command you defined.

Here's a classic example. The command `ls -la` shows a detailed file listing, including hidden files, file sizes, permissions, and timestamps. It's incredibly useful — but `ls -la` is six characters. What if it were just two?

```bash
alias ll="ls -la"
```

Now whenever you type `ll`, the shell automatically runs `ls -la`. You just made your own command. That's what aliases do.

Try it right now in Terminal:

```bash
alias ll="ls -la"
ll
```

It works immediately! But here's the problem: close Terminal and open a new window, then type `ll` again. You'll get `command not found`. The alias existed only in that session — it vanished when the window closed.

To make any alias permanent, it must live in `.zshrc`:

```bash
echo 'alias ll="ls -la"' >> ~/.zshrc
```

That `>>` appends the line to the end of `.zshrc` without overwriting what's already there. Now it's permanent.

But notice something important: you still can't use `ll` in your current Terminal window! The shell only reads `.zshrc` when it starts. You either need to open a new Terminal window, or use `source` to reload the file in your current session:

```bash
source ~/.zshrc
ll   # Works now!
```

`source` runs a file's contents in the current shell. This is your reload command. Every time you edit `.zshrc`, you run `source ~/.zshrc` to see the changes immediately without restarting Terminal.

#### Building a Full Set of Aliases

Let's add a complete set of detective aliases all at once. Open `.zshrc`:

```bash
nano ~/.zshrc
```

Scroll to the bottom and add this entire block:

```bash
# ===== DETECTIVE AGENCY ALIASES =====
# Added Mission 10 — [your date here]

# --- File listing — see everything clearly ---
alias ll="ls -la"           # detailed list with hidden files
alias la="ls -la"           # same thing with a different name
alias l="ls -l"             # detailed list, no hidden files
alias lc="ls -G"            # colored list, compact

# --- Navigation shortcuts — move fast ---
alias home="cd ~"           # go home no matter where you are
alias ..="cd .."            # go up one level
alias ...="cd ../.."        # go up two levels
alias ....="cd ../../.."    # go up three levels

# --- Safety nets — never lose evidence ---
alias rm="rm -i"            # always confirm before deleting
alias cp="cp -i"            # always confirm before overwriting
alias mv="mv -i"            # always confirm before moving

# --- Agency shortcuts ---
alias morning="~/morning.sh"
alias diary="open -a TextEdit ~/diary/journal.txt"
alias finder="open ."       # open current folder in Finder

# --- Detective specials ---
alias grep="grep --color=auto"   # colorful search results
alias ls="ls -G"                 # always colored ls
alias today="date +'%A, %B %d, %Y'"
alias reload="source ~/.zshrc"   # quickly reload your settings
alias myip="curl -s ifconfig.me" # check your public IP address
alias week="cal"                 # show a calendar
```

Save with `Ctrl+O`, press Enter, then exit with `Ctrl+X`. Reload:

```bash
source ~/.zshrc
```

Now test a few:

```bash
ll              # detailed file listing
today           # today's date, formatted nicely
..              # move up one directory
home            # go back home
reload          # reload .zshrc (uses itself!)
```

The detective mindset about aliases: you're building your own private command vocabulary. The more you use the terminal, the more you'll notice which commands you type constantly. Every one of those is a candidate for an alias. Over time, your alias collection becomes a signature — it reflects how you work.

### Customizing the Prompt — Your Agent Signature

The prompt is the text that appears before your cursor — the thing you look at hundreds of times every single day you use Terminal. By default on a Mac it looks something like `sophia@MacBook-Pro ~ %`. It's functional, but it's not *yours*.

The variable that controls the zsh prompt is `PROMPT` (you'll also see `PS1` in older documentation and in bash — they work similarly, but zsh prefers `PROMPT`).

#### Understanding Prompt Variables

The prompt string can contain special codes that get replaced with live information:

| Code | What It Displays |
|------|-----------------|
| `%n` | Your username |
| `%m` | Your computer's hostname (short) |
| `%M` | Your computer's full hostname |
| `%~` | Current directory, full path (home shown as `~`) |
| `%1~` | Current directory name only (just the last folder) |
| `%2~` | Last two parts of the path |
| `%T` | Current time in HH:MM format |
| `%*` | Current time with seconds HH:MM:SS |
| `%D{format}` | Custom date/time format (like `%D{%b %d}` for "Apr 13") |
| `%#` | `%` for normal users, `#` for root (the superuser) |
| `%(?.✓.✗)` | Conditional: shows ✓ if last command succeeded, ✗ if it failed |
| `%j` | Number of currently running background jobs |

#### Colors in Your Prompt

zsh has two ways to add color. The first is the clean, zsh-native way using `%F{color}` and `%f` to reset:

```bash
# %F{color} turns on color, %f turns it off
export PROMPT="%F{magenta}hello%f world"
```

Available named colors: `red`, `green`, `yellow`, `blue`, `magenta` (purple), `cyan`, `white`, `black`. You can also use numbers 0-255 for 256-color terminals.

The second way uses ANSI escape codes (older style, still widely used):

| Color | ANSI Code | zsh `%F` equivalent |
|-------|-----------|---------------------|
| Red | `\[\e[31m\]` | `%F{red}` |
| Green | `\[\e[32m\]` | `%F{green}` |
| Yellow | `\[\e[33m\]` | `%F{yellow}` |
| Blue | `\[\e[34m\]` | `%F{blue}` |
| Purple | `\[\e[35m\]` | `%F{magenta}` |
| Cyan | `\[\e[36m\]` | `%F{cyan}` |
| White | `\[\e[37m\]` | `%F{white}` |
| Reset | `\[\e[0m\]` | `%f` |

The `%F{color}` syntax is cleaner and more reliable in zsh. Use it.

#### Testing Prompt Designs (Temporarily)

The best way to design your prompt is to try things and see how they look. Set a temporary prompt right in Terminal — it only lasts for that session:

```bash
# Minimal and professional:
export PROMPT="%F{cyan}[AGENT] %F{yellow}%1~ %f%% "

# With a magnifying glass emoji:
export PROMPT="🔍 %F{yellow}%1~ %f%% "

# With your agent name and time:
export PROMPT="%F{magenta}Agent %n %F{cyan}%T %F{yellow}%1~ %f%% "

# Two-line prompt — no cramping:
export PROMPT="%F{cyan}╭─[%F{magenta}%n%F{cyan}]─[%F{yellow}%1~%F{cyan}]
╰─%f%% "

# Status indicator — shows ✓ if last command worked, ✗ if it failed:
export PROMPT="%(?.%F{green}✓.%F{red}✗)%f %F{yellow}%1~ %f%% "
```

The `%%` at the end of most of these becomes a literal `%` sign — in zsh prompt strings, `%` has special meaning, so you need `%%` to display an actual percent sign.

Try each one. Don't worry about "getting it wrong" — to reset to your original prompt just run `source ~/.zshrc` and your saved prompt comes back.

When you find a design you love, copy that line into your `.zshrc`.

#### Browsing the Agency's Theme Files

Your agency has three pre-built themes. Read all of them before deciding:

```bash
ls playground/mission_10/themes/
cat playground/mission_10/themes/stealth_mode.txt
cat playground/mission_10/themes/sunrise_agent.txt
cat playground/mission_10/themes/minimal_pro.txt
```

Each theme file contains a complete `PROMPT` line and color scheme you can copy directly. You can also mix and match — take the colors from one theme and the prompt structure from another.

### Shell Functions vs. Aliases — Knowing the Difference

Aliases are powerful, but they have a limitation: an alias always replaces one command with one other command. It can't take arguments in a flexible way, it can't run multiple steps with logic between them, and it can't make decisions.

That's where **shell functions** come in.

**Use an alias when:** you want to rename or shorten a command.
```bash
alias ll="ls -la"
alias myip="curl -s ifconfig.me"
alias reload="source ~/.zshrc"
```

**Use a function when:** you need arguments, multiple steps, conditions, or loops.

```bash
# Create a folder AND immediately enter it (two commands, one action):
mkcd() {
    mkdir -p "$1" && cd "$1"
    echo "Created and entered: $1"
}
```

After adding this to `.zshrc` and running `source ~/.zshrc`:

```bash
mkcd ~/cases/new_investigation
pwd   # You're already inside the new folder!
```

The `$1` is a positional parameter — it means "whatever the user typed as the first argument." Functions can take many arguments: `$1`, `$2`, `$3`, and so on. `$*` means all arguments together. `$#` is the count of arguments.

Here are more useful functions:

```bash
# Count files in any folder
countfiles() {
    local folder="${1:-.}"   # use argument if given, or current folder
    local count=$(ls "$folder" | wc -l | tr -d ' ')
    echo "$count files in $folder"
}

# Go up N levels (e.g., 'up 3' goes up three directories)
up() {
    local n="${1:-1}"
    local path=""
    for i in $(seq 1 "$n"); do
        path="../$path"
    done
    cd "$path"
}

# Quick look at a file with a header
peek() {
    echo "--- $1 ---"
    head -20 "$1"
    echo "..."
}
```

### The `briefing()` Function — Your Status Report

The agency wants every operative to have a `briefing()` function. Type `briefing` when you start work and get an instant status report: who you are, what time it is, where you are in the filesystem. Here's a well-designed one:

```bash
briefing() {
    echo ""
    echo "┌────────────────────────────────────────┐"
    echo "│        TERMINAL DETECTIVE AGENCY       │"
    echo "├────────────────────────────────────────┤"
    printf "│  Agent:    %-28s│\n" "$(whoami)"
    printf "│  Date:     %-28s│\n" "$(date +'%A, %B %d, %Y')"
    printf "│  Time:     %-28s│\n" "$(date +'%I:%M %p')"
    printf "│  Location: %-28s│\n" "$(pwd | sed 's|'"$HOME"'|~|')"
    printf "│  Files:    %-28s│\n" "$(ls | wc -l | tr -d ' ') items in current folder"
    echo "└────────────────────────────────────────┘"
    echo ""
}
```

The `printf` command works like `echo` but with formatting control. `%-28s` means "left-aligned, 28 characters wide" — that makes all the values line up neatly inside the box.

### PATH — The Command Search Map

`PATH` is one of the most important environment variables your shell has. It's a colon-separated list of directory paths. Whenever you type a command, the shell searches every directory in `PATH` from left to right until it finds a program with that name.

See your PATH right now:

```bash
echo $PATH
```

You'll see something like:

```
/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
```

The shell checks `/usr/local/bin` first. If the command isn't there, it checks `/usr/bin`. Then `/bin`. And so on. The first match wins.

This matters in several situations:

1. **"Command not found" errors** — if you install a program but the shell can't find it, the program is probably installed in a directory that's not in your PATH.

2. **Multiple versions of the same program** — if you have Python 2 installed in `/usr/bin/python` and Python 3 installed in `/usr/local/bin/python`, the one in the earlier PATH directory wins. Order matters.

3. **Your own scripts** — if you create a `~/bin` folder and add it to PATH, any script you drop in `~/bin` becomes a command you can run from anywhere.

To add a directory to PATH in `.zshrc`:

```bash
# Add ~/bin to the front of PATH (searched first)
export PATH="$HOME/bin:$PATH"
```

The `$HOME` is the same as `~` — it's your home directory. We use `$HOME` here because the PATH variable doesn't always expand `~` correctly.

The `export` keyword is important. Without it, the PATH change only exists in the current shell — programs you launch wouldn't see the updated PATH. `export` makes a variable available to child processes (every program you run from Terminal).

### The Shell Configuration File Family

You'll sometimes see other dot-files mentioned in documentation. Here's what each one does and when to use it:

| File | When It Runs | Best For |
|------|-------------|----------|
| `~/.zshrc` | Every interactive shell (every new Terminal window) | Aliases, functions, prompts, colors — everything you interact with daily |
| `~/.zprofile` | Login shells only (once when you log in to your Mac) | Environment variables that should be set once per login session |
| `~/.zshenv` | Every zsh instance, even scripts and non-interactive shells | Critical PATH settings that every zsh invocation needs |
| `~/.zlogout` | When you log out | Cleanup commands (rarely needed) |

For almost everything you want to customize — aliases, functions, colors, prompts — `.zshrc` is the right file. That's where your detective lair lives.

The rule of thumb: if you want it to show up when you open Terminal, put it in `.zshrc`.

### `export` — Making Variables Available Everywhere

When you set a variable in the shell, by default it's local — it only exists in that shell session and doesn't get passed to programs you run.

```bash
MY_CODENAME="Shadow"   # Local variable
echo $MY_CODENAME      # Works here
bash -c 'echo $MY_CODENAME'  # Empty! The new bash doesn't see it
```

When you add `export`, the variable becomes an **environment variable** — it gets passed down to every program launched from this shell:

```bash
export MY_CODENAME="Shadow"
bash -c 'echo $MY_CODENAME'  # Prints "Shadow" now!
```

That's why you see `export PROMPT=...` and `export PATH=...` — the prompt and PATH need to be visible to zsh itself and to everything it runs.

You'll also see `export` used to set things like:
- `export EDITOR="nano"` — tells programs which text editor to use when they need to open one
- `export LANG="en_US.UTF-8"` — sets your language and character encoding
- `export HISTSIZE=10000` — controls how many commands your history remembers

---

## 🧪 FIELD WORK

### Experiment 1 — Study the Agency's Files

Start by reading everything in your case folder:

```bash
# Read the mission briefing
cat playground/mission_10/case_briefing.txt

# Study the sample .zshrc — read it carefully, line by line
cat playground/mission_10/sample_zshrc

# Look at all recommended aliases
cat playground/mission_10/aliases.txt

# Browse the themes
ls playground/mission_10/themes/
cat playground/mission_10/themes/stealth_mode.txt
cat playground/mission_10/themes/sunrise_agent.txt
cat playground/mission_10/themes/minimal_pro.txt
```

After reading all three themes, pick your favorite. You'll apply it in the main mission.

### Experiment 2 — Test the Add-and-Source Cycle

Practice the fundamental workflow of customizing `.zshrc`:

```bash
# Step 1: Back up your current .zshrc (always do this before big changes)
cp ~/.zshrc ~/.zshrc.backup

# Step 2: Add a test alias
echo 'alias mission="ls -la"' >> ~/.zshrc

# Step 3: Reload
source ~/.zshrc

# Step 4: Test
mission    # Should show ls -la output!

# Step 5: Verify it's in .zshrc
tail -5 ~/.zshrc   # See the last few lines
```

That five-step cycle — **add, source, test, verify** — is exactly how you'll build your complete configuration.

### Experiment 3 — Try Multiple Prompt Designs

Test at least three different prompt styles temporarily (they won't save):

```bash
# Minimal:
export PROMPT="%W % "

# With emoji:
export PROMPT="🔎 %F{yellow}%1~ %f%% "

# With full path in blue:
export PROMPT="%F{blue}%~%f %% "

# With time:
export PROMPT="%F{cyan}%T %F{magenta}%n %F{yellow}%1~ %f%% "
```

After each one, run a few commands and see how the prompt feels. Notice how the different elements change your experience.

Reset to your saved prompt at any time:
```bash
source ~/.zshrc
```

### Experiment 4 — Build a Useful Function

Add this function to your `.zshrc` and test it:

```bash
# Create a folder and immediately enter it
mkcd() {
    mkdir -p "$1" && cd "$1"
    echo "Created and entered: $1"
}
```

After `source ~/.zshrc`:

```bash
mkcd ~/test_lair
pwd                    # You're inside ~/test_lair
mkcd sub_room/level_2  # Create nested folders and enter the deepest one
pwd
cd ~
rm -r ~/test_lair
```

### Experiment 5 — Explore PATH

```bash
# See your current PATH
echo $PATH

# Make it more readable (split on colons)
echo $PATH | tr ':' '\n'

# Add ~/bin to PATH and verify
mkdir -p ~/bin
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
echo $PATH | tr ':' '\n' | head -5   # ~/bin should be first
```

### Experiment 6 — Create a Custom Greeting Alias

Build an alias that runs multiple commands:

```bash
alias greet="echo \"Hello, \$(whoami)! Today is \$(date +'%A, %B %d').\" && say \"Hello \$(whoami), good day.\""
greet
```

That's a lot of quoting! The `\$(...)` runs the command inside and uses the result. When things get this complex, it's a hint that a function might be cleaner than an alias.

### Experiment 7 — See the Difference Between Local and Exported Variables

This experiment demonstrates exactly what `export` does:

```bash
# Set a variable without export
REGULAR_VAR="I am regular"

# Set a variable WITH export
export EXPORTED_VAR="I am exported"

# Both work in the current shell:
echo $REGULAR_VAR
echo $EXPORTED_VAR

# Now start a new shell and check:
bash -c 'echo "REGULAR: $REGULAR_VAR"'        # Will be empty!
bash -c 'echo "EXPORTED: $EXPORTED_VAR"'      # Will show the value!
```

See the difference? `REGULAR_VAR` doesn't exist in the child shell (`bash -c ...` creates a new shell). `EXPORTED_VAR` does, because `export` passes it down.

This is why environment variables like `PATH` and `PROMPT` use `export` — they need to be available not just in the current shell, but in everything the shell launches.

### Experiment 8 — Understand the Config File Hierarchy

Try creating a simple variable in each config file type to see when each runs:

```bash
# This experiment is conceptual — understand the load order:

# ~/.zshenv — loaded for EVERY zsh, even non-interactive ones
# (scripts, background tasks, everything)

# ~/.zprofile — loaded for LOGIN shells only
# (when you log into your Mac account; once per session)

# ~/.zshrc — loaded for every INTERACTIVE shell
# (every new Terminal window you open)

# ~/.zlogout — loaded when you log OUT
# (rarely used)

# For daily customization: everything goes in ~/.zshrc
# For PATH and critical environment: sometimes ~/.zshenv
# For one-time session setup: occasionally ~/.zprofile
```

The practical takeaway: put your aliases, functions, prompt, and PATH additions in `~/.zshrc`. That's where they belong, and that's where you'll find them.

---

## 🎯 MISSION: Build Your Complete Command Center

Time to build your full, permanent `.zshrc`. Work through each section carefully.

### Step 1 — Back Up Your Current Configuration

```bash
cp ~/.zshrc ~/.zshrc.backup
echo "Backup saved to ~/.zshrc.backup"
```

If anything goes wrong, you can restore with: `cp ~/.zshrc.backup ~/.zshrc`

### Step 2 — Open Your Configuration File

```bash
nano ~/.zshrc
```

Scroll to the bottom. You'll add all new content below whatever is already there.

### Step 3 — Add the Full Detective Configuration

Copy this template and customize it — change "Agent" to your actual agent name, pick the colors you liked from the theme files, add your own aliases from the suggestions in `aliases.txt`:

```bash
# ================================================
# AGENT [YOUR NAME]'S COMMAND CENTER
# Terminal Detective Agency
# Configured: [today's date]
# ================================================

# --- DETECTIVE PROMPT ---
# Replace this with the PROMPT line from your chosen theme,
# or write your own custom prompt here.
export PROMPT="%F{magenta}🔍 Agent %n %F{yellow}%1~ %f%% "

# --- FILE LISTING ALIASES ---
alias ll="ls -la"
alias la="ls -la"
alias l="ls -lG"
alias ls="ls -G"

# --- NAVIGATION ALIASES ---
alias ..="cd .."
alias ...="cd ../.."
alias home="cd ~"
alias finder="open ."

# --- SAFETY ALIASES ---
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# --- DETECTIVE SPECIALS (add at least 5 from aliases.txt) ---
alias mission="ls -la"
alias today="date +'%A, %B %d, %Y'"
alias reload="source ~/.zshrc"
alias myip="curl -s ifconfig.me"
alias week="cal"
alias grep="grep --color=auto"

# --- FUNCTIONS ---

# Make a folder and enter it immediately
mkcd() {
    mkdir -p "$1" && cd "$1"
    echo "Created and entered: $1"
}

# Show agency status briefing
briefing() {
    echo ""
    echo "┌────────────────────────────────────────┐"
    echo "│        TERMINAL DETECTIVE AGENCY       │"
    echo "├────────────────────────────────────────┤"
    printf "│  Agent:    %-28s│\n" "$(whoami)"
    printf "│  Date:     %-28s│\n" "$(date +'%A, %B %d, %Y')"
    printf "│  Time:     %-28s│\n" "$(date +'%I:%M %p')"
    printf "│  Location: %-28s│\n" "$(basename $(pwd))"
    echo "└────────────────────────────────────────┘"
    echo ""
}

# Count files in a folder
countfiles() {
    local folder="${1:-.}"
    ls "$folder" | wc -l | tr -d ' '
    echo "files in ${folder}"
}

# Quick log entry to diary
log() {
    local entry_file="$HOME/diary/journal.txt"
    mkdir -p "$(dirname "$entry_file")"

    if [ -z "$1" ]; then
        echo "What happened today?"
        read entry
    else
        entry="$*"
    fi

    {
        echo "=== $(date +'%A, %B %d, %Y') ==="
        echo ""
        echo "$entry"
        echo ""
        echo "---"
        echo ""
    } >> "$entry_file"
    echo "Entry logged to $entry_file"
}

# --- PATH ADDITIONS ---
export PATH="$HOME/bin:$PATH"

# --- WELCOME MESSAGE ---
# This runs every time Terminal opens
echo ""
echo "Welcome back, $(whoami). Today is $(date +'%A, %B %d')."
echo "Type 'briefing' to see your status."
echo ""
```

### Step 4 — Save, Reload, and Test Everything

```bash
# Save (Ctrl+O, Enter) and exit (Ctrl+X)

# Reload immediately
source ~/.zshrc

# Test each section:
ll                          # file listing alias
today                       # date alias
briefing                    # status function
mkcd ~/test_command_center  # make + enter folder
pwd                         # confirm you're inside it
cd ~
rm -r ~/test_command_center
countfiles ~                # count files in home
log "Mission 10 complete. Command center fully operational."
reload                      # reload alias (tests itself!)
```

### Step 5 — Apply Your Chosen Theme

Open `.zshrc` and replace the PROMPT line with the one from your chosen theme:

```bash
nano ~/.zshrc
# Find the PROMPT line and replace it with the content from your theme file
source ~/.zshrc
```

### Step 6 — Open a Fresh Terminal Window

Close your current Terminal window. Open a brand new one. You should see:
- Your custom welcome message
- Your custom prompt

This is the real test. Everything was saved to `.zshrc` and loads automatically. This is your lair now. Every new Terminal window will look and feel exactly like you designed it.

---

## 🏆 BONUS MISSIONS

### Bonus Mission 1 — Design Your Perfect Prompt

Build a prompt that includes ALL four of these elements:
1. Your actual first name (hardcoded as text — not `%n`, but literally "Agent Maya" or your name)
2. The current time
3. The current folder name (not full path, just the folder)
4. A detective emoji or symbol of your choice

Test it temporarily, iterate until it's perfect, then save it to `.zshrc`.

Hint: Two-line prompts give you more room:
```bash
export PROMPT="
%F{cyan}[%F{magenta}Agent YourName %F{cyan}| %F{yellow}%T %F{cyan}| %F{green}%1~%F{cyan}]
%f🔍 "
```

### Bonus Mission 2 — Five More Aliases You'd Actually Use

Beyond the required aliases, add five more that fit YOUR workflow. Think about commands you type often. What would you love to shorten?

Some ideas:
- `alias week="cal"` — show a monthly calendar
- `alias myip="curl -s ifconfig.me"` — check your public IP address
- `alias space="df -h"` — how much disk space is available
- `alias scripts="ls ~/bin"` — list your custom scripts
- `alias trash="rm -ri"` — interactive removal with recursive option
- `alias clock="date +'%I:%M:%S %p'"` — just the time
- `alias ports="netstat -tuln"` — see what's listening on your network

### Bonus Mission 3 — Upgrade the `log` Function

The `log` function you built handles both cases (with and without arguments). Now add these improvements:

1. **Timestamp to the second**, not just the date
2. **Word count** on your entry — after saving, show how many words you wrote
3. **Entry number** — count how many `===` headers are in the journal and show which entry number this is

**Hint:** `grep -c "^===" "$entry_file"` counts the entries.

### Bonus Mission 4 — Voice Greeting on Startup

Add a `say` command to your welcome message so Terminal greets you by voice when it opens:

```bash
# In your welcome message section:
echo ""
echo "Welcome back, $(whoami). Today is $(date +'%A, %B %d')."
say -v Samantha "Welcome back, Agent. Today is $(date +'%A')." &
echo "Type 'briefing' to see your status."
echo ""
```

The `&` at the end runs `say` in the background — Terminal doesn't wait for it to finish before continuing. This way the welcome text appears immediately and the voice comes right after.

Replace "Samantha" with the voice you chose in Mission 1.

### Bonus Mission 5 — The `up` Function

One common frustration when working deep in a directory tree: you need to go up several levels at once. You can type `cd ../../..` — but that's awkward to count. Build a smarter solution:

Build a function that lets you go up N directory levels at once:

```bash
up() {
    local n="${1:-1}"    # default to 1 if no argument
    for i in $(seq 1 "$n"); do
        cd ..
    done
    pwd   # show where you ended up
}
```

After adding and reloading:
```bash
cd ~/Documents/projects/detective_files/case_042
up 2       # goes up two levels to ~/Documents/projects
up         # goes up one more level to ~/Documents
```

---

## 🔐 CODE PIECE UNLOCKED!

**Code Piece #10: KEEP**

```bash
cat playground/mission_10/secret_code_piece.txt
```

Ten pieces collected. The secret phrase is almost complete.

---

## ⚡ POWERS UNLOCKED

| Concept | How It Works |
|---------|-------------|
| `alias name="command"` | Create a permanent shortcut command |
| `source ~/.zshrc` | Reload the config file without restarting Terminal |
| `export PROMPT="..."` | Set your prompt appearance permanently |
| `%n`, `%1~`, `%T` | Username, directory name, time in zsh prompt |
| `%F{color}...%f` | Color codes for zsh prompt (clean syntax) |
| `\[\e[35m\]...\[\e[0m\]` | ANSI color codes (alternative syntax, still works) |
| `function_name() { ... }` | Define a reusable shell function |
| `$1`, `$2`, `$*` | Positional parameters in functions |
| `$PATH` | The list of directories the shell searches for programs |
| `export VAR="value"` | Make a variable available to all child processes |
| `~/.zshrc` | Runs on every interactive shell start |
| `~/.zprofile` | Runs on login shells only |
| `~/.zshenv` | Runs on every zsh instance, including scripts |
| `%%` in PROMPT | Literal `%` sign (escaped because `%` is special in zsh) |
| `${1:-default}` | Use argument `$1`, or "default" if no argument given |
| `printf "%-28s"` | Left-aligned, fixed-width text formatting |

### Detective Vocabulary

- **`.zshrc`** — the configuration file that runs every time zsh starts; your command center blueprint
- **alias** — a name that expands into a full command when you type it
- **prompt** — the text before your cursor; your agent signature on screen
- **`PROMPT`** — the zsh variable that controls what your prompt looks like
- **`source`** — run a file's commands in the current shell session (not a subprocess)
- **`PATH`** — the list of directories the shell searches when you type a command name
- **`export`** — make a variable available to programs launched from this shell
- **function** — a named block of shell code that accepts arguments and can run multiple steps
- **ANSI color codes** — special character sequences that instruct the terminal to display colored text
- **modular** — organized in separate parts, where each part has one job

---

*Your terminal is yours now. The colors, the shortcuts, the greeting, the prompt — all of it.*

*You didn't just learn to customize a terminal. You built an environment that reflects who you are as a detective.*

*Ready for Case File #11? The next mission goes deep undercover. You'll learn to lock files, hide evidence, and decode encrypted communications.*
