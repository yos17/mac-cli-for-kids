# Mission 2 — The Lost Files

## Mission Briefing

*A new message from Director Chen: "Evidence has been scattered through the old TDA office building. The building has multiple floors and locked rooms. Navigate through it and recover all three clues — and the treasure map hidden in the vault."*

Every detective needs to navigate. In Finder, you can only see what's in front of you. In Terminal, you can see *everything* — where you are, what's around you, and jump anywhere instantly.

The old TDA office building is waiting in `playground/mission_02/`. It's a maze of nested folders. Your job: explore every room.

### What You'll Learn
- `pwd` — where am I right now?
- `ls` — what's here?
- `cd` — move to a different place
- How Mac's file system is organized like a building
- How to navigate deep nested folders

---

## Understanding the Map

Your Mac's files are organized like a building. Everything starts from the **root** — written as `/`. From there, floors and rooms branch out:

```
/                          ← root (the lobby)
├── Users/
│   └── sophia/            ← YOUR home folder (~)
│       ├── Desktop/
│       ├── Documents/
│       ├── Downloads/
│       └── playground/
│           └── mission_02/
│               └── office/    ← the TDA building!
├── Applications/
└── System/
```

Your **home folder** is the most important place. The terminal shortcut for it is `~` (tilde, top-left of keyboard).

---

## The Three Navigation Commands

### `pwd` — Print Working Directory

"Where am I right now?"

```bash
pwd
```

Output:
```
/Users/sophia
```

---

### `ls` — List

"What's in this folder?"

```bash
ls
```

Show more detail:

```bash
ls -l
```

Show hidden files too:

```bash
ls -la
```

The `-a` flag shows files starting with `.` — these are hidden.

---

### `cd` — Change Directory

"Move to a different folder."

```bash
cd Documents
pwd
```

Go back up one level:
```bash
cd ..
```

`..` always means "the folder above me."

Go home from anywhere:
```bash
cd ~
```

Or just:
```bash
cd
```

---

## Shortcuts and Tricks

### Tab Completion — Your Typing Superpower

Start typing a folder name and press **Tab**:

```bash
cd Doc[TAB]
```

It auto-completes to `Documents`! If multiple matches, press Tab twice.

### Absolute vs Relative Paths

**Absolute path** — starts from root `/`:
```bash
cd /Users/sophia/Documents
```
Works from anywhere.

**Relative path** — starts from where you are:
```bash
cd Documents
```
Only works if you're already in your home folder.

---

## Try It! — Quick Experiments

**Experiment 1:** Get lost and find your way home.

```bash
cd /Applications
pwd
ls
cd ~
pwd
```

**Experiment 2:** Look into a folder without entering it.

```bash
ls ~/Desktop
ls ~/Downloads
```

**Experiment 3:** Go up two levels at once.

```bash
cd ~/Downloads
cd ../..
pwd
```

**Experiment 4:** Start exploring the TDA building!

```bash
cd playground/mission_02
ls
cat case_briefing.txt
```

---

## Pro Tip — `ls` Colors

Your terminal can show folders in one color and files in another:

```bash
ls -G
```

In Mission 10 you'll set this as the permanent default.

---

## Your Mission — Navigate the TDA Office Building

The agency has hidden evidence through the office building. Recover it all.

**Step 1:** Read the case briefing:
```bash
cd playground/mission_02
cat case_briefing.txt
```

**Step 2:** Enter the building:
```bash
cd office
ls
```

**Step 3:** Navigate to Room 1 and read the clue:
```bash
cd hallway/room1
cat clue1.txt
```

**Step 4:** Go to Room 2 (it's right next to Room 1):
```bash
cd ../room2
cat clue2.txt
```

**Step 5:** Head to the basement:
```bash
cd ../../basement
cat clue3.txt
ls
```

**Step 6:** Go all the way to the vault:
```bash
cd vault/locked
cat treasure_map.txt
```

**Step 7:** Come back home and find the secret code:
```bash
cd ~
cd playground/mission_02
ls -la
cat .secret_code.txt
```

**Bonus — Draw a map of your journey using echo:**
```bash
echo "MAP OF THE TDA OFFICE BUILDING"
echo "================================"
echo "office/"
echo "├── hallway/"
echo "│   ├── room1/    ← clue1.txt found here"
echo "│   └── room2/    ← clue2.txt found here"
echo "└── basement/"
echo "    ├── clue3.txt ← found here"
echo "    └── vault/"
echo "        └── locked/"
echo "            └── treasure_map.txt ← RECOVERED!"
```

---

## Challenges

### Challenge 1 — The Deep Dive

Starting from your home folder, navigate to `playground/mission_02/office/basement/vault/locked/` in ONE command using the full relative path. Then use `pwd` to verify where you are.

**Hint:** `cd playground/mission_02/office/basement/vault/locked`

### Challenge 2 — The Speed Tour

Without leaving your home folder (no `cd`), use `ls` to peek inside each of these locations:
- `playground/mission_02/office/hallway/room1/`
- `playground/mission_02/office/basement/`
- `playground/mission_02/office/basement/vault/locked/`

**Hint:** `ls playground/mission_02/office/hallway/room1/` works without moving.

### Challenge 3 — Count the Files

How many items are in `playground/mission_02/office/hallway/`?

```bash
ls playground/mission_02/office/hallway/ | grep -c "."
```

### Challenge 4 — The Hidden World

Show all hidden files in `playground/mission_02/`:

```bash
ls -la playground/mission_02/
```

How many hidden files can you find? What do they start with?

---

## Solutions

Solutions are in the [solutions folder](solutions/README.md).

---

## Powers Unlocked

| Command | What It Does |
|---------|-------------|
| `pwd` | Shows your current folder |
| `ls` | Lists files and folders |
| `ls -l` | Lists with details |
| `ls -la` | Lists everything including hidden files |
| `ls path/` | Lists contents of a specific folder |
| `cd foldername` | Move into a folder |
| `cd ..` | Go up one level |
| `cd ~` | Go to your home folder from anywhere |
| `cd /absolute/path` | Go to an exact location |

### Vocabulary

- **Directory** — another word for folder
- **Current directory** — the folder you're "inside" right now
- **Home folder** — your personal folder, shortcut: `~`
- **Root** — the very top of the file system: `/`
- **Absolute path** — a path starting from `/`
- **Relative path** — a path starting from where you are now
- **Tab completion** — pressing Tab to auto-complete names

---

*You navigated the building. Found the clues. Recovered the map. That's detective work.*

*Ready for Mission 3?*
