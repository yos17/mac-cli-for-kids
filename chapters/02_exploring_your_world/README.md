# CASE FILE #2 — The Lost Files
**Terminal Detective Agency | Clearance Level: Cadet**

---

## 🔍 MISSION BRIEFING

Agent, we have a problem.

Last night, someone broke into Terminal Detective Agency headquarters. They didn't steal anything obvious — but they scattered our case files throughout the office. Clues are hidden on desks, inside drawers, buried in the archive room. Somewhere deep in the filing system, a treasure map is waiting to be found. We need it recovered before the trail goes cold.

Here's the tricky part: our surveillance footage shows the intruder hid files **four levels deep** in the office maze. That means you can't just look around the entrance — you have to navigate folder by folder, level by level, until you reach the innermost room. Only then will you find what we're looking for.

Your mission: use the Agency's navigation tools to explore the office, recover all three hidden clues, and retrieve the treasure map from its secret location deep inside the filing system.

**Your tools:** `pwd`, `ls`, `cd`, absolute paths, relative paths, tab completion
**Access your case files:** `cd playground/mission_02`

---

## 📚 DETECTIVE TRAINING: Understanding the Map

Before you go in, you need to understand how the office is laid out — and how *all* file systems work.

Your Mac's files are organized like a tree. Everything starts from the **root** — written as `/` (a single forward slash). From there, branches spread out:

```
/                          ← root (the trunk of the tree)
├── Users/
│   └── sophia/            ← YOUR home folder (~)
│       ├── Desktop/
│       ├── Documents/
│       ├── Downloads/
│       ├── Pictures/
│       ├── Music/
│       └── Movies/
├── Applications/
├── System/
└── Library/
```

Your **home folder** is your base of operations. It's where all your personal files live. The Terminal shortcut for it is `~` (the tilde character — top-left of your keyboard). Think of it as Agency HQ.

The mission's office maze is inside `playground/mission_02/office/`. It looks like this:

```
playground/mission_02/
├── README.txt
├── office/
│   ├── clue1.txt
│   ├── desk/
│   │   ├── clue2.txt
│   │   └── drawer/
│   │       └── secret/
│   │           ├── treasure_map.txt
│   │           └── secret_code_piece.txt
└── archive/
    └── clue3.txt
```

Your job is to navigate to every one of those rooms and find what's inside.

---

## 📚 DETECTIVE TRAINING: The Three Navigation Commands

### `pwd` — Print Working Directory (Where Am I?)

When you're deep in a file system maze, it's easy to lose track of where you are. `pwd` tells you your exact location:

```bash
pwd
```

Output:
```
/Users/sophia
```

This is your **current directory** (directory = folder). The Terminal is always "inside" some folder, like a detective standing in a specific room. `pwd` tells you which room.

---

### `ls` — List (What's in This Room?)

```bash
ls
```

Output:
```
Desktop    Documents  Downloads  Library    Movies
Music      Pictures   Public
```

Those are all the folders in your home folder! Try with more detail:

```bash
ls -l
```

Output:
```
total 0
drwx------+  3 sophia  staff    96 Apr 13 09:00 Desktop
drwx------+  3 sophia  staff    96 Apr 10 14:22 Documents
drwx------+  6 sophia  staff   192 Apr 12 16:45 Downloads
drwx------@ 78 sophia  staff  2496 Apr  1 11:30 Library
drwx------+  3 sophia  staff    96 Mar 15 08:11 Movies
drwx------+  3 sophia  staff    96 Mar 15 08:11 Music
drwx------+  4 sophia  staff   128 Apr  8 19:22 Pictures
drwxr-xr-x+  4 sophia  staff   128 Mar 15 08:11 Public
```

The `-l` flag means "long format" — it shows extra info like file size and the date it was last modified. Perfect for checking when evidence was last touched.

See hidden files too:

```bash
ls -la
```

The `-a` flag means "all" — it reveals hidden files (files starting with `.` are hidden by default):

```
drwxr-xr-x+  28 sophia  staff   896 Apr 13 10:22 .
drwxr-xr-x    6 root    wheel   192 Mar 15 08:11 ..
-rw-r--r--    1 sophia  staff  1872 Apr 10 09:45 .zshrc
-rw-r--r--    1 sophia  staff   180 Mar 15 08:12 .zprofile
drwx------+   3 sophia  staff    96 Apr 13 09:00 Desktop
...
```

The `.` means "this folder itself" and `..` means "the folder one level above this one." Hidden files are where the Agency stores its most sensitive configurations.

---

### `cd` — Change Directory (Move to a Different Room)

```bash
cd Documents
```

Now check where you are:
```bash
pwd
```
Output:
```
/Users/sophia/Documents
```

You moved! Go back up one level:
```bash
cd ..
```

`..` always means "go up to the folder above me." Check again:
```bash
pwd
```
Output:
```
/Users/sophia
```

Return to Agency HQ from anywhere on the system:
```bash
cd ~
```

Or just:
```bash
cd
```

(Just typing `cd` with nothing after it always takes you home — every detective's escape hatch.)

---

## 📚 DETECTIVE TRAINING: Shortcuts and Tactics

### Tab Completion — Your Typing Superpower

Field agents don't have time to type long folder names in full. Start typing a name and press **Tab**:

```bash
cd Doc[TAB]
```

It auto-completes to `Documents`! If there are multiple matches, press Tab twice to see all options.

Tab completion works for file names too. Use it constantly — it saves time and prevents typos. A single typo in a folder path can send you to the wrong room entirely.

### Paths — Absolute vs Relative

There are two ways to tell the Terminal where to go:

**Absolute path** — starts from the root `/`, works from anywhere:
```bash
cd /Users/sophia/Documents
```

**Relative path** — starts from where you are right now:
```bash
cd Documents
```

This only works if you're already in your home folder.

Think of it like giving directions: "Go to 123 Main Street, Springfield" (absolute — works from anywhere) versus "Turn left at the corner" (relative — only makes sense if you know where you're currently standing).

---

## 🧪 FIELD WORK

Time to investigate the actual crime scene. Navigate to your case files:

```bash
cd playground/mission_02
```

**Experiment 1:** Survey the scene. What's at the top level of the office?

```bash
ls
```

You should see the `office/` folder and the `archive/` folder. Read the briefing file:

```bash
cat README.txt
```

**Experiment 2:** Enter the office and look for the first clue.

```bash
cd office
ls
```

What do you find? Read any clue files you discover:

```bash
cat clue1.txt
```

**Experiment 3:** Go deeper — check the desk.

```bash
cd desk
ls
```

Read what you find. Then confirm where you are in the building:

```bash
pwd
```

**Experiment 4:** Go back to the top of the mission folder, then explore the archive through a different route — without using `cd` to move there first.

```bash
cd ~/playground/mission_02
ls archive/
```

You can `ls` any folder without physically moving into it by putting the path after `ls`. Useful for scouting ahead.

**Experiment 5:** Travel up two levels at once.

```bash
cd ~/playground/mission_02/office/desk
pwd
cd ../..
pwd
```

`../..` means "go up one level, then up again." Where did you end up?

**Experiment 6:** Use `ls` to survey the entire top of your Mac's file system.

```bash
ls /
```

Output:
```
Applications  Library  System  Users  Volumes  bin  etc  home  opt  private  sbin  tmp  usr  var
```

These are ALL the top-level folders on your Mac. Most are system files — the Agency keeps them off-limits for now.

---

## 💡 PRO TIP — `ls` Colors

Your Terminal might already show folders in one color and files in another. If not, you can enable colors:

```bash
ls -G
```

The `-G` flag turns on color output. In Mission 10, you'll set this as your permanent default so you never have to type `-G` again. Color-coded maps make navigation much faster.

---

## 🎯 MISSION: Navigate the Office and Recover All Clues

You have the skills. Now execute the mission.

**Step 1:** Go to the mission playground.

```bash
cd playground/mission_02
ls
```

**Step 2:** Find Clue #1 — it's in the office entrance.

```bash
cd office
cat clue1.txt
```

**Step 3:** Find Clue #2 — it's on the desk.

```bash
cd desk
cat clue2.txt
```

**Step 4:** Find Clue #3 — it's in the archive. Navigate back and then into the archive:

```bash
cd ~/playground/mission_02/archive
cat clue3.txt
```

**Step 5:** The treasure map is buried four levels deep. Use your navigation skills to reach it:

```bash
cd ~/playground/mission_02/office/desk/drawer/secret
ls
cat treasure_map.txt
```

**Step 6:** Draw your own map of the evidence you recovered! Replace what you find with actual clue contents:

```bash
echo "============================================"
echo "    OFFICE INVESTIGATION MAP                "
echo "    Terminal Detective Agency               "
echo "============================================"
echo ""
echo "playground/mission_02/          ← Entry point"
echo "|"
echo "+-- office/"
echo "|   +-- clue1.txt               ← RECOVERED"
echo "|   +-- desk/"
echo "|       +-- clue2.txt           ← RECOVERED"
echo "|       +-- drawer/"
echo "|           +-- secret/"
echo "|               +-- treasure_map.txt  ← FOUND"
echo "|"
echo "+-- archive/"
echo "    +-- clue3.txt               ← RECOVERED"
echo ""
echo "Total items recovered:"
ls ~/playground/mission_02/office ~/playground/mission_02/archive | wc -l
```

The last line uses `wc -l` to count lines (we'll learn more about that in Mission 6). It tells you how many items you found.

---

## 🏆 BONUS MISSIONS

### Bonus Mission 1 — The Deep Dive

Navigate into the deepest folder you can find anywhere on your Mac (keep using `cd foldername` to go deeper). Then use `pwd` to show exactly where you ended up. Then come back to Agency HQ in one single command.

**Hint:** Remember `cd ~` takes you home from anywhere, no matter how lost you are.

### Bonus Mission 2 — The Speed Reconnaissance

Without leaving your home folder (no `cd`), use `ls` to peek inside each of these locations:
- Desktop
- Documents
- Downloads
- Pictures

**Hint:** `ls ~/Desktop` works without you having to physically move there first.

### Bonus Mission 3 — Count the Evidence

How many items are in your Downloads folder?

```bash
ls ~/Downloads | wc -l
```

That `|` (pipe) and `wc -l` is a preview of Mission 6. `wc -l` counts lines — so this counts how many things `ls` printed. Can you find which folder in your home directory has the MOST items?

### Bonus Mission 4 — The Hidden Files Investigation

Show all hidden files in your home folder:

```bash
ls -la ~ | grep "^\."
```

Write down at least 3 hidden files you find. What do you think `.zshrc` might be for? (You'll open it in Mission 10 and customize it yourself!)

---

## Solutions

Solutions are in the [solutions folder](solutions/README.md).

---

## 🔐 CODE PIECE UNLOCKED!

You navigated a four-level maze and recovered the Agency's treasure map. Outstanding fieldwork.

**Code Piece #2: ARE**

Your code piece is waiting in the deepest room of the office. Navigate there to claim it:

```bash
cat playground/mission_02/office/desk/drawer/secret/secret_code_piece.txt
```

Write it down alongside Code Piece #1. The full message will reveal itself at the end of your training.

---

## ⚡ POWERS UNLOCKED

| Command | What It Does |
|---------|-------------|
| `pwd` | Shows your current folder location (Print Working Directory) |
| `ls` | Lists files and folders in the current directory |
| `ls -l` | Lists with full details (size, date, permissions) |
| `ls -la` | Lists everything including hidden files |
| `ls path/` | Lists contents of a specific folder without moving there |
| `cd foldername` | Move into a folder |
| `cd ..` | Go up one level |
| `cd ~` | Go to your home folder (Agency HQ) from anywhere |
| `cd /absolute/path` | Go to an exact location anywhere on your Mac |
| `cd ../..` | Go up two levels at once |

### Vocabulary

- **Directory** — another word for folder
- **Current directory** — the folder you're "inside" right now
- **Home folder** — your personal folder, shortcut: `~`
- **Root** — the very top of the file system: `/`
- **Absolute path** — a path starting from `/`, works from anywhere
- **Relative path** — a path starting from where you currently are
- **Tab completion** — pressing Tab to auto-complete file and folder names

---

*All clues recovered. Map secured. The maze didn't stop you, Agent.*

*Report to Case File #3 when you're ready.*
