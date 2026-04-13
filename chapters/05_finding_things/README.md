# Mission 5 — Finding Things

## Mission Briefing — Commander Chen Speaks

*Incoming transmission...*

> "Agent, this one's a real case. We have a folder with 35 files in it — reports, evidence logs, photos, data sheets — and we need to find a single name buried somewhere inside them: MARINA SANTOS. Without the right tools, you'd have to open every file by hand. That could take an hour. With `grep`, it takes three seconds. Today you become a file detective. You'll find any file on your entire Mac, search inside files for specific words, and combine searches for detective-level precision. One of those 35 files contains the name. Your job is to find it."

A real detective never panics when something is missing. They have methods. They search systematically and find things that others can't.

Today you become a file detective. You'll learn to find any file on your entire Mac, search inside files for specific words or patterns, and build a "finder" toolkit you can use anytime.

### What You'll Learn
- `find` — locate files anywhere on your Mac
- `grep` — search *inside* files for text
- `mdfind` — Mac Spotlight search from Terminal
- How to combine searches for detective-level precision

---

## Your Case Files

Commander Chen has prepared a training exercise for you. Navigate there now:

```bash
cd ~/mac-cli-for-kids/playground/mission_05
ls
```

You should see a folder full of files organized in groups:

```
data_001.csv    data_002.csv    data_003.csv    data_004.csv    data_005.csv
evidence_001.log  evidence_002.log  ...  evidence_010.log
keyword_hints.txt
photos_001.txt  photos_002.txt  ...  photos_005.txt
report_001.txt  report_002.txt  ...  report_010.txt
```

That's 30+ files. Somewhere in the `report_*.txt` files, the name **MARINA SANTOS** appears. You need to find it without opening every file. And there's also a `keyword_hints.txt` — read that first:

```bash
cat keyword_hints.txt
```

This file contains hints about what other keywords are hiding in the evidence. Your challenges will use both `find` and `grep` to track everything down.

---

## The `find` Command

`find` searches for files by name, type, size, date, and more. Its basic shape is:

```
find [where to search] [what to look for]
```

### Find by Name

Find all `.txt` files in your mission folder:

```bash
find ~/mac-cli-for-kids/playground/mission_05 -name "*.txt"
```

The first argument says "search starting from this folder." The `-name "*.txt"` says "match anything ending in .txt."

Find files whose names start with "report":

```bash
find ~/mac-cli-for-kids/playground/mission_05 -name "report_*.txt"
```

Find case-insensitively (matches `Report.txt`, `REPORT.TXT`, etc.):

```bash
find ~/mac-cli-for-kids/playground/mission_05 -iname "report_*.txt"
```

---

### Find by Type

`-type f` = files only
`-type d` = directories only

```bash
find ~/mac-cli-for-kids/playground/mission_05 -type f -name "*.log"
```

Finds all log files in the mission folder.

```bash
find ~ -type d -name "mission_05"
```

Finds the folder itself by name.

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

### Find MARINA SANTOS

Here's the command that solves the main mission challenge. Don't run it yet — read the whole section first, then try it:

```bash
grep "MARINA SANTOS" ~/mac-cli-for-kids/playground/mission_05/report_*.txt
```

This searches all 10 report files at once. `grep` will print the filename and the line that matches. Which report file contains the name?

### Case-Insensitive Search

```bash
grep -i "marina santos" ~/mac-cli-for-kids/playground/mission_05/report_*.txt
```

Matches "MARINA SANTOS", "Marina Santos", "marina santos", etc. Useful when you're not sure about capitalization.

### Show Line Numbers

```bash
grep -n "MARINA SANTOS" ~/mac-cli-for-kids/playground/mission_05/report_*.txt
```

The `-n` flag shows which line number the match is on.

### Count Matches

```bash
grep -c "MARINA" ~/mac-cli-for-kids/playground/mission_05/report_*.txt
```

Returns the count of matching lines per file. Files with 0 have no match.

### Search Multiple Files with a Wildcard

```bash
grep "suspect" ~/mac-cli-for-kids/playground/mission_05/*.txt
```

Searches all `.txt` files in the mission folder.

### Search Recursively (All Files in a Folder)

```bash
grep -r "MARINA" ~/mac-cli-for-kids/playground/mission_05/
```

Searches every file in the folder and all its subfolders. This is the most powerful form.

---

## Pattern Matching with grep

`grep` understands special patterns called **regular expressions** (regex). Here are the basics:

```bash
grep "^REPORT" report_001.txt    # lines that START with REPORT
grep "SANTOS$" report_001.txt    # lines that END with SANTOS
grep "[0-9]" evidence_001.log    # lines containing any number
grep "MARINA\|SANTOS" report_*.txt  # lines with "MARINA" OR "SANTOS"
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
mdfind "marina santos"
```

This searches your entire Mac — file names AND file contents — for "marina santos". It uses the same index as Spotlight, so it's very fast.

Search in a specific folder only:

```bash
mdfind -onlyin ~/mac-cli-for-kids/playground/mission_05 "MARINA"
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

**Experiment 1:** Find all report files in the mission folder.

```bash
find ~/mac-cli-for-kids/playground/mission_05 -name "report_*.txt"
```

How many are there? Now use `wc -l` to count them without counting manually:

```bash
find ~/mac-cli-for-kids/playground/mission_05 -name "report_*.txt" | wc -l
```

**Experiment 2:** Search for keywords across all evidence logs.

```bash
grep -i "suspect" ~/mac-cli-for-kids/playground/mission_05/evidence_*.log
```

What do the evidence logs say about suspects?

**Experiment 3:** Count words in the dictionary.

```bash
grep -c "." /usr/share/dict/words
```

`.` in regex matches "any character" — so this counts every non-empty line, which is the number of words.

**Experiment 4:** Find words that contain "detect" in the dictionary.

```bash
grep "detect" /usr/share/dict/words
```

How many detective-related words are there?
```bash
grep -c "detect" /usr/share/dict/words
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

Create a personal search reference file you can use on future cases:

```bash
touch ~/detective_toolkit.sh
```

Add these comments showing your most useful search commands:

```bash
echo '#!/bin/bash' > ~/detective_toolkit.sh
echo '# Detective File Finder Toolkit' >> ~/detective_toolkit.sh
echo '# ==============================' >> ~/detective_toolkit.sh
echo '' >> ~/detective_toolkit.sh
echo '# Find files by name pattern:' >> ~/detective_toolkit.sh
echo '# find [folder] -name "*.txt" 2>/dev/null' >> ~/detective_toolkit.sh
echo '' >> ~/detective_toolkit.sh
echo '# Search inside files for text:' >> ~/detective_toolkit.sh
echo '# grep -r "search term" [folder]' >> ~/detective_toolkit.sh
echo '' >> ~/detective_toolkit.sh
echo '# Find files bigger than 100MB:' >> ~/detective_toolkit.sh
echo '# find ~ -type f -size +100M 2>/dev/null' >> ~/detective_toolkit.sh
echo '' >> ~/detective_toolkit.sh
echo '# Spotlight search:' >> ~/detective_toolkit.sh
echo '# mdfind "something you are looking for"' >> ~/detective_toolkit.sh
```

Read it back:
```bash
cat ~/detective_toolkit.sh
```

Then run the key detective searches on your mission files:

```bash
# Find which report contains MARINA SANTOS
grep "MARINA SANTOS" ~/mac-cli-for-kids/playground/mission_05/report_*.txt

# Check what the data files contain
head -3 ~/mac-cli-for-kids/playground/mission_05/data_001.csv

# Search across ALL file types in the mission folder
grep -r "MARINA" ~/mac-cli-for-kids/playground/mission_05/

# Count total files
find ~/mac-cli-for-kids/playground/mission_05 -type f | wc -l
```

---

## 🔍 Secret Code Hunt

There's a hidden file in the `mission_05` folder containing your fifth secret code word.

```bash
cd ~/mac-cli-for-kids/playground/mission_05
ls -la
```

Spot `.secret_code.txt`? Read it:

```bash
cat .secret_code.txt
```

Write down word #5. Five down, seven to go — you're almost halfway through the master code!

**Bonus:** Can you use `grep` to find any hidden patterns inside `keyword_hints.txt`? Try:
```bash
grep "secret\|hidden\|code" keyword_hints.txt
```

---

## Challenges

### Case #0501 — Find the Witness

Use `grep` to find which file in the `mission_05` playground contains the name **MARINA SANTOS**. When you find the right file, use `cat` to read the whole thing.

```bash
grep "MARINA SANTOS" ~/mac-cli-for-kids/playground/mission_05/report_*.txt
```

Which report number was it? What does the full file say?

**Bonus:** Use `grep -n` to find the exact line number where the name appears.

### Case #0502 — Evidence Log Analysis

Search through all 10 evidence log files for any keyword from `keyword_hints.txt`. Use `grep` with at least 3 different keywords.

```bash
grep -i "KEYWORD" ~/mac-cli-for-kids/playground/mission_05/evidence_*.log
```

Then count how many total lines across all evidence logs contain numbers:

```bash
grep -c "[0-9]" ~/mac-cli-for-kids/playground/mission_05/evidence_*.log
```

### Case #0503 — Dictionary Detective

Using `grep` on `/usr/share/dict/words`:
1. Find all words that start with "detect"
2. Find all words that end with "tion"
3. Find all words that contain "clue" (if any!)
4. How many 5-letter words are in the dictionary? (Hint: `grep "^.....$"` — each `.` matches exactly one character)

### Case #0504 — Full Folder Sweep

Using a single `grep -r` command, search the entire `mission_05` folder for any occurrence of the word "MARINA" (case-insensitive). How many files mention it? Is it only in the reports, or does it appear in other file types too?

Then find the most recently modified file in the `mission_05` folder:

```bash
find ~/mac-cli-for-kids/playground/mission_05 -type f -mtime -7 2>/dev/null
```

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

*You are now a file detective. No file on your Mac can hide from you. MARINA SANTOS was found. Case closed.*

*Ready for Mission 6?*
