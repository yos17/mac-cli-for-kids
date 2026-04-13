# Terminal Quest: Detective Academy

### A 12-mission mystery adventure for curious kids — written by Dad, for you

---

*This book is for my daughter — who is already braver than she knows. Every time you open a Terminal window, you're doing something most adults are afraid to try. That makes you a programmer.*

*— Dad (Yosia)*

---

## What Is This?

Your Mac has a secret. Hidden inside it is a completely different way to control your computer — no clicking, no dragging, just you and a blinking cursor. It's called the **Terminal**, and it's where programmers, hackers, scientists, and engineers do their real work.

This is a **detective adventure**. You've been recruited by the Terminal Detective Agency. Twelve missions stand between you and the title of *Master Terminal Detective*. Each mission teaches you real commands and hides a secret code word.

Collect all 12 code words. Decode the final message. Earn your badge.

## How to Start

You only need two things:
1. A Mac
2. Terminal (press `Cmd + Space`, type `Terminal`, press Enter)

Clone this repo to get all your mission files:
```bash
git clone https://github.com/your-username/mac-cli-for-kids.git
cd mac-cli-for-kids
ls playground/
```

Every mission has a folder in `playground/` packed with files to explore, clues to find, and secrets to uncover. Just start Mission 1 and follow the story.

## The 12 Missions

| Mission | Case Name | You Learn |
|---------|-----------|-----------|
| 1 | The Talking Computer | `whoami`, `date`, `echo`, `say`, `clear` |
| 2 | The Lost Files | `pwd`, `ls`, `cd`, navigation |
| 3 | The Messy Crime Scene | `mkdir`, `touch`, `cp`, `mv`, `rm` |
| 4 | The Secret Diary | `cat`, `less`, `head`, `tail`, `>`, `>>` |
| 5 | The Missing Witness | `find`, `grep`, `mdfind` |
| 6 | The Code Breaker | pipes, `sort`, `uniq`, `wc`, `cut` |
| 7 | The Automation Agent | scripts, variables, `chmod +x` |
| 8 | The Pattern Hunter | `for` loops, `if/else`, `while` |
| 9 | The Digital Spy | `ping`, `curl`, `open`, `caffeinate` |
| 10 | Your Secret Lair | `.zshrc`, aliases, custom prompt |
| 11 | Top Secret | permissions, `chmod`, `openssl`, `base64` |
| 12 | The Grand Finale | MyBot — your own CLI app |

## The Hidden Mystery

Each mission hides a secret code piece in a `.secret_code.txt` file. Hidden files start with a dot — they're invisible to plain `ls`, but revealed by `ls -la`.

Collect all 12 pieces. Assemble them in order. Decode the final message.

```bash
# Quick way to find all your collected codes:
grep "Code word:" playground/mission_*/.secret_code.txt
```

## How Each Mission Works

Every mission has:

- **Mission Briefing** — the detective story setup
- **New Commands** — the tools you'll learn
- **Try It!** — quick experiments using the playground files
- **Your Mission** — the main investigation using real playground files
- **Challenges** — extra things to try on your own
- **Solutions** — answers in the `solutions/` folder
- **Powers Unlocked** — summary of everything you learned

## The Playground

The `playground/` directory has mission files ready to explore the moment you clone:

```
playground/
├── mission_01/      ← welcome letter, agents roster, hidden code
├── mission_02/      ← a maze of nested folders with clues and a treasure map
├── mission_03/      ← 20 messy crime scene files to organize
├── mission_04/      ← a detective's diary + suspects + encoded clue
├── mission_05/      ← 30+ files hiding one witness name
├── mission_06/      ← access logs, suspect database, word lists
├── mission_07/      ← case assignment template + names + case numbers
├── mission_08/      ← 20 mixed photos to batch-sort with loops
├── mission_09/      ← safe URLs and a network log to analyze
├── mission_10/      ← sample .zshrc and cool aliases to borrow
├── mission_11/      ← encrypted messages + a locked permissions puzzle
└── mission_12/      ← MyBot starter script + the final encoded message
```

---

## Missions

- [Mission 1 — The Talking Computer](chapters/01_open_the_portal/README.md)
- [Mission 2 — The Lost Files](chapters/02_exploring_your_world/README.md)
- [Mission 3 — The Messy Crime Scene](chapters/03_creating_and_destroying/README.md)
- [Mission 4 — The Secret Diary](chapters/04_reading_and_writing/README.md)
- [Mission 5 — The Missing Witness](chapters/05_finding_things/README.md)
- [Mission 6 — The Code Breaker](chapters/06_pipes_and_superpowers/README.md)
- [Mission 7 — The Automation Agent](chapters/07_your_first_script/README.md)
- [Mission 8 — The Pattern Hunter](chapters/08_loops_and_logic/README.md)
- [Mission 9 — The Digital Spy](chapters/09_the_internet_from_terminal/README.md)
- [Mission 10 — Your Secret Lair](chapters/10_customize_your_terminal/README.md)
- [Mission 11 — Top Secret](chapters/11_secret_agent_tools/README.md)
- [Mission 12 — The Grand Finale](chapters/12_build_your_own_app/README.md)

---

*Written with love by Yosia, for his favorite person.*
