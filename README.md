# Terminal Quest: Detective Academy

### A hands-on Terminal adventure for curious teens

---

*Open the Terminal. Type one clear command. Watch the computer answer you directly. That little moment is the whole point of this book.*

---

## Welcome to Detective Academy

Your Mac has a second language. Most people only use the clicking-and-dragging part. The Terminal lets you talk to the computer directly: make folders, search files, rename things in seconds, fetch data from the internet, and build tiny tools that are actually yours.

This is not a book you are supposed to sit and read like homework. It is a set of missions. Type the commands. Change them. Break something harmless. Fix it. Keep going.

You are a recruit at the **Terminal Detective Academy**. Each chapter is a **Mission** — briefed by Commander Chen, equipped with new tools, and sent into a real folder full of case files, clues, and puzzles. At the end of all 12 missions, you'll unlock the final secret message.

---

## How to Use This Book

- Do one mission at a time. A good session is 20-40 minutes.
- Type the commands yourself. Copy-paste only when a script gets long.
- Stay inside the `playground/` folders while learning.
- Use Finder alongside Terminal. They show the same files, just in different ways.
- If a command fails, read the error before trying again. The error is usually a clue.
- Use starter code when the blank screen feels annoying.
- Customize everything with your own names, colors, jokes, and ideas.

The goal is not to memorize commands. The goal is to feel: "I can make my computer do things."

---

## Finder and Terminal Are the Same World

Terminal does not have a separate file system. When Terminal says:

```bash
pwd
```

it prints the folder you are standing in. Finder can open that exact same folder:

```bash
open .
```

The `.` means "right here". So `open .` means "open this Terminal folder in Finder."

Try using both views together:

1. In Terminal, go to a mission folder.
2. Run `pwd` to see the path.
3. Run `open .` to see that same folder in Finder.
4. Create or rename a file in Terminal, then watch it appear or change in Finder.

You can also drag a Finder folder into Terminal. macOS will paste the folder's full path for you.

---

## Parent / Setup Safety Notes

There are three parts to this project. Here's what each one does — and what it touches on your computer.

**`CLAUDE.md` — project-only, no side effects**
This file tells Claude how to help Joanna when she asks questions. It only applies when Claude is working inside this folder. Other projects are completely unaffected.

**`scripts/setup_terminal.sh` — modifies your global Terminal config**
Running this script adds a block to `~/.zshrc`, which is the configuration file loaded every time you open a Terminal window. This means the prompt, aliases, and shortcut commands (`missions`, `hint`, `secret`, etc.) will appear in **all** Terminal windows — not just inside this project. This is intentional: Joanna should be able to type `missions` from anywhere and jump straight to the playground.

When Joanna uses `secret`, the setup also records collected code words in `~/.terminal_quest_codes` so `codes` only shows words she has actually found.

The setup also adds a `coach` command. `coach start` opens a special zsh session where the coach watches each command after Enter, records the command/path/exit status in `~/.terminal_quest/coach_events.log`, and sends a small coaching prompt to Claude or Codex if one is installed. The hook does **not** capture full command output by default. Do not type passwords, API keys, or private family information in a coach session.

To undo everything: `bash scripts/reset_terminal.sh` restores your original `.zshrc` from a backup taken before setup ran and removes the local code collection and coach event logs.

**`playground/` — fully self-contained**
The mission folders, case files, and puzzle files all live inside this project directory. Nothing is installed system-wide. Deleting the repo removes them completely.

---

## Special Keys on Mac

The Terminal uses characters that can be hard to find, especially on a German keyboard. Here's where to find the important ones:

| Character | What it does | US Keyboard | German Keyboard |
|-----------|-------------|-------------|-----------------|
| `\|` (pipe) | Sends output to another command | Shift + `\` | Option + `/` |
| `~` (tilde) | Means "your home folder" | Shift + `` ` `` | Option + N, then Space |
| `\` (backslash) | Escape character | `\` key | Shift + Option + 7 |
| `[` and `]` | Used in scripts | `[` and `]` keys | Option + 5 / Option + 6 |
| `{` and `}` | Used in scripts | Shift + `[` / `]` | Option + 8 / Option + 9 |
| `@` | Used in email/variables | Shift + 2 | Option + L |
| `#` | Starts a comment in scripts | Shift + 3 | Option + 3 |

> **German keyboard tip:** The pipe character `|` (Option + `/`) is used constantly in Mission 6. Practise finding it before you get there.

---

## Terminal Keyboard Tricks

These habits make Terminal feel much less fussy. Learn them early and you will type less, fix mistakes faster, and avoid retyping long commands.

| Shortcut | What it does |
|----------|-------------|
| Up arrow | Bring back the previous command |
| Down arrow | Move forward through newer commands |
| Tab | Complete a file or folder name |
| Tab twice | Show possible completions when there is more than one match |
| Ctrl + A | Move the cursor to the start of the line |
| Ctrl + E | Move the cursor to the end of the line |
| Ctrl + U | Delete everything before the cursor |
| Ctrl + K | Delete everything after the cursor |
| Ctrl + W | Delete the word before the cursor |
| Ctrl + L | Clear the screen |
| Ctrl + C | Stop the command that is currently running |
| Ctrl + R | Search your command history |
| Cmd + C | Copy selected text in Terminal |
| Cmd + V | Paste text into Terminal |

One important Mac detail: in Terminal, `Ctrl + C` means "stop this command." It does **not** mean copy. Use `Cmd + C` and `Cmd + V` for copy and paste.

Finder trick: drag a file or folder from Finder into Terminal. macOS pastes the full path for you, which is especially helpful when names have spaces.

---

## The Treasure Hunt

Hidden inside every mission folder in `playground/` is a `.secret_code.txt` file with one secret word. Find all 12, put them in order, and you've cracked the final code.

```
Mission  1: ____          Mission  7: ____
Mission  2: ____          Mission  8: ____
Mission  3: ____          Mission  9: ____
Mission  4: ____          Mission 10: ____
Mission  5: ____          Mission 11: ____
Mission  6: ____          Mission 12: ____
```

The 12 words together form your graduation message. You'll know you've got them all when it makes sense.

## What You'll Build

| Mission | Topic | You Build |
|---------|-------|-----------|
| 1 | Open the Portal | A talking Mac greeter |
| 2 | Exploring Your World | A map of the case file maze |
| 3 | Creating & Destroying | An evidence room organizer |
| 4 | Reading & Writing | A detective's secret diary |
| 5 | Finding Things | A file detective toolkit |
| 6 | Pipes & Superpowers | A suspect database analyzer |
| 7 | Your First Script | An auto-report generator |
| 8 | Loops & Logic | A batch evidence photo renamer |
| 9 | The Internet from Terminal | A network investigation tool |
| 10 | Customize Your Terminal | Your personal command center |
| 11 | Secret Agent Tools | An encrypted message vault |
| 12 | Build Your Own App | MyBot — your personal CLI assistant |

## Hands-On Starter Code

Some missions include starter files in `playground/` so you can begin with a working scaffold instead of a blank page.

| Mini Mission | Starter File |
|--------------|--------------|
| Make folders and move files | `playground/mission_03/organize_evidence_starter.sh` |
| Create a secret text diary | `playground/mission_04/secret_diary_starter.sh` |
| Search files faster than Finder | `playground/mission_05/search_toolkit_starter.sh` |
| Make a simple shell script game | `playground/mission_07/shell_game_starter.sh` |
| Rename 100 files instantly | `playground/mission_08/bulk_rename_lab/` |
| Customize prompt colors | `playground/mission_10/prompt_colors_starter.zsh` |

## The Rhythm

Each mission follows the same rhythm, so you always know where you are:

- **Briefing** — the story and the goal
- **Case Files** — the real files you will touch
- **New Commands** — the tools for this mission
- **Step by Step** — examples with expected output
- **Starter Code** — scaffolds for bigger builds
- **Try It** — quick experiments that make the command feel real
- **Challenges** — small cases to solve on your own
- **Secret Code Hunt** — one hidden word per mission
- **Solutions** — there when you need them
- **Powers Unlocked** — the cheat sheet you can come back to later

## Getting Started

### Step 1 — You need a Mac

Any Mac made after 2015 works perfectly.

### Step 2 — Clone this repo

```bash
git clone https://github.com/yos17/mac-cli-for-kids.git
cd mac-cli-for-kids
```

### Step 3 — Open Terminal

Press **⌘ + Space**, type `Terminal`, press Enter. You'll see a blinking cursor. That's your portal.

### Step 3b — (Optional) Set up a colourful Terminal

Run the setup script to get a nice prompt and handy shortcut commands:

```bash
bash scripts/setup_terminal.sh
source ~/.zshrc
```

This adds a custom prompt (`Joanna ~/path $`) and these commands:

| Command | What it does |
|---------|-------------|
| `missions` | Jump to the playground folder |
| `briefing` | Read the case briefing for the current mission |
| `hint` | Show a random CLI tip |
| `secret` | Reveal this mission's secret code word |
| `codes` | Show secret codes you have collected with `secret` |
| `map` | Display a folder tree |
| `clue 'word'` | Colorized search through files |
| `coach start` | Start an AI Terminal coach session |

To undo it later: `bash scripts/reset_terminal.sh`

### Step 3c — (Optional) Start the AI Terminal Coach

If you have Claude Code or Codex CLI installed and logged in, Joanna can start a watched learning session:

```bash
coach doctor
coach start --provider claude
```

Or use Codex:

```bash
coach start --provider codex
```

If you did not run setup, use the repo-local command instead:

```bash
./coach start --provider claude
```

Inside a coach session, type commands normally. After each command, the coach gives short feedback. Useful controls:

| Command | What it does |
|---------|-------------|
| `coach off` | Pause feedback |
| `coach on` | Resume feedback |
| `coach status` | Show coach settings |
| `coach provider codex` | Switch to Codex |
| `coach provider claude` | Switch to Claude |
| `exit` | Leave coach mode |

The coach also adds safety prompts around commands such as `rm -rf`, `sudo`, recursive permission changes, and deletes outside the playground.

### Step 4 — Go to Mission 1

```bash
cd playground/mission_01
ls
cat welcome.txt
```

You're in. Your first case file is open.

---

## Getting Help from Claude or Codex

There are two ways to get help.

**Option 1: Use the built-in Terminal coach**

```bash
coach start --provider claude
```

or:

```bash
coach start --provider codex
```

This is the closest version to a friend watching over your shoulder. It sees the command Joanna typed, the folder she was in, and whether the command worked. It gives brief feedback without solving the whole challenge.

**Option 2: Ask Claude manually**

Claude can also look at your Terminal screen and help guide you through the missions — like a tutor sitting next to you.

**How to use it:**

1. Open Terminal and start working on your mission
2. Open the **Claude** app on your Mac
3. When you get stuck, just ask! Try saying things like:
   - *"I'm stuck on Mission 3, can you look at my Terminal?"*
   - *"What did I do wrong?"*
   - *"How do I find a hidden file?"*
4. Claude will take a screenshot of your Terminal to see exactly what you typed and what happened — then give you a hint
5. Try to figure things out yourself first! Claude will ask you questions and give hints before giving you the answer. That's how you actually learn it.

> **Tip:** If you're really stuck after trying a few times, it's totally fine to ask Claude to just show you. You can always go back and try it again on your own.

---

## Missions

| # | Mission | Chapter |
|---|---------|---------|
| 1 | Open the Portal | [chapters/01_open_the_portal](chapters/01_open_the_portal/README.md) |
| 2 | Exploring Your World | [chapters/02_exploring_your_world](chapters/02_exploring_your_world/README.md) |
| 3 | Creating & Destroying | [chapters/03_creating_and_destroying](chapters/03_creating_and_destroying/README.md) |
| 4 | Reading & Writing | [chapters/04_reading_and_writing](chapters/04_reading_and_writing/README.md) |
| 5 | Finding Things | [chapters/05_finding_things](chapters/05_finding_things/README.md) |
| 6 | Pipes & Superpowers | [chapters/06_pipes_and_superpowers](chapters/06_pipes_and_superpowers/README.md) |
| 7 | Your First Script | [chapters/07_your_first_script](chapters/07_your_first_script/README.md) |
| 8 | Loops & Logic | [chapters/08_loops_and_logic](chapters/08_loops_and_logic/README.md) |
| 9 | The Internet from Terminal | [chapters/09_the_internet_from_terminal](chapters/09_the_internet_from_terminal/README.md) |
| 10 | Customize Your Terminal | [chapters/10_customize_your_terminal](chapters/10_customize_your_terminal/README.md) |
| 11 | Secret Agent Tools | [chapters/11_secret_agent_tools](chapters/11_secret_agent_tools/README.md) |
| 12 | Build Your Own App | [chapters/12_build_your_own_app](chapters/12_build_your_own_app/README.md) |

---

*Built for curious learners who like making computers do useful things.*
