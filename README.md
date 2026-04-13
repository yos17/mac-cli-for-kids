# Terminal Quest: Detective Academy

### Learn the Mac Command Line by Solving Mysteries

---

*Welcome to the Terminal Detective Agency! 12 unsolved cases. 12 secret code pieces. One ultimate treasure. Are you ready, Agent?*

---

## A Note from Dad

This book is for my daughter — who is already braver than she knows.

When I started writing this for you, I wanted it to feel like an adventure, because that's what learning really is. Every time you open a Terminal window, you're doing something most adults are afraid to try. That makes you a programmer. That makes you a detective.

The Terminal Detective Agency isn't just a theme I made up to make this fun (though I hope it is fun). It's actually true: the best programmers in the world are detectives. They find hidden things. They follow clues. They crack codes that no one else can crack.

Twelve missions. Twelve cases to solve. And somewhere inside each one, a hidden code piece waiting to be found.

I'm proud of you before you've even started.

*— Dad (Yosia)*

---

## What Is This Book?

Your Mac has a secret. Hidden inside it is a completely different way to control your computer — no clicking, no dragging, just you and a blinking cursor. It's called the **Terminal**, and it's where programmers, hackers, scientists, and engineers do their real work.

This book teaches you how to use it. Not the boring way. The *detective* way.

You've just been recruited to the **Terminal Detective Agency**. The Agency has 12 open cases, and you're the only agent available. Each case requires a new set of skills — and each case hides a secret code piece. Collect all 12 and you'll unlock the ultimate message that only elite Terminal detectives ever see.

---

## The Secret Code

Here's how it works: every mission contains a hidden **code piece** — a single word, waiting to be found. You unlock it by completing the mission and using the commands you've learned to discover where it's hidden.

Collect all 12 code pieces in order and they form a secret message. What does it say? That's for you to find out.

Your code pieces so far:

| Mission | Code Piece |
|---------|------------|
| 1 | ??? |
| 2 | ??? |
| 3 | ??? |
| 4 | ??? |
| 5 | ??? |
| 6 | ??? |
| 7 | ??? |
| 8 | ??? |
| 9 | ??? |
| 10 | ??? |
| 11 | ??? |
| 12 | ??? |

Every locked piece turns into a real word when you complete the mission. Keep track of them here.

---

## Case Files

| # | Case Name | Commands | Code Piece |
|---|-----------|----------|------------|
| 1 | The Talking Computer | echo, date, say, whoami | locked |
| 2 | The Lost Files | ls, cd, pwd | locked |
| 3 | The Messy Crime Scene | mkdir, mv, cp, rm | locked |
| 4 | The Secret Diary | cat, less, head, tail, > | locked |
| 5 | The Missing Witness | find, grep, mdfind | locked |
| 6 | The Code Breaker | pipes, sort, uniq, cut, wc | locked |
| 7 | The Automation Agent | shell scripts, variables, chmod | locked |
| 8 | The Pattern Hunter | for loops, while, if/else | locked |
| 9 | The Digital Spy | ping, curl, HTTP | locked |
| 10 | Your Secret Lair | .zshrc, aliases, PATH | locked |
| 11 | Top Secret | chmod, permissions, base64 | locked |
| 12 | The Grand Finale | full CLI app (MyBot) | locked |

---

## Getting Started

You need a Mac. Any Mac made after 2015 will work perfectly. No installation required. No extra software. Just a Terminal window and you.

**Step 1: Open Terminal**

- Press `Cmd + Space` to open Spotlight
- Type `Terminal`
- Press Enter

You'll see a window with a blinking cursor. That's your portal to the Agency.

**Step 2: Get the case files**

```bash
# Clone the repository
git clone https://github.com/[repo]/mac-cli-for-kids.git
cd mac-cli-for-kids

# Open your first case
cd playground/mission_01
cat welcome.txt
```

That's it. No setup. No installation. Just start solving cases.

---

## How the Playground Works

Every mission comes with a **playground folder** — a collection of real files to investigate, evidence to examine, and puzzles to crack. Think of them as your crime scene.

```
terminal-quest/
├── README.md                   ← You are here
├── playground/                 ← Your case files (download & explore!)
│   ├── mission_01/             ← The Talking Computer
│   ├── mission_02/             ← The Lost Files
│   ├── mission_03/             ← The Messy Crime Scene
│   └── ... (all 12 missions)
└── chapters/                   ← Your mission guides
    ├── 01_open_the_portal/
    ├── 02_exploring_your_world/
    └── ... (all 12 chapters)
```

The playground files are yours to experiment with. You can't break anything permanently. Be fearless.

---

## How Each Mission Works

Every case follows the same structure:

- **Mission Briefing** — the detective story behind your case. Why this matters and what you're up against.
- **Detective Training** — the new commands you'll learn. Every command shown with its real output.
- **Field Work** — quick experiments using your playground files. Get your hands dirty.
- **The Mission** — the main project to complete. This is where you crack the case.
- **Bonus Missions** — extra challenges for when you want to go deeper.
- **Code Piece Unlocked** — find the hidden word using what you've learned. Add it to your collection.

---

## Who This Is For

- Kids around age 12 (or any curious person)
- No prior experience with the command line
- A Mac running macOS Catalina or later (which uses zsh — that's the shell you'll be typing in)
- A willingness to experiment and not be afraid of a blinking cursor

Every command is explained. Every output is shown. There are no dumb questions in the Terminal Detective Agency.

---

## Your First Command as an Agent

Open your Terminal right now and type this:

```bash
echo "I am Agent [YourName], and I'm ready for my first mission!"
```

Replace `[YourName]` with your actual name. Hit Enter.

The Terminal will repeat your message back to you. You just gave a computer an instruction and it obeyed. That's how every great detective story begins.

---

## The Case Files

- [Case 1 — The Talking Computer](chapters/01_open_the_portal/README.md)
- [Case 2 — The Lost Files](chapters/02_exploring_your_world/README.md)
- [Case 3 — The Messy Crime Scene](chapters/03_creating_and_destroying/README.md)
- [Case 4 — The Secret Diary](chapters/04_reading_and_writing/README.md)
- [Case 5 — The Missing Witness](chapters/05_finding_things/README.md)
- [Case 6 — The Code Breaker](chapters/06_pipes_and_superpowers/README.md)
- [Case 7 — The Automation Agent](chapters/07_your_first_script/README.md)
- [Case 8 — The Pattern Hunter](chapters/08_loops_and_logic/README.md)
- [Case 9 — The Digital Spy](chapters/09_the_internet_from_terminal/README.md)
- [Case 10 — Your Secret Lair](chapters/10_customize_your_terminal/README.md)
- [Case 11 — Top Secret](chapters/11_secret_agent_tools/README.md)
- [Case 12 — The Grand Finale](chapters/12_build_your_own_app/README.md)

---

*Written with love by Yosia, for his favorite person. Go solve something.*
