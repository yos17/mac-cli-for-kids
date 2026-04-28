# Terminal Quest: Detective Academy

### A mission-based Terminal adventure for curious kids

---

*This book is for anyone who is already braver than they know. Every time you open a Terminal window, you're doing something most adults are afraid to try. That makes you a detective.*

*— Yosia*

---

## Welcome to Detective Academy

Your Mac has a secret. Hidden inside it is a completely different way to control your computer — no clicking, no dragging, just you and a blinking cursor. It's called the **Terminal**, and it's where programmers, hackers, scientists, and engineers do their real work.

This book teaches you how to use it. Not the boring way. The *mission* way.

You are a recruit at the **Terminal Detective Academy**. Each chapter is a **Mission** — briefed by Commander Chen, equipped with new tools, and sent into a real folder full of case files, clues, and puzzles. At the end of all 12 missions, you'll unlock the final secret message.

---

## How Setup Works

There are three parts to this project. Here's what each one does — and what it touches on your computer.

**`CLAUDE.md` — project-only, no side effects**
This file tells Claude how to help Joanna when she asks questions. It only applies when Claude is working inside this folder. Other projects are completely unaffected.

**`scripts/setup_terminal.sh` — modifies your global Terminal config**
Running this script adds a block to `~/.zshrc`, which is the configuration file loaded every time you open a Terminal window. This means the prompt, aliases, and shortcut commands (`missions`, `hint`, `secret`, etc.) will appear in **all** Terminal windows — not just inside this project. This is intentional: Joanna should be able to type `missions` from anywhere and jump straight to the playground.

When Joanna uses `secret`, the setup also records collected code words in `~/.terminal_quest_codes` so `codes` only shows words she has actually found.

To undo everything: `bash scripts/reset_terminal.sh` restores your original `.zshrc` from a backup taken before setup ran and removes the local code collection.

**`playground/` — fully self-contained**
The mission folders, case files, and puzzle files all live inside this project directory. Nothing is installed system-wide. Deleting the repo removes them completely.

---

## Special Keys on Mac

The Terminal uses characters that can be hard to find, especially on a German keyboard. Here's where to find the important ones:

| Character | What it does | US Keyboard | German Keyboard |
|-----------|-------------|-------------|-----------------|
| `\|` (pipe) | Sends output to another command | Shift + `\` | Option + 7 |
| `~` (tilde) | Means "your home folder" | Shift + `` ` `` | Option + N, then Space |
| `\` (backslash) | Escape character | `\` key | Shift + Option + 7 |
| `[` and `]` | Used in scripts | `[` and `]` keys | Option + 5 / Option + 6 |
| `{` and `}` | Used in scripts | Shift + `[` / `]` | Option + 8 / Option + 9 |
| `@` | Used in email/variables | Shift + 2 | Option + L |
| `#` | Starts a comment in scripts | Shift + 3 | Option + 3 |

> **German keyboard tip:** The pipe character `|` (Option + 7) is used constantly in Mission 6. Practise finding it before you get there.

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

## How Each Mission Works

- **Mission Briefing** — Commander Chen gives you your assignment
- **Your Case Files** — the real playground files you'll investigate
- **New Commands** — the tools issued for this mission
- **Step by Step** — every command shown with its exact output
- **Starter Code** — small scaffold files for bigger projects
- **Try It!** — quick experiments to run right now
- **Your Mission** — the main program to build
- **Challenges** — 3–4 real cases to crack using playground files
- **🔍 Secret Code Hunt** — find the hidden `.secret_code.txt`
- **Solutions** — answers in the `solutions/` folder
- **Powers Unlocked** — your command cheat sheet

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

To undo it later: `bash scripts/reset_terminal.sh`

### Step 4 — Go to Mission 1

```bash
cd playground/mission_01
ls
cat welcome.txt
```

You're in. Your first case file is open. Let's go.

---

## Getting Help from Claude

Claude can look at your Terminal screen and help guide you through the missions — like a tutor sitting next to you.

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

*Written with love by Yosia, for his favorite person.*
