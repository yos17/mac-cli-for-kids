# Mission 2 — Exploring Your World

## Mission Briefing

_Briefing note_

> "Agent, your first mission opened the portal. Now you learn how to move around without getting lost. Your Mac's file system is a maze of folders within folders — like a building with rooms, hallways, and hidden basement vaults. Three commands will be your map: know where you are, see what's around you, and move to a new place."

Every video game has a map. In Minecraft, you explore a world made of blocks. In Zelda, you explore dungeons and overworld. Your Mac's file system is exactly like that — a world full of folders (rooms) and files (evidence). The difference is that in Finder, you can only see what's right in front of you. In Terminal, you can see *everything* — where you are, what's around you, and jump to any location instantly with a single command.

Today you learn to navigate your Mac like a pro detective casing a building.

### What You'll Learn
- `pwd` — where am I right now?
- `ls` — what's here?
- `cd` — move to a different place
- `open .` — show the current Terminal folder in Finder
- How Mac's file system is organized
- How to explore a multi-level folder maze

---

## Finder and Terminal: Same Folders, Two Views

Before you go deeper, connect Terminal to what you already know.

Finder is the visual map. Terminal is the typed map. They are not two different worlds.

Try this:

```bash
pwd
open .
```

`pwd` prints your current folder path. `open .` opens that same folder in Finder.

Now make Finder show paths too:

1. Open Finder.
2. Choose **View > Show Path Bar**.
3. Click through folders and watch the path at the bottom.

That Finder path is the same kind of path Terminal uses with `cd`.

One more useful trick: drag any Finder folder into Terminal. macOS pastes the full folder path automatically. This is great when a folder name has spaces.

---

## Your Case Files

Commander Chen has set up a training maze for you to navigate. Head there now:

```bash
cd ~/mac-cli-for-kids/playground/mission_02
ls
```

You should see:

```
case_briefing.txt   clue1.txt   clue2.txt   clue3.txt   office/
```

The `office/` folder is a full building with rooms, a hallway, and a locked basement vault. Your clue files are scattered throughout. Here's the full layout of what's hidden inside:

```
mission_02/
├── case_briefing.txt
├── clue1.txt
├── clue2.txt
├── clue3.txt
├── office/
│   ├── hallway/
│   │   └── room1/
│   │       └── desk.txt
│   └── basement/
│       └── vault/
│           └── locked/
│               ├── treasure_map.txt
│               └── access_denied.txt
└── .secret_code.txt   (hidden!)
```

Your mission: navigate every level of this maze using the three commands you're about to learn.

---

## Understanding the Map

Your Mac's files are organized like a tree. Everything starts from the **root** — written as `/` (a single forward slash). From there, branches go out:

```
/                          <- root (the trunk of the tree)
├── Users/
│   └── sophia/            <- YOUR home folder (~)
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

Your **home folder** is the most important place. It's where all your personal files live. The terminal shortcut for it is `~` (the tilde character, top-left of your keyboard).

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

This is your **current directory** (directory = folder). The terminal is always "inside" some folder, just like how Finder always has a window open somewhere. A detective always knows their current location.

---

### `ls` — List

"What's in this folder?"

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

The `-l` flag means "long format" — it shows extra info like file size and the date it was last changed.

See hidden files too:

```bash
ls -la
```

The `-a` flag means "all" — it shows hidden files (files starting with `.` are hidden):

```
drwxr-xr-x+  28 sophia  staff   896 Apr 13 10:22 .
drwxr-xr-x    6 root    wheel   192 Mar 15 08:11 ..
-rw-r--r--    1 sophia  staff  1872 Apr 10 09:45 .zshrc
-rw-r--r--    1 sophia  staff   180 Mar 15 08:12 .zprofile
drwx------+   3 sophia  staff    96 Apr 13 09:00 Desktop
...
```

The `.` means "this folder itself" and `..` means "the folder above this one."

---

### `cd` — Change Directory

"Move to a different folder."

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

`..` always means "the folder above me." Check again:
```bash
pwd
```
Output:
```
/Users/sophia
```

Go home from anywhere:
```bash
cd ~
```

Or just:
```bash
cd
```

(Just typing `cd` with nothing after it always takes you home.)

---

## Shortcuts and Tricks

### Tab Completion — Your Typing Superpower

Start typing a folder name and press **Tab**:

```bash
cd Doc[TAB]
```

It auto-completes to `Documents`! If there are multiple matches, press Tab twice to see them all.

Tab completion works for file names too. Use it constantly — it saves time and prevents typos.

If a name has spaces, Tab completion also adds the escaping for you:

```bash
cd My[TAB]
```

If the folder is called `My Case Files`, Terminal can complete it as:

```bash
cd My\ Case\ Files
```

The backslashes tell Terminal that the spaces are part of the folder name.

### Drag From Finder

Finder can help when a path is long. Drag any folder from Finder into Terminal and macOS pastes the full path.

Try this:

1. Open Finder.
2. In Terminal, type `cd ` with a space after it.
3. Drag your `mission_02` folder into Terminal.
4. Press Enter after you understand what appeared.

Terminal turns the dragged folder into a full path:

```bash
cd /Users/sophia/mac-cli-for-kids/playground/mission_02
```

Use your own path, not Sophia's.

### Paths — Absolute vs Relative

There are two ways to specify a location:

**Absolute path** — starts from the root `/`:
```bash
cd /Users/sophia/Documents
```
This works from anywhere.

**Relative path** — starts from where you are now:
```bash
cd Documents
```
This only works if you're already in your home folder.

Think of it like giving directions: "Go to 123 Main Street" (absolute — works no matter where you're standing) vs "Turn left at the corner" (relative — only makes sense if you know where you're starting from).

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

You traveled to the Applications folder, looked around, and came back home.

**Experiment 2:** Go up two levels at once.

```bash
cd ~/Downloads
pwd
cd ../..
pwd
```

`../..` means "go up one level, then up again." Where did you end up?

**Experiment 3:** List a folder's contents without being inside it.

```bash
ls ~/Desktop
```

You can `ls` a folder without being inside it by putting the path after `ls`.

**Experiment 4:** Use `ls` on the whole system root.

```bash
ls /
```

Output:
```
Applications  Library  System  Users  Volumes  bin  etc  home  opt  private  sbin  tmp  usr  var
```

These are ALL the top-level folders on your Mac. Most of them are system stuff — don't worry about them for now. Just notice that the whole Mac is one big tree.

---

## Pro Tip — `ls` Colors

Your terminal might already show folders in one color and files in another. If not, you can enable colors with:

```bash
ls -G
```

The `-G` flag turns on color output. In Mission 10 you'll set this as the permanent default so you never have to type `-G` again.

---

## Your Mission — Navigate the Detective Building

Time to put your skills to work on the mission playground. Navigate through the `office/` maze and read every file you find.

```bash
cd ~/mac-cli-for-kids/playground/mission_02
cat case_briefing.txt
```

Read the briefing, then start exploring:

```bash
# Read the clue files in the main folder
cat clue1.txt
cat clue2.txt
cat clue3.txt

# Move into the office building
cd office
ls

# Explore the hallway
cd hallway
ls
cd room1
ls
cat desk.txt

# Navigate back and find the basement
cd ../..
ls
cd basement
cd vault
cd locked
ls
cat access_denied.txt
cat treasure_map.txt
```

Then draw your map using `echo` commands — replace with what you actually found:

```bash
echo "============================================"
echo "     MAP OF THE DETECTIVE BUILDING          "
echo "============================================"
echo ""
echo "mission_02/"
echo "|"
echo "+-- case_briefing.txt"
echo "+-- clue1.txt / clue2.txt / clue3.txt"
echo "+-- office/"
echo "    +-- hallway/"
echo "    |   +-- room1/"
echo "    |       +-- desk.txt"
echo "    +-- basement/"
echo "        +-- vault/"
echo "            +-- locked/"
echo "                +-- treasure_map.txt"
echo "                +-- access_denied.txt"
echo ""
echo "Navigation complete."
```

---

## 🔍 Secret Code Hunt

There's a hidden file somewhere in the `mission_02` folder. You can't see it with a plain `ls` — you need the flag that reveals hidden files.

Navigate to the mission folder:
```bash
cd ~/mac-cli-for-kids/playground/mission_02
```

Use `ls -la` to show hidden files. Do you see a file starting with `.`? Once you spot `.secret_code.txt`, read it:

```bash
cat .secret_code.txt
```

Write down the word. That's word #2 in your 12-word master code!

**Bonus hunt:** There might be more hidden files deeper in the maze. Can you use `ls -la` inside the `office/` subfolders to check?

---

## Challenges

### Case #0201 — The Deep Dive

Navigate into the `office/basement/vault/locked/` directory using a single `cd` command with the full relative path (no intermediate steps). Then use `pwd` to confirm where you are. Then come back to the `mission_02` folder in one command.

**Hint:** `cd office/basement/vault/locked` takes you all the way down in one step. And `cd ~/mac-cli-for-kids/playground/mission_02` takes you back.

### Case #0202 — The Speed Tour

Without leaving the `mission_02` folder (no `cd`), use `ls` to peek inside each of these locations:
- `office/`
- `office/hallway/`
- `office/hallway/room1/`
- `office/basement/vault/locked/`

**Hint:** `ls office/hallway/room1/` works without you needing to move there first.

### Case #0203 — Count the Clues

How many clue files are directly in the `mission_02` folder? Use `ls` and `wc -l` together:

```bash
ls ~/mac-cli-for-kids/playground/mission_02 | wc -l
```

That `|` (pipe) and `wc -l` is a sneak peek at Mission 6. `wc -l` counts lines, so this counts how many items `ls` printed.

Now count how many items are inside `office/basement/vault/locked/`. Which folder has more items?

### Case #0204 — The Hidden World

Show all hidden files in your own home folder:

```bash
ls -la ~ | grep "^\."
```

Write down at least 3 hidden files you find. What do you think `.zshrc` might be for? (You'll open it in Mission 10!) Then compare: does the `mission_02` playground have any hidden files beyond `.secret_code.txt`?

### Case #0205 — Finder Bridge

Go to the locked vault in Terminal:

```bash
cd ~/mac-cli-for-kids/playground/mission_02/office/basement/vault/locked
pwd
open .
```

Finder should open the same folder. Read `treasure_map.txt` in Finder, then read it in Terminal with `cat treasure_map.txt`. Same file, two views.

---

## Solutions

Solutions are in the [solutions folder](solutions/README.md).

---

## Powers Unlocked

| Command | What It Does |
|---------|-------------|
| `pwd` | Shows your current folder (Print Working Directory) |
| `ls` | Lists files and folders in current directory |
| `ls -l` | Lists with details (size, date, permissions) |
| `ls -la` | Lists everything including hidden files |
| `ls path/` | Lists contents of a specific folder |
| `cd foldername` | Move into a folder |
| `cd ..` | Go up one level |
| `cd ~` | Go to your home folder |
| `cd /absolute/path` | Go to an exact location anywhere on your Mac |
| `open .` | Open your current Terminal folder in Finder |
| Tab | Complete a file or folder name |
| Tab twice | Show matching file or folder names |

### Vocabulary

- **Directory** — another word for folder
- **Current directory** — the folder you're "inside" right now
- **Home folder** — your personal folder, shortcut: `~`
- **Root** — the very top of the file system: `/`
- **Absolute path** — a path starting from `/`
- **Relative path** — a path starting from where you are now
- **Tab completion** — pressing Tab to auto-complete file/folder names

---

*The map is in your head now. You know how to find anything, go anywhere, and always find your way home. A detective who can navigate always has the advantage.*

*Ready for Mission 3?*
