# Mission 2 — Exploring Your World

## Mission Briefing

Every video game has a map. In Minecraft, you explore a world made of blocks. In Zelda, you explore dungeons and overworld. Your Mac's file system is exactly like that — a world full of folders (dungeons) and files (treasure chests).

The difference is that in Finder, you can only see what's in front of you. In Terminal, you can see *everything* — where you are, what's around you, and jump to any location instantly with a single command.

Today you learn to navigate your Mac like a pro explorer.

### What You'll Learn
- `pwd` — where am I right now?
- `ls` — what's here?
- `cd` — move to a different place
- How Mac's file system is organized
- How to draw a map of your home folder

---

## Understanding the Map

Your Mac's files are organized like a tree. Everything starts from the **root** — written as `/` (a single forward slash). From there, branches go out:

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

This is your **current directory** (directory = folder). The terminal is always "inside" some folder, just like how Finder always has a window open somewhere.

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

Think of it like directions: "Go to 123 Main Street" (absolute) vs "Turn left at the corner" (relative — only makes sense if you know where you're standing).

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

**Experiment 3:** List your Desktop contents.

```bash
ls ~/Desktop
```

You can `ls` a folder without being inside it by putting the path after `ls`.

**Experiment 4:** Use `ls` on the whole system.

```bash
ls /
```

Output:
```
Applications  Library  System  Users  Volumes  bin  etc  home  opt  private  sbin  tmp  usr  var
```

These are ALL the top-level folders on your Mac. Most of them are system stuff — don't worry about them for now.

---

## Pro Tip — `ls` Colors

Your terminal might already show folders in one color and files in another. If not, you can enable colors with:

```bash
ls -G
```

The `-G` flag turns on color output. In Mission 10 you'll set this as the permanent default so you never have to type `-G` again.

---

## Your Mission — Draw a Map of Your Home Folder

You're going to explore your home folder and its contents, then "draw" a map using `echo` commands.

First, gather information:

```bash
cd ~
ls
```

Now look inside a few key folders:

```bash
ls Documents
ls Downloads
ls Desktop
ls Pictures
```

Now create your map! Replace what you see with your actual folder contents:

```bash
echo "============================================"
echo "        MAP OF SOPHIA'S COMPUTER            "
echo "============================================"
echo ""
echo "~ (Home Folder: /Users/sophia)"
echo "|"
echo "+-- Desktop/"
echo "|"
echo "+-- Documents/"
echo "|   +-- (your documents here)"
echo "|"
echo "+-- Downloads/"
echo "|   +-- (your downloads here)"
echo "|"
echo "+-- Pictures/"
echo "|   +-- (your photos here)"
echo "|"
echo "+-- Music/"
echo "|"
echo "+-- Movies/"
echo "|"
echo "+-- Public/"
echo ""
echo "Total folders found:"
ls ~ | wc -l
```

The last line uses `wc -l` to count lines (we'll learn more about that in Mission 6). It tells you how many items are in your home folder.

---

## Challenges

### Challenge 1 — The Deep Dive

Navigate into your Documents folder, then into the deepest subfolder you can find (keep using `cd foldername` to go deeper). Then use `pwd` to show where you ended up. Then come back home in one command.

**Hint:** Remember `cd ~` takes you home from anywhere.

### Challenge 2 — The Speed Tour

Without leaving the home folder (no `cd`), use `ls` to peek inside each of these folders:
- Desktop
- Documents  
- Downloads
- Pictures

**Hint:** `ls ~/Desktop` works without you having to move there first.

### Challenge 3 — Count the Files

How many items are in your Downloads folder?

```bash
ls ~/Downloads | wc -l
```

That `|` (pipe) and `wc -l` is a sneak peek at Mission 6. `wc -l` counts lines. So this counts how many things `ls` printed.

Can you find which folder in your home directory has the MOST items in it?

### Challenge 4 — The Hidden World

Show all hidden files in your home folder:

```bash
ls -la ~ | grep "^\."
```

Write down (or remember) at least 3 hidden files you find. What do you think `.zshrc` might be for? (We'll open it in Mission 10!)

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

### Vocabulary

- **Directory** — another word for folder
- **Current directory** — the folder you're "inside" right now
- **Home folder** — your personal folder, shortcut: `~`
- **Root** — the very top of the file system: `/`
- **Absolute path** — a path starting from `/`
- **Relative path** — a path starting from where you are now
- **Tab completion** — pressing Tab to auto-complete file/folder names

---

*The map is in your head now. You know how to find anything, go anywhere, and always find your way home.*

*Ready for Mission 3?*
