# CASE FILE #5 — The Missing Witness

**Terminal Detective Agency | Clearance Level: Junior Detective**

---

## 🔍 MISSION BRIEFING

Agent, we have a serious situation.

Our star witness — the one person who can testify against the suspect from Case #4 — has gone into hiding. For their own protection, they didn't tell us where they'd be. But they left behind a folder of over 50 files: reports, data dumps, access logs, and miscellaneous documents. The witness's location is buried somewhere inside those files.

Here's the problem: the suspect's team got to the folder first. They deliberately scattered dozens of decoy files throughout the directory to slow down any investigator searching for clues. There are fake reports, empty data files, and red herrings everywhere.

You'll need `grep` and `find` — the detective's best search tools — to cut through the noise and find what matters. Before you dive in, check `keyword_hints.txt` — our intelligence team left you four search terms that should point you to the right files.

Oh, and one more thing: the secret code piece for this case is hidden in a **hidden directory**. You'll have to know the trick for finding those.

**Access your case files:**
```bash
cd playground/mission_05
```

---

## 📚 DETECTIVE TRAINING: Finding Things

A real detective never panics when something is missing. They have methods. They search systematically and find things that others can't. Today you learn those methods: `find` to locate files, and `grep` to search inside them.

---

## The `find` Command

`find` searches for files by name, type, size, date, and more. Its basic shape is:

```
find [where to search] [what to look for]
```

### Find by Name

Find all `.txt` files in the mission folder:

```bash
find playground/mission_05 -name "*.txt"
```

The `-name "*.txt"` means "match anything ending in .txt." The `*` is a wildcard that matches any characters.

Find an exact file by name:

```bash
find playground/mission_05 -name "case_briefing.txt"
```

Find case-insensitively (matches `Report.txt`, `REPORT.TXT`, `report.txt`, etc.):

```bash
find playground/mission_05 -iname "report*.txt"
```

---

### Find by Type

`-type f` = files only
`-type d` = directories only

```bash
# Find all subdirectories in the mission folder
find playground/mission_05 -type d

# Find all .log files
find playground/mission_05 -type f -name "*.log"
```

---

### Find by Size

Find files larger than 100 kilobytes:

```bash
find ~ -size +100k
```

Find files smaller than 1 kilobyte (small files that might just be placeholders):

```bash
find playground/mission_05 -size -1k
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

`-mtime` = modified time, measured in days. `-7` means "less than 7 days ago."

---

## The `grep` Command

`grep` searches **inside** files for text or patterns. Think of it as Cmd+F for your terminal — but supercharged.

Basic use:

```bash
grep "word" filename.txt
```

### Search Inside a File

```bash
grep "witness" playground/mission_05/report_001.txt
```

Shows every line in that file containing the word "witness."

### Case-Insensitive Search

```bash
grep -i "safe house" playground/mission_05/report_001.txt
```

Matches "Safe House", "SAFE HOUSE", "safe house", etc.

### Show Line Numbers

```bash
grep -n "Agent Rivera" playground/mission_05/misc_001.txt
```

The `-n` flag shows which line number each match is on. Helpful when you need to point someone else to the exact location in a file.

### Count Matches

```bash
grep -c "witness" playground/mission_05/report_001.txt
```

Returns just the count — how many lines match. Good for quickly knowing if something is in a file at all.

### Search Multiple Files at Once

```bash
grep "Maple Street" playground/mission_05/*.txt
```

Searches all `.txt` files in the mission folder.

### Show Only Filenames

```bash
grep -l "safe house" playground/mission_05/*.txt
```

The `-l` flag (lowercase L) shows **only the filenames** that contain a match — not the matching lines. Perfect when you just need to know *which* files to investigate, not every detail.

### Search Recursively Through All Files in a Folder

```bash
grep -r "witness" playground/mission_05/
```

Searches every file inside the folder and all its subfolders. This is the big one — **recursive search** is your most powerful investigative tool. The `-r` flag means "recursive."

---

## Pattern Matching with grep

`grep` understands special patterns called **regular expressions** (regex). Here are the most useful ones for a detective:

```bash
# Lines that START with "Date:"
grep "^Date:" playground/mission_05/report_001.txt

# Lines that END with "confirmed"
grep "confirmed$" playground/mission_05/report_001.txt

# Lines containing any number
grep "[0-9]" playground/mission_05/report_001.txt

# Lines with "witness" OR "informant"
grep "witness\|informant" playground/mission_05/report_001.txt
```

| Pattern | Meaning |
|---------|---------|
| `^` | Start of line |
| `$` | End of line |
| `[0-9]` | Any single digit |
| `[A-Z]` | Any capital letter |
| `.` | Any single character |
| `\|` | OR (match either word) |

You don't need to master regular expressions today — just know they exist and `grep` can use them when you need precision.

---

## `mdfind` — Spotlight from Terminal

macOS has a powerful search engine called Spotlight (the Cmd+Space thing). You can access it directly from Terminal with `mdfind`:

```bash
mdfind "birthday"
```

This searches your entire Mac — file names AND file contents — for "birthday." It uses the same index as Spotlight, so it's very fast.

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

`mdfind` is great for searching your whole Mac quickly, but `grep -r` is more precise and works inside the playground folders for this mission.

---

## Pro Tip — `2>/dev/null` (The Silence Button)

When you run `find ~` on your whole home folder, you'll often see annoying permission errors like:

```
find: /Users/sophia/Library/Application Support: Permission denied
```

These are harmless but they clutter your output. Hide them with `2>/dev/null`:

```bash
find ~ -name "*.txt" 2>/dev/null
```

`2>` redirects error messages (called **stderr**) to `/dev/null` — a special "trash can" file that throws away anything written to it. Normal output still shows; only errors disappear. You'll use this a lot in real detective work.

---

## Secret Technique — Finding Hidden Files

Here's something most people don't know: on a Mac (and all Unix systems), any file or directory whose name starts with a `.` (dot) is **hidden**. It won't show up with a regular `ls`. These are perfect places to hide secret files.

Regular `ls` won't show hidden files:
```bash
ls playground/mission_05/
```

But `ls -la` reveals everything, including hidden files and folders:
```bash
ls -la playground/mission_05/
```

Look for entries that start with a `.` — those are hidden. A hidden directory would look like `.hidden` or `.secret` in the listing.

Once you know a hidden directory exists, you can go right into it:
```bash
ls -la playground/mission_05/.hidden/
```

And you can search inside it:
```bash
grep -r "ELITE" playground/mission_05/.hidden/
```

---

## 🧪 FIELD WORK

Time to find our missing witness. Work through these experiments in order.

**Step 1: Get a picture of what we're dealing with**

```bash
cd playground/mission_05
ls | wc -l
```

How many files are there? That's a lot of places for the witness to be hiding.

**Step 2: Read the hints**

Our intelligence team left you four keywords that are known to appear in the files connected to the witness:

```bash
cat keyword_hints.txt
```

**Step 3: Search for the witness**

Now use those keywords to search across all files:

```bash
grep -r "witness" .
```

The `.` means "the current directory." This searches every file in `playground/mission_05/`.

```bash
grep -r "Agent Rivera" .
```

**Step 4: Find files that mention the safe house**

Use `-l` to just get filenames — you don't need to read every matching line:

```bash
grep -l "safe house" *.txt
```

**Step 5: Search case-insensitively across all files**

The witness might have used different capitalization:

```bash
grep -ri "maple street" .
```

**Step 6: Investigate specific file types**

```bash
# Find all log files
find . -name "*.log"

# Find all data files
find . -name "*.dat"

# How many of each type?
find . -name "*.log" | wc -l
find . -name "*.dat" | wc -l
```

**Step 7: Find the hidden directory**

Use `ls -la` to reveal what's lurking:

```bash
ls -la
```

See any directories starting with `.`? That's your target.

**Step 8: Search the hidden directory**

```bash
ls -la .hidden/
grep -r "ELITE" .hidden/
```

---

## 🎯 MISSION: Build a File Finder Toolkit

Create a personal search toolkit file — a reference guide you can use on any future case.

**Step 1:** Create the file:

```bash
echo '#!/bin/bash' > ~/finder.sh
echo '# Terminal Detective Agency — Personal File Finder Toolkit' >> ~/finder.sh
echo '# Agent: [Your name here]' >> ~/finder.sh
echo '' >> ~/finder.sh
echo '# FIND A FILE BY NAME ANYWHERE:' >> ~/finder.sh
echo '# find ~ -name "filename.txt" 2>/dev/null' >> ~/finder.sh
echo '' >> ~/finder.sh
echo '# FIND A FILE CONTAINING SPECIFIC TEXT:' >> ~/finder.sh
echo '# grep -r "search term" ~/Documents/ 2>/dev/null' >> ~/finder.sh
echo '' >> ~/finder.sh
echo '# FIND FILES THAT MATCH (FILENAMES ONLY, NO OUTPUT CLUTTER):' >> ~/finder.sh
echo '# grep -rl "search term" ~/Documents/' >> ~/finder.sh
echo '' >> ~/finder.sh
echo '# FIND YOUR BIGGEST FILES:' >> ~/finder.sh
echo '# find ~ -type f -size +50M 2>/dev/null' >> ~/finder.sh
echo '' >> ~/finder.sh
echo '# SPOTLIGHT SEARCH:' >> ~/finder.sh
echo '# mdfind "something you are looking for"' >> ~/finder.sh
echo '' >> ~/finder.sh
echo '# COUNT ALL FILES IN A FOLDER:' >> ~/finder.sh
echo '# find ~/Documents -type f 2>/dev/null | wc -l' >> ~/finder.sh
echo '' >> ~/finder.sh
echo '# FIND HIDDEN DIRECTORIES:' >> ~/finder.sh
echo '# ls -la /path/to/folder/' >> ~/finder.sh
```

**Step 2:** Read it back to verify:

```bash
cat ~/finder.sh
```

**Step 3:** Try each search against the playground:

```bash
# Find all reports
find playground/mission_05 -name "report_*.txt"

# Find files containing specific evidence
grep -rl "witness" playground/mission_05/

# Find the location clue
grep -rn "safe house" playground/mission_05/

# Show context around a match (3 lines before and after)
grep -r -A3 -B3 "Agent Rivera" playground/mission_05/
```

The `-A3` flag shows 3 lines **after** a match. The `-B3` flag shows 3 lines **before**. Together they give you context around the evidence, which often matters as much as the clue itself.

**Step 4:** Count how many report files you found the witness mentioned in:

```bash
grep -rl "witness" playground/mission_05/ | wc -l
```

**Step 5:** Build a summary of your findings:

```bash
echo "SEARCH RESULTS — MISSING WITNESS CASE" > search_findings.txt
echo "Files mentioning 'witness':" >> search_findings.txt
grep -rl "witness" . >> search_findings.txt
echo "" >> search_findings.txt
echo "Files mentioning 'safe house':" >> search_findings.txt
grep -rl "safe house" . >> search_findings.txt
echo "" >> search_findings.txt
echo "Files mentioning 'Agent Rivera':" >> search_findings.txt
grep -rl "Agent Rivera" . >> search_findings.txt
cat search_findings.txt
```

---

## 🏆 BONUS MISSIONS

### Bonus Mission 1 — Find the Evidence by File Type

Count how many files of each type are in the mission folder:

```bash
# Count each file type
find playground/mission_05 -name "*.txt" | wc -l
find playground/mission_05 -name "*.dat" | wc -l
find playground/mission_05 -name "*.log" | wc -l
```

Which file type has the most files? Were any of the `.dat` files helpful?

### Bonus Mission 2 — Dictionary Detective

Using `grep` on `/usr/share/dict/words` (the Mac dictionary):
1. Find all words that start with "witness" — `grep "^witness" /usr/share/dict/words`
2. Find all words that end with "tion" — `grep "tion$" /usr/share/dict/words`
3. Find all words that contain "shadow" — `grep "shadow" /usr/share/dict/words`
4. How many 5-letter words are in the dictionary? — `grep -c "^.....$" /usr/share/dict/words`

(The `.` in regex matches any single character, so `^.....$` means "start + exactly 5 characters + end.")

### Bonus Mission 3 — Recent Activity

Find all files in your home folder that were modified in the last 24 hours:

```bash
find ~ -mtime -1 2>/dev/null
```

What was the most recently changed file on your computer?

### Bonus Mission 4 — Search Your Case Notes

If you wrote case notes in Mission 4:
1. `grep` for all your section headers: `grep "^---" ~/diary/case_notes.txt`
2. Count how many sections you wrote: `grep -c "^---" ~/diary/case_notes.txt`
3. Search case-insensitively for a word you know you used: `grep -i "suspect" ~/diary/case_notes.txt`

### Bonus Mission 5 — The Thorough Search

Find every single file in the mission folder that contains any number. Use this regex:

```bash
grep -rl "[0-9]" playground/mission_05/
```

How many files have numbers in them? (Probably most of them — numbers appear in dates, times, IDs.)

---

## 🔐 CODE PIECE UNLOCKED!

Outstanding detective work, Agent. The witness's location was hidden in those files — and now you've found it.

The code piece for this mission is hidden in that hidden directory you discovered. Don't forget: regular `ls` won't show it. You need `ls -la`.

**Code Piece #5: ELITE**

```bash
cat playground/mission_05/.hidden/secret_code_piece.txt
```

Write it down next to Code Piece #4.

---

## ⚡ POWERS UNLOCKED

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
| `grep -n "text" file` | Show line numbers with matches |
| `grep -c "text" file` | Count matching lines |
| `grep -l "text" *.txt` | Show only filenames with matches |
| `grep -r "text" folder/` | Search all files in a folder recursively |
| `grep -rl "text" folder/` | Recursive search, show filenames only |
| `grep -A3 "text" file` | Show 3 lines after each match |
| `grep -B3 "text" file` | Show 3 lines before each match |
| `ls -la` | List all files including hidden ones |
| `mdfind "term"` | Spotlight search from Terminal |
| `2>/dev/null` | Hide error messages |

### Detective Vocabulary

- **grep** — "Global Regular Expression Print" — searches for patterns in text
- **Regular expression** — a pattern language for matching text (like `^` for start of line)
- **Recursive** — going through all files in a folder and all its subfolders (`-r`)
- **mdfind** — macOS metadata find (uses Spotlight's index)
- **stderr** — the error output stream (separate from normal output)
- `/dev/null` — the "trash can" of Terminal — discards anything written to it
- **Hidden file** — a file or folder starting with `.` that doesn't appear in regular `ls`

---

*You are now a file detective. No file on your Mac can hide from you — not even the ones in hidden directories.*

*Code pieces collected: #4 (AN) and #5 (ELITE). Ready for Case #6?*
