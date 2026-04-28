# Mission 10 — Customize Your Terminal

## Mission Briefing

*Incoming transmission from Commander Chen...*

> "Detective, every great investigator has a customized setup. Sherlock Holmes had his violin and his pipe. Modern detectives have their terminals.
>
> Right now your Terminal looks generic. The prompt is plain, the colors are default, and you retype the same long commands over and over. That ends today.
>
> A great terminal setup means faster work, fewer mistakes, and a workspace that feels like YOUR headquarters. After this mission, opening Terminal will feel like walking into your personal command center.
>
> The configuration file awaits."

Professional developers spend real time customizing their terminals. A well-tuned setup can save you hours every week. More importantly, it turns your terminal from "that scary black window" into a space you actually enjoy being in.

### What You'll Learn
- The `.zshrc` file — your shell's permanent settings file
- Aliases — create your own shortcut commands
- The `PS1` prompt — customize what your prompt looks like
- Colors and styles in Terminal
- Shell functions — shortcuts that do complex things
- How to connect your Mission 7 briefing script as a single command

---

## Your Case Files

Before you start customizing, let's look at some examples. Navigate to the playground:

```bash
cd ~/mac-cli-for-kids/playground/mission_10
ls
```

You should see:

```
sample_zshrc       ← an example .zshrc with 10 aliases, 3 functions, custom prompt
cool_aliases.txt   ← 20 useful aliases with explanations
prompt_colors_starter.zsh ← a small prompt-color scaffold
.secret_code.txt   ← hidden! (find it at the end of the mission)
```

Read through the example config to see what a polished `.zshrc` looks like:

```bash
cat sample_zshrc
```

This is your reference document for the whole mission. Keep it open in a second Terminal window while you work. Now read the aliases file:

```bash
cat cool_aliases.txt
```

That file contains 20 useful aliases with explanations of what each one does. You will pick your favorites and add them to your own `.zshrc` during this mission.

---

## The `.zshrc` File

Every time you open a new Terminal window, your shell (zsh) reads a file called `.zshrc` in your home folder. It is the configuration file that sets up your entire environment — aliases, custom commands, colors, and everything else.

Open it:

```bash
nano ~/.zshrc
```

It might have some content already, or it might be nearly empty. Everything you add here runs automatically every time Terminal starts.

Close it for now (`Ctrl+X`). You will add things to it throughout this mission.

---

## Aliases — Your Own Commands

An **alias** is a shortcut name for any command you type often. Tired of typing `ls -la`? Make it `ll`:

```bash
alias ll="ls -la"
```

Type this in Terminal to try it right now:

```bash
alias ll="ls -la"
ll
```

It works! But it vanishes when you close Terminal. To make it permanent, add it to `.zshrc`:

```bash
echo 'alias ll="ls -la"' >> ~/.zshrc
```

Now let's add a whole detective toolkit of useful aliases at once:

```bash
nano ~/.zshrc
```

Add these lines at the bottom (after anything already there):

```bash
# ===== DETECTIVE ACADEMY — MY ALIASES =====

# Better file listing
alias ll="ls -la"
alias la="ls -la"
alias l="ls -l"
alias lc="ls -G"            # colorized list

# Navigation shortcuts
alias home="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias hq="cd ~/mac-cli-for-kids"    # jump to the Detective Academy!

# Safety nets (always ask before destroying something)
alias rm="rm -i"            # ask before deleting
alias cp="cp -i"            # ask before overwriting
alias mv="mv -i"            # ask before overwriting

# My detective tools
alias briefing="~/morning.sh"                  # from Mission 7
alias netcheck="~/investigate_network.sh"      # from Mission 9

# Colorful output
alias grep="grep --color=auto"
alias ls="ls -G"            # colored ls by default
```

Save (`Ctrl+O`, Enter) and exit (`Ctrl+X`).

Now reload `.zshrc` to apply your changes immediately without restarting Terminal:

```bash
source ~/.zshrc
```

`source` runs a file in the current shell session. After this, all your aliases are active!

Test them:

```bash
ll
hq
..
```

---

## Customizing the Prompt (`PS1`)

The **prompt** is the text that appears before your cursor: `sophia@MacBook-Pro ~ %`. You can change it to anything.

The variable controlling it is called `PS1` (Prompt String 1). In modern zsh on Macs, you can use `PROMPT` or `PS1` — either works.

### Colors in Terminal

Terminal supports ANSI color codes. They look cluttered in the file but display beautifully:

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

Always end with `\[\e[0m\]` to reset the color, otherwise your whole Terminal turns purple.

### Prompt Variables

| Code | Meaning |
|------|---------|
| `\u` | Your username |
| `\h` | Your computer's hostname |
| `\w` | Current directory (full path) |
| `\W` | Current directory (just the folder name) |
| `\t` | Current time (24-hour) |
| `\n` | Newline |

### Setting a Custom Prompt

Try this in Terminal first (temporary — just to preview how it looks):

```bash
export PS1="\[\e[35m\]Detective \u \[\e[33m\]\W \[\e[0m\]% "
```

Your prompt now looks like: `Detective sophia Documents %`

Experiment with different colors and text. When you find something you love, add it to `.zshrc`:

```bash
nano ~/.zshrc
```

Add at the bottom:

```bash
# ===== MY DETECTIVE PROMPT =====
# Purple "Detective" + name, yellow folder, white percent
export PS1="\[\e[35m\]Detective \u \[\e[33m\]\W \[\e[0m\]% "
```

Or try a more detailed two-line prompt:

```bash
# Two-line prompt: time + username + path, then blank second line
export PS1="\[\e[36m\][\t] \[\e[35m\]\u\[\e[0m\]:\[\e[33m\]\w\[\e[0m\]\n% "
```

This shows: `[10:30:15] sophia:/Users/sophia/Documents` then a new line with `%`.

---

## Try It! — Quick Experiments

**Experiment 1:** Test several prompt styles.

```bash
# Minimal and clean:
export PS1="\W % "

# With detective badge number:
export PS1="[BADGE-07] \W % "

# With emoji (if your terminal supports it):
export PS1="🔍 \W % "

# With full path in blue:
export PS1="\[\e[34m\]\w\[\e[0m\] % "
```

You can always reset to your saved setting with:
```bash
source ~/.zshrc
```

**Experiment 2:** Make an alias for your most-used command.

What command do you type most often in the Detective Academy? Make a short alias:

```bash
alias today="date +\"%A, %B %d, %Y\""
today
```

**Experiment 3:** Create a `hqstatus` command that shows what is in the Detective Academy folder.

```bash
alias hqstatus="ls -la ~/mac-cli-for-kids"
hqstatus
```

**Experiment 4:** Create a quick alias to open your alias file from the case files.

```bash
alias aliases="cat ~/mac-cli-for-kids/playground/mission_10/cool_aliases.txt"
aliases
```

---

## Pro Tip — PATH and Functions

Your `PATH` is a list of folders where Terminal searches when you type a command. When you type `ls`, Terminal checks each PATH folder until it finds an `ls` program.

See your PATH:
```bash
echo $PATH
```

Output:
```
/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
```

If you install a program and Terminal says "command not found," the program is probably in a folder that is not in your PATH. You can add folders to PATH in `.zshrc`.

You can also create **functions** in `.zshrc` for shortcuts that need more than one step:

```bash
# Make a folder AND immediately cd into it:
mkcd() {
    mkdir -p "$1" && cd "$1"
    echo "Created and entered: $1"
}
```

After adding this to `.zshrc` and running `source ~/.zshrc`:

```bash
mkcd ~/new_case_folder
pwd   # proves you are inside it
```

Two commands in one. Once you get used to functions like this, you will add them constantly.

---

## Your Mission — Build Your Personal Command Center

Build a complete, polished `.zshrc`. Here is a template that combines everything — customize every line to make it yours:

```bash
nano ~/.zshrc
```

Add this whole block (add it at the bottom so it does not conflict with anything already there):

```bash
# =====================================================
# DETECTIVE ACADEMY — PERSONAL TERMINAL CONFIGURATION
# =====================================================

# --- DETECTIVE PROMPT ---
# Purple "Detective" label, yellow folder, reset
export PS1="\[\e[35m\]Detective \u \[\e[33m\]\W \[\e[0m\]% "

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
alias hq="cd ~/mac-cli-for-kids"

# Safety nets
alias rm="rm -i"
alias cp="cp -i"

# My detective tools
alias briefing="~/morning.sh"
alias netcheck="~/investigate_network.sh"
alias diary="open -a TextEdit ~/diary/journal.txt"

# Useful shortcuts
alias today="date +'%A, %B %d, %Y'"
alias reload="source ~/.zshrc"    # reload settings instantly
alias myip="curl -s icanhazip.com"

# --- FUNCTIONS ---

# Make a folder and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
    echo "Created and entered: $1"
}

# Quick diary entry from the command line
log() {
    mkdir -p ~/diary
    echo "=== $(date +'%A, %B %d, %Y') ===" >> ~/diary/journal.txt
    echo "" >> ~/diary/journal.txt
    echo "$*" >> ~/diary/journal.txt
    echo "" >> ~/diary/journal.txt
    echo "---" >> ~/diary/journal.txt
    echo "Entry saved to diary."
}

# Count files in any folder
countfiles() {
    ls "${1:-.}" | wc -l
}

# --- WELCOME MESSAGE ---
echo ""
echo "Welcome back, Detective $(whoami)! Today is $(date +'%A, %B %d')."
echo "Type 'briefing' for your morning report."
echo ""
```

Save and reload:

```bash
source ~/.zshrc
```

Open a new Terminal window and admire your command center. Test your new functions:

```bash
mkcd ~/case_001_workspace
pwd          # proves you are inside the new folder
cd ~
rm -r ~/case_001_workspace

log "Completed Mission 10 today. Terminal is now officially my headquarters."
tail -8 ~/diary/journal.txt

countfiles ~
countfiles ~/Documents
```

---

## Challenges

### Case #1001 — Browse the Cool Aliases File

Read through `~/mac-cli-for-kids/playground/mission_10/cool_aliases.txt` and pick at least **5 aliases** you do not already have that you would actually use. Add them to your `.zshrc`. Run `source ~/.zshrc` and test each one.

### Case #1002 — Design Your Perfect Detective Prompt

Look at the `sample_zshrc` in the playground (`cat ~/mac-cli-for-kids/playground/mission_10/sample_zshrc`) and find its `PS1` line. Use it as inspiration to design a prompt that includes all of these:
- Your first name hardcoded (not `\u` — type your actual name)
- The current time
- The current folder name
- Your favorite color for each element

Test it in Terminal before adding it to `.zshrc`.

### Case #1003 — Improve the `log` Function

The `log` function above just saves whatever you type on the command line. Improve it:
- If called with no arguments (`log` by itself), ask "What happened today?" using `read`
- Then save the answer as a diary entry

**Hint:** Check if `$1` is empty with `if [ -z "$1" ]`. If empty, use `read` to get input. If not empty, use `$*` as before.

### Case #1004 — Add a Welcome Voice

Add a `say` command to the welcome message section in `.zshrc` so your Mac greets you out loud when a new Terminal opens. Use your favorite voice from Mission 1. Keep it short — just your name and the day of the week.

---

## Secret Code Hunt

You now know exactly how to find hidden files. The `mission_10` playground has one.

```bash
cd ~/mac-cli-for-kids/playground/mission_10
ls -a
```

Spot the hidden file and read it. That is your tenth secret code word. Write it down.

---

## Solutions

Solutions are in the [solutions folder](solutions/README.md).

---

## Powers Unlocked

| Concept | How It Works |
|---------|-------------|
| `alias name="command"` | Create a shortcut command |
| `source ~/.zshrc` | Reload the config file without restarting |
| `export PS1="..."` | Set the prompt appearance |
| `\u`, `\w`, `\W`, `\t` | Username, full path, folder name, time in PS1 |
| `\[\e[35m\]...\[\e[0m\]` | Color codes in PS1 |
| `function_name() { ... }` | Define a shell function |
| `$PATH` | The list of folders Terminal searches for programs |
| `$*` | All arguments passed to a function, as one string |
| `"${1:-.}"` | Use first argument, or `.` (current dir) if none given |

### Vocabulary

- **`.zshrc`** — the config file that runs automatically when zsh starts
- **alias** — a short name that expands to a longer command
- **prompt** — the text before your cursor showing you are ready to type
- **`PS1`** — the variable that controls the prompt's appearance
- **`source`** — run a file's contents in the current shell session
- **PATH** — the ordered list of directories the shell searches for programs
- **function** — a named block of code you can call like a command

---

*Your terminal is yours now. The colors, the shortcuts, the welcome message, the detective prompt — all of it. Commander Chen has officially designated this your personal headquarters.*

*Ready for Mission 11?*
