# Mission 10 — Customize Your Terminal

## Mission Briefing

You've been working in a plain, default Terminal. But Terminal is YOUR space — and you get to decorate it.

Professional programmers spend real time customizing their terminals. The right setup means faster work, better readability, and a terminal that feels like *home*. After this mission, yours will look and feel completely different — in the best way.

### What You'll Learn
- The `PS1` prompt — customize what your prompt looks like
- Aliases — create your own shortcut commands
- `.zshrc` — your shell's permanent settings file
- Colors and styles in Terminal
- How to add your morning script as a custom command

---

## The `.zshrc` File

Every time you open a new Terminal window, your shell reads a file called `.zshrc` (in your home folder). It's the configuration file that sets up your whole environment.

Open it:

```bash
nano ~/.zshrc
```

It might have some content already, or it might be empty. Everything you add here runs automatically when Terminal starts.

Close it for now (`Ctrl+X`). We'll edit it as we go.

---

## Aliases — Your Own Commands

An **alias** is a custom shortcut for any command. Tired of typing `ls -la`? Make it `ll`:

```bash
alias ll="ls -la"
```

Type this in Terminal to try it right now:

```bash
alias ll="ls -la"
ll
```

It works! But it disappears when you close Terminal. To make it permanent, add it to `.zshrc`:

```bash
echo 'alias ll="ls -la"' >> ~/.zshrc
```

Now let's add a bunch of useful aliases all at once:

```bash
nano ~/.zshrc
```

Add these lines at the bottom:

```bash
# ===== MY ALIASES =====

# Better file listing
alias ll="ls -la"
alias la="ls -la"
alias l="ls -l"
alias lc="ls -G"          # colored list

# Navigation shortcuts
alias home="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Safety nets
alias rm="rm -i"          # always ask before deleting
alias cp="cp -i"          # always ask before overwriting
alias mv="mv -i"          # always ask before overwriting

# My stuff
alias morning="~/morning.sh"
alias diary="open -a TextEdit ~/diary/journal.txt"
alias finder="open ."     # open current folder in Finder

# Make things colorful
alias grep="grep --color=auto"
alias ls="ls -G"          # colored ls by default
```

Save (`Ctrl+O`, Enter) and exit (`Ctrl+X`).

Now reload `.zshrc` to apply changes immediately:

```bash
source ~/.zshrc
```

`source` runs a file in the current shell. After this, all your aliases are active!

---

## Customizing the Prompt (`PS1`)

The prompt is the text that appears before your cursor. By default it's something like `sophia@MacBook-Pro ~ %`. You can make it anything you want.

The variable that controls it is `PS1` (Prompt String 1).

### Colors in Terminal

Terminal supports ANSI color codes. They look ugly in the file but they display beautifully:

| Color | Code |
|-------|------|
| Black | `\[\e[30m\]` |
| Red | `\[\e[31m\]` |
| Green | `\[\e[32m\]` |
| Yellow | `\[\e[33m\]` |
| Blue | `\[\e[34m\]` |
| Purple | `\[\e[35m\]` |
| Cyan | `\[\e[36m\]` |
| White | `\[\e[37m\]` |
| Reset (back to normal) | `\[\e[0m\]` |

### Prompt Variables

| Code | Meaning |
|------|---------|
| `\u` | Your username |
| `\h` | Your computer's hostname |
| `\w` | Current directory (full path) |
| `\W` | Current directory (just the name) |
| `\t` | Current time |
| `\n` | Newline |

### Setting a Custom Prompt

For zsh (which modern Macs use), the variable is actually `PROMPT` or `PS1`.

Try this in Terminal first (temporary, just to preview):

```bash
export PS1="\[\e[35m\]✨ Sophia \[\e[33m\]\W \[\e[0m\]% "
```

Your prompt now looks like: `✨ Sophia Desktop %`

Try different colors! When you find one you love, add it to `.zshrc`:

```bash
nano ~/.zshrc
```

Add at the bottom (replace with your preferred colors):

```bash
# ===== MY PROMPT =====
# Purple name, yellow folder, white percent sign
export PS1="\[\e[35m\]\u \[\e[33m\]\W \[\e[0m\]% "
```

Or for a more detailed prompt:

```bash
# Two-line prompt with time
export PS1="\[\e[36m\][\t] \[\e[35m\]\u\[\e[0m\]:\[\e[33m\]\W\[\e[0m\]\n% "
```

This shows: `[10:30:15] sophia:Documents` then a new line with `%`.

---

## Try It! — Quick Experiments

**Experiment 1:** Test a few prompts.

```bash
# Minimal and clean:
export PS1="\W % "

# With an emoji:
export PS1="🌟 \W % "

# With full path in blue:
export PS1="\[\e[34m\]\w\[\e[0m\] % "
```

Don't worry about "getting it wrong" — you can always reset to default with:
```bash
source ~/.zshrc
```

**Experiment 2:** Make an alias for your most-typed command.

What command do you type most often? Make a short alias for it.

```bash
alias today="date +\"%A, %B %d, %Y\""
today
```

**Experiment 3:** Create a "greet" command.

```bash
alias greet="echo \"Hello, \$(whoami)! Today is \$(date +\"%A\").\" && say \"Hello \$(whoami)\""
greet
```

**Experiment 4:** Create a "projects" command.

```bash
alias projects="ls ~/my_project"
```

---

## Pro Tip — PATH and Functions

Your `PATH` is a list of folders where Terminal looks for commands. When you type `ls`, it searches PATH to find the `ls` program.

See your PATH:
```bash
echo $PATH
```

Output:
```
/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
```

If you ever install a program and Terminal says "command not found" even though you installed it, the program is probably in a folder that's not in your PATH.

You can also create **functions** in `.zshrc` for more complex shortcuts:

```bash
# Make a folder AND go into it:
mkcd() {
    mkdir -p "$1" && cd "$1"
}
```

After adding this to `.zshrc` and running `source ~/.zshrc`:

```bash
mkcd my_new_folder
pwd
```

You created the folder AND moved into it with one command!

---

## Your Mission — Create Your Personal Terminal Setup

Build a complete, personalized `.zshrc` file. Here's a template to start from:

```bash
nano ~/.zshrc
```

Add this whole block (it won't break anything already there):

```bash
# ================================================
# SOPHIA'S TERMINAL CONFIGURATION
# ================================================

# --- PROMPT ---
# Purple username, yellow folder, white prompt
export PS1="\[\e[35m\]\u \[\e[33m\]\W \[\e[0m\]% "

# --- ALIASES ---
# File listing
alias ll="ls -la"
alias la="ls -la"
alias l="ls -lG"
alias ls="ls -G"

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias home="cd ~"
alias finder="open ."

# Safety
alias rm="rm -i"
alias cp="cp -i"

# My scripts
alias morning="~/morning.sh"
alias diary="open -a TextEdit ~/diary/journal.txt"

# Fun
alias today="date +'%A, %B %d, %Y'"
alias internet="~/internet_check.sh"

# --- FUNCTIONS ---
# Make a folder and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
    echo "Created and moved into: $1"
}

# Quick diary entry from terminal
log() {
    echo "=== $(date +'%A, %B %d, %Y') ===" >> ~/diary/journal.txt
    echo "" >> ~/diary/journal.txt
    echo "$*" >> ~/diary/journal.txt
    echo "" >> ~/diary/journal.txt
    echo "---" >> ~/diary/journal.txt
    echo "Diary entry saved!"
}

# Count files in a folder
countfiles() {
    ls "${1:-.}" | wc -l
}

# --- WELCOME MESSAGE ---
echo ""
echo "Welcome back, $(whoami)! Today is $(date +'%A, %B %d')."
echo ""
```

Save and reload:

```bash
source ~/.zshrc
```

Open a new Terminal window and see your personalized setup!

Test your new functions:

```bash
mkcd ~/test_new_folder
pwd
cd ~
rm -r ~/test_new_folder

log "Today I customized my terminal and it looks amazing!"
tail -8 ~/diary/journal.txt

countfiles ~
countfiles ~/Documents
```

---

## Challenges

### Challenge 1 — Design Your Perfect Prompt

Create a prompt that includes:
- Your first name (not your username) — hardcode it in the PS1 string
- The current time
- The current folder name
- Your favorite emoji

Test it, then add it to `.zshrc`.

### Challenge 2 — Five Useful Aliases

Add 5 more aliases that YOU would actually use. Here are some ideas — pick 5 or make your own:
- `alias week="cal"` — show a calendar
- `alias myip="curl -s ifconfig.me"`
- `alias reload="source ~/.zshrc"` — quickly reload your settings
- `alias scripts="ls ~/"`
- `alias trash="rm -ri"`

### Challenge 3 — Improve the `log` Function

The `log` function we built adds diary entries. Improve it to:
- If called with no arguments, ask "What happened today?" using `read`
- Then save the answer to the diary

**Hint:** Check if `$1` is empty with `if [ -z "$1" ]`.

### Challenge 4 — Add Your Favorite Greeting Voice

Add a line to `.zshrc` that runs a `say` command using your favorite voice to greet you when a new Terminal opens. (It's in the welcome message section.)

---

## Solutions

Solutions are in the [solutions folder](solutions/README.md).

---

## Powers Unlocked

| Concept | How It Works |
|---------|-------------|
| `alias name="command"` | Create a shortcut command |
| `source ~/.zshrc` | Reload the config file |
| `export PS1="..."` | Set the prompt appearance |
| `\u`, `\w`, `\t` | Username, path, time in PS1 |
| `\[\e[35m\]...\[\e[0m\]` | Color codes in PS1 |
| `function_name() { ... }` | Define a shell function |
| `$PATH` | Where the shell looks for programs |

### Vocabulary

- **`.zshrc`** — the config file that runs when zsh starts
- **alias** — a shortcut that replaces one command with another
- **prompt** — the text before your cursor that shows you're ready to type
- **`PS1`** — the variable controlling the prompt appearance
- **`source`** — run a file's contents in the current shell
- **PATH** — the list of directories the shell searches for commands

---

*Your terminal is yours now. The colors, the shortcuts, the welcome message — all of it.*

*Ready for Mission 11?*
