# Mission 5 — Finding Things

## Mission Briefing

A real detective never panics when something is missing. They have methods. They search systematically and find things that others can't.

Today you become a file detective. You'll learn to find any file on your entire Mac, search inside files for specific words or patterns, and build a "finder" toolkit you can use anytime.

### What You'll Learn
- `find` — locate files anywhere on your Mac
- `grep` — search *inside* files for text
- `mdfind` — Mac Spotlight search from Terminal
- How to combine searches for detective-level precision

---

## The `find` Command

`find` searches for files by name, type, size, date, and more. Its basic shape is:

```
find [where to search] [what to look for]
```

### Find by Name

Find all `.txt` files in your home folder:

```bash
find ~ -name "*.txt"
```

The `~` says "search starting from home folder." The `-name "*.txt"` says "match anything ending in .txt."

Find an exact file:

```bash
find ~ -name "journal.txt"
```

Find case-insensitively (matches `Journal.txt`, `JOURNAL.TXT`, etc.):

```bash
find ~ -iname "journal.txt"
```

---

### Find by Type

`-type f` = files only
`-type d` = directories only

```bash
find ~ -type d -name "projects"
```

Finds all folders named "projects" in your home folder.

```bash
find ~/Downloads -type f -name "*.jpg"
```

Finds all JPEG images in Downloads.

---

### Find by Size

Find files larger than 100 megabytes:

```bash
find ~ -size +100M
```

Find files smaller than 10 kilobytes:

```bash
find ~ -size -10k
```

Units: `c` = bytes, `k` = kilobytes, `M` = megabytes, `G` = gigabytes.

---

### Find by Date

Find files modified in the last 7 days:

```bash
find ~ -mtime -7
```

Find files older than 30 days:

```bash
find ~ -mtime +30
```

`-mtime` = modified time, in days. `-7` means "less than 7 days ago."

---

## The `grep` Command

`grep` searches *inside* files for text or patterns. Think of it as Cmd+F for your terminal.

Basic use:

```bash
grep "word" filename.txt
```

### Search in Your Diary

```bash
grep "learned" ~/diary/journal.txt
```

Shows every line in your diary that contains the word "learned".

### Case-Insensitive Search

```bash
grep -i "april" ~/diary/journal.txt
```

Matches "April", "APRIL", "april", etc.

### Show Line Numbers

```bash
grep -n "====" ~/diary/journal.txt
```

The `-n` flag shows which line number each match is on.

### Count Matches

```bash
grep -c "===" ~/diary/journal.txt
```

Returns just the count — how many lines match.

### Search Multiple Files

```bash
grep "rainbow" ~/Documents/*.txt
```

Searches all `.txt` files in Documents.

### Search Recursively (All Files in a Folder)

```bash
grep -r "homework" ~/Documents/
```

Searches every file inside Documents and all its subfolders. This is powerful.

---

## Pattern Matching with grep

`grep` understands special patterns called **regular expressions** (regex). Here are the basics:

```bash
grep "^===" ~/diary/journal.txt    # lines that START with ===
grep "===$" ~/diary/journal.txt    # lines that END with ===
grep "[0-9]" ~/diary/journal.txt   # lines containing any number
grep "Apr\|May" ~/diary/journal.txt # lines with "Apr" OR "May"
```

- `^` means "start of line"
- `$` means "end of line"
- `[0-9]` matches any digit
- `\|` means "or"

You don't need to master regex today — just know it exists and `grep` can use it.

---

## `mdfind` — Spotlight from Terminal

macOS has a powerful search engine called Spotlight (the Cmd+Space thing). You can access it from Terminal with `mdfind`:

```bash
mdfind "birthday"
```

This searches your entire Mac — file names AND file contents — for "birthday". It uses the same index as Spotlight, so it's very fast.

Search in a specific folder only:

```bash
mdfind -onlyin ~/Documents "project"
```

Find files of a specific type:

```bash
mdfind "kind:pdf"
mdfind "kind:image"
mdfind "kind:music"
```

Find by date:

```bash
mdfind "date:today"
mdfind "date:yesterday"
```

---

## Try It! — Quick Experiments

**Experiment 1:** Find all images in your home folder.

```bash
find ~ -name "*.jpg" -o -name "*.png" -o -name "*.heic" 2>/dev/null
```

The `-o` means "or". The `2>/dev/null` hides permission error messages (we'll explain this later).

**Experiment 2:** Find the 5 biggest files in your Downloads.

```bash
find ~/Downloads -type f -size +1M 2>/dev/null
```

**Experiment 3:** Count words in the dictionary.

```bash
grep -c "." /usr/share/dict/words
```

`.` in regex matches "any character" — so this counts every non-empty line, which is the number of words.

**Experiment 4:** Find words that contain "moon" in the dictionary.

```bash
grep "moon" /usr/share/dict/words
```

How many moon-words are there?
```bash
grep -c "moon" /usr/share/dict/words
```

---

## Pro Tip — 2>/dev/null

When you run `find ~`, you'll often see permission errors like:

```
find: /Users/sophia/Library/Application Support: Permission denied
```

These are harmless but annoying. Hide them with `2>/dev/null`:

```bash
find ~ -name "*.txt" 2>/dev/null
```

`2>` redirects error messages (stderr) to `/dev/null` — a special file that throws away anything written to it. It's the trash can of Terminal. Normal output still shows; only errors disappear.

---

## Your Mission — Build a File Finder Toolkit

Create a file called `~/finder.sh` that contains your personal search shortcuts:

```bash
touch ~/finder.sh
```

Now add these lines with `>>`:

```bash
echo '#!/bin/bash' > ~/finder.sh
echo '# My personal file finder toolkit' >> ~/finder.sh
echo '' >> ~/finder.sh
echo '# Usage: bash ~/finder.sh [search-type] [term]' >> ~/finder.sh
echo '# Examples:' >> ~/finder.sh
echo '#   bash ~/finder.sh name myfile.txt' >> ~/finder.sh
echo '#   bash ~/finder.sh text "birthday party"' >> ~/finder.sh
echo '#   bash ~/finder.sh big' >> ~/finder.sh
```

Read it back:
```bash
cat ~/finder.sh
```

Then try each of these detective searches:

**Find a file by name anywhere:**
```bash
find ~ -name "*.txt" 2>/dev/null
```

**Find a file containing specific text:**
```bash
grep -r "your search term" ~ 2>/dev/null
```

**Find your biggest files:**
```bash
find ~ -type f -size +50M 2>/dev/null
```

**Spotlight search:**
```bash
mdfind "something you're looking for"
```

**Count all files in your home folder:**
```bash
find ~ -type f 2>/dev/null | wc -l
```

Save each of these as a comment in your `finder.sh` file for future reference!

---

## Challenges

### Challenge 1 — Find Your Photos

Find all files with `.jpg`, `.png`, or `.heic` extensions in your home folder. How many are there? Use `find` and `wc -l`.

### Challenge 2 — Dictionary Detective

Using `grep` on `/usr/share/dict/words`:
1. Find all words that start with "cat"
2. Find all words that end with "tion"
3. Find all words that contain "xyz" (if any exist!)
4. How many 5-letter words are in the dictionary? (Hint: `grep "^.....$"` — the `.` matches any character)

### Challenge 3 — Recent Activity

Find all files in your home folder that were modified in the last 24 hours:

```bash
find ~ -mtime -1 2>/dev/null
```

What was the most recently changed file?

### Challenge 4 — Search Your Diary

If you've written at least 2 diary entries:
1. `grep` for all your entry headers (lines starting with `===`)
2. `grep -i` for a word that you know appears in one of your entries
3. Count how many times you used the word "today" in your diary

---

## Solutions

Solutions are in the [solutions folder](solutions/README.md).

---

## Powers Unlocked

| Command | What It Does |
|---------|-------------|
| `find path -name "*.txt"` | Find files by name pattern |
| `find path -iname "name"` | Find files by name (case-insensitive) |
| `find path -type d` | Find directories only |
| `find path -type f` | Find files only |
| `find path -size +100M` | Find files larger than 100MB |
| `find path -mtime -7` | Find files modified in last 7 days |
| `grep "text" file` | Search for text inside a file |
| `grep -i "text" file` | Search case-insensitively |
| `grep -r "text" folder/` | Search all files in a folder recursively |
| `grep -n "text" file` | Show line numbers with matches |
| `grep -c "text" file` | Count matching lines |
| `mdfind "term"` | Spotlight search from Terminal |
| `2>/dev/null` | Hide error messages |

### Vocabulary

- **grep** — "Global Regular Expression Print" — searches for patterns in text
- **Regular expression** — a pattern language for matching text
- **mdfind** — macOS metadata find (uses Spotlight's index)
- **stderr** — the error output stream (separate from normal output)
- `/dev/null` — the "trash can" — discards anything written to it

---

*You are now a file detective. No file on your Mac can hide from you.*

*Ready for Mission 6?*
