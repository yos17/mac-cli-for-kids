# Welcome to Detective Academy Playground

```
  ____  _____ _____ _____ ____ _____ _____   ____  _     _______
 |  _ \| ____|_   _| ____/ ___|_   _|_ _\ \ / /  \| |  |  ___\ \
 | | | |  _|   | | |  _|| |    | |  | | \ V /| . ` |  | |_   \ \
 | |_| | |___  | | | |__| |___ | |  | |  | | | |\ \  |  _|    ) |
 |____/|_____| |_| |_____\____|_| |_|___| |_| |_| \_| |_|    /_/

         A C A D E M Y   P L A Y G R O U N D
```

## What This Place Is

This playground is the safe zone. The files in here are meant to be explored,
renamed, searched, decoded, and occasionally messed up while you learn.

Each folder (mission_01 through mission_12) contains real files to practice
with. You'll use Terminal commands to navigate, search, read, organize, and
decode your way through 12 missions.

If you get lost, come back here:

```bash
cd ~/mac-cli-for-kids/playground
ls
```

To see this same folder in Finder:

```bash
open .
```

Anything you create here from Terminal is a normal Finder file too.

---

## The Secret Code Challenge

Hidden inside EVERY mission folder is a file called `.secret_code.txt`

Those files are invisible to casual observers (files starting with `.` are
hidden files — that's why they're called "dotfiles"). You'll need to use:

    ls -a

...to see them. The `-a` flag means "show ALL files, including hidden ones."

Each `.secret_code.txt` contains exactly ONE word. Collect all 12 words IN
ORDER (mission_01 through mission_12), combine them into a sentence, and
you've cracked the final code!

Write your findings here as you go:

    Mission 01: ___________
    Mission 02: ___________
    Mission 03: ___________
    Mission 04: ___________
    Mission 05: ___________
    Mission 06: ___________
    Mission 07: ___________
    Mission 08: ___________
    Mission 09: ___________
    Mission 10: ___________
    Mission 11: ___________
    Mission 12: ___________

    FINAL CODE: _________________________________________________

---

## Mission Overview

| Mission | Folder       | Skills You'll Practice                         |
|---------|-------------|------------------------------------------------|
| 01      | mission_01  | ls, cat, cd — basic navigation                 |
| 02      | mission_02  | cd, pwd, ls -a — deep directory exploration    |
| 03      | mission_03  | mkdir, mv — organizing files                   |
| 04      | mission_04  | cat, head, tail — reading files                |
| 05      | mission_05  | grep — searching inside files                  |
| 06      | mission_06  | sort, uniq, awk — data investigation           |
| 07      | mission_07  | bash scripts, variables, random numbers        |
| 08      | mission_08  | for loops — batch renaming                     |
| 09      | mission_09  | curl — fetching data from the internet         |
| 10      | mission_10  | aliases, .zshrc — customizing your terminal    |
| 11      | mission_11  | chmod, base64 — permissions and encoding       |
| 12      | mission_12  | scripting — building your own tools            |

---

## Starter Code

These files are safe practice scaffolds for the bigger hands-on projects:

| Skill | Starter |
|-------|---------|
| Organize files into folders | `mission_03/organize_evidence_starter.sh` |
| Write a secret text diary | `mission_04/secret_diary_starter.sh` |
| Search files quickly | `mission_05/search_toolkit_starter.sh` |
| Build a shell game | `mission_07/shell_game_starter.sh` |
| Rename 100 files | `mission_08/bulk_rename_lab/` |
| Customize prompt colors | `mission_10/prompt_colors_starter.zsh` |

Run `.sh` starter files with `bash filename.sh`.

---

## Quick Start

```bash
cd mission_01
ls
cat welcome.txt
ls -a
cat .secret_code.txt
```

Start with one folder. One command. One tiny win.
