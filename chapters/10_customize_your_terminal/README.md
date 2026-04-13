# Mission 10 — Your Secret Lair

## Mission Briefing

*"Every agent has a lair," Agent SWIFT says. "A place configured exactly the way they like it. Shortcuts for their most-used commands. A custom prompt. A welcome message when Terminal opens. This mission: make your Terminal YOURS."*

You've been working in a plain, default Terminal. But Terminal is YOUR space — and you get to decorate it.

Professional programmers spend real time customizing their terminals. The right setup means faster work, better readability, and a terminal that feels like *home*. After this mission, yours will look completely different — in the best way.

**Your lair configuration tools are in `playground/mission_10/`. Study them, then apply what you like to your real `.zshrc`.**

### What You'll Learn
- The `PS1` prompt — customize what your prompt looks like
- Aliases — create your own shortcut commands
- `.zshrc` — your shell's permanent settings file
- Colors and styles in Terminal

---

## The `.zshrc` File

Every time you open a new Terminal window, your shell reads `~/.zshrc`. It's the configuration file that sets up your whole environment.

Open it (don't worry if it's mostly empty):

```bash
nano ~/.zshrc
```

Close it for now (`Ctrl+X`). We'll edit it as we go.

---

## Aliases — Your Own Commands

An **alias** is a custom shortcut for any command:

```bash
alias ll="ls -la"
```

Try it immediately:

```bash
alias ll="ls -la"
ll
```

It works! But it disappears when you close Terminal. To make it permanent, add it to `.zshrc`.

---

## Customizing the Prompt (`PS1`)

The variable that controls your prompt is `PS1`.

### Colors in Terminal

| Color | Code |
|-------|------|
| Red | `\[\e[31m\]` |
| Green | `\[\e[32m\]` |
| Yellow | `\[\e[33m\]` |
| Blue | `\[\e[34m\]` |
| Purple | `\[\e[35m\]` |
| Cyan | `\[\e[36m\]` |
| Reset | `\[\e[0m\]` |

### Prompt Variables

| Code | Meaning |
|------|---------|
| `\u` | Your username |
| `\w` | Current directory (full path) |
| `\W` | Current directory (just the name) |
| `\t` | Current time |

Try a custom prompt:

```bash
export PS1="\[\e[35m\]TDA:\[\e[33m\]\W\[\e[0m\] > "
```

Your prompt now shows: `TDA:mission_10 > `

---

## Try It! — Quick Experiments

**Experiment 1:** Study the sample configuration:
```bash
cat playground/mission_10/sample_zshrc
```

Read every section. Pick the aliases you want to use.

**Experiment 2:** Study the cool aliases list:
```bash
cat playground/mission_10/cool_aliases.txt
```

**Experiment 3:** Test a few prompts:
```bash
export PS1="\W > "           # minimal
export PS1="🔍 \W > "        # with emoji
export PS1="\[\e[35m\]\u \[\e[33m\]\W \[\e[0m\]% "   # colored
```

Reset anytime with:
```bash
source ~/.zshrc
```

**Experiment 4:** Create a "greet" command:
```bash
alias greet="echo \"Welcome back, $(whoami)!\" && say \"Welcome back $(whoami)\""
greet
```

---

## Pro Tip — Shell Functions

You can create **functions** in `.zshrc` for more complex shortcuts:

```bash
mkcd() {
    mkdir -p "$1" && cd "$1"
    echo "Created and moved into: $1"
}
```

After adding to `.zshrc` and running `source ~/.zshrc`:

```bash
mkcd ~/cases/new_case
pwd
```

Creates AND enters the folder in one command!

---

## Your Mission — Build Your Detective Lair

**Step 1:** Study your lair template:
```bash
cd playground/mission_10
cat sample_zshrc
cat cool_aliases.txt
```

**Step 2:** Open your real config:
```bash
nano ~/.zshrc
```

**Step 3:** Add this whole block at the bottom (customize it!):

```bash
# ================================================
# MY TERMINAL DETECTIVE AGENCY CONFIGURATION
# ================================================

# --- PROMPT ---
# Purple username, yellow folder, white prompt
export PS1="\[\e[35m\]\u \[\e[33m\]\W \[\e[0m\]% "

# --- ALIASES ---
alias ll="ls -la"
alias la="ls -la"
alias ..="cd .."
alias ...="cd ../.."
alias home="cd ~"
alias finder="open ."
alias rm="rm -i"          # safety: always ask before deleting
alias search="grep -r"   # shortcut: search "word" . to find in all files
alias today="date +'%A, %B %d, %Y'"

# --- FUNCTIONS ---
mkcd() {
    mkdir -p "$1" && cd "$1"
}

findfile() {
    find ~ -name "*$1*" 2>/dev/null
}

# --- WELCOME MESSAGE ---
echo ""
echo "TDA Terminal ready. Welcome back, $(whoami)."
echo "$(date +'%A, %B %d, %Y')"
echo ""
```

**Step 4:** Save and reload:
```bash
# Save: Ctrl+O, Enter
# Exit: Ctrl+X
source ~/.zshrc
```

**Step 5:** Test your new commands:
```bash
ll                      # should work like ls -la
today                   # should print the date
mkcd ~/test_lair        # should create and enter the folder
cd ~
rm -r ~/test_lair
```

**Step 6:** Find the hidden code:
```bash
ls -la playground/mission_10/
cat playground/mission_10/.secret_code.txt
```

---

## Challenges

### Challenge 1 — Design Your Perfect Prompt

Create a prompt that includes:
- Your name or codename (hardcoded)
- The current time
- The current folder name
- Your favorite emoji

Test it, then add it to `.zshrc`.

### Challenge 2 — Five Useful Aliases

Add 5 more aliases that YOU would actually use. Some ideas:
```bash
alias week="cal"                            # show a calendar
alias myip="curl -s ifconfig.me"            # your public IP
alias reload="source ~/.zshrc"              # quickly reload settings
alias catfact="curl -s https://catfact.ninja/fact"
alias weather="curl -s wttr.in/?format=3"   # quick weather!
```

### Challenge 3 — The `log` Function

Add a function to `.zshrc` that creates a quick diary entry:

```bash
log() {
    echo "=== $(date +'%A, %B %d, %Y') ===" >> ~/detective_diary.txt
    echo "$*" >> ~/detective_diary.txt
    echo "---" >> ~/detective_diary.txt
    echo "Entry saved!"
}
```

Test it: `log "Today I built my detective lair!"`

### Challenge 4 — Add a Voice Greeting

Add a `say` command to your `.zshrc` welcome message that speaks a greeting using your favorite voice when Terminal opens.

---

## Solutions

Solutions are in the [solutions folder](solutions/README.md).

---

## Powers Unlocked

| Concept | How It Works |
|---------|-------------|
| `alias name="command"` | Create a shortcut command |
| `source ~/.zshrc` | Reload the config file right now |
| `export PS1="..."` | Set the prompt appearance |
| `\u`, `\W`, `\t` | Username, folder name, time in PS1 |
| `\[\e[35m\]...\[\e[0m\]` | Color codes in PS1 |
| `function_name() { ... }` | Define a shell function |

### Vocabulary

- **`.zshrc`** — the config file that runs when zsh starts
- **alias** — a shortcut that replaces one command with another
- **prompt** — the text before your cursor
- **`PS1`** — the variable controlling prompt appearance
- **`source`** — run a file's contents in the current shell

---

*Your terminal is yours now. The colors, the shortcuts, the welcome message — all of it. Welcome to your lair.*

*Ready for Mission 11?*
