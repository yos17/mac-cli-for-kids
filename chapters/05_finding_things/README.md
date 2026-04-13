# Mission 5 — The Missing Witness

## Mission Briefing

*"A key witness has gone missing," Director Chen says, sliding a folder across the desk. "Her name is somewhere in those 30+ files. I don't have time to read them all. You do. Find her."*

A real detective never panics when something is missing. They have methods. They search systematically. With `grep`, you can search through hundreds of files in seconds and find exactly what you're looking for.

**The witness is hidden in `playground/mission_05/`. Find her.**

### What You'll Learn
- `find` — locate files anywhere on your Mac
- `grep` — search *inside* files for text
- `mdfind` — Mac Spotlight search from Terminal
- How to combine searches for detective-level precision

---

## The `find` Command

`find` searches for files by name, type, size, date, and more:

```
find [where to search] [what to look for]
```

### Find by Name

Find all `.txt` files starting from your home folder:

```bash
find ~ -name "*.txt"
```

Find case-insensitively:

```bash
find ~ -iname "journal.txt"
```

### Find by Type

`-type f` = files only, `-type d` = directories only:

```bash
find playground/mission_05 -type f -name "report_*.txt"
```

### Find by Size

Find files larger than 100 megabytes:

```bash
find ~ -size +100M
```

### Find by Date

Find files modified in the last 7 days:

```bash
find ~ -mtime -7
```

---

## The `grep` Command

`grep` searches *inside* files for text. Think of it as Cmd+F for Terminal.

```bash
grep "word" filename.txt
```

### Case-Insensitive Search

```bash
grep -i "MARINA" report_008.txt
```

Matches "Marina", "MARINA", "marina", etc.

### Show Line Numbers

```bash
grep -n "evidence" report_008.txt
```

### Count Matches

```bash
grep -c "Agent" report_008.txt
```

### Search Multiple Files (the Power Move!)

```bash
grep "MARINA" *.txt
```

Searches ALL .txt files at once!

### Search Recursively (All Files in a Folder)

```bash
grep -r "MARINA" playground/mission_05/
```

Searches every file inside the folder and all subfolders. This is what detectives use.

### Show Only Filenames

```bash
grep -l "MARINA" playground/mission_05/*.txt
```

`-l` means "just tell me WHICH FILES matched."

---

## Pattern Matching with grep

`grep` understands special patterns:

```bash
grep "^FIELD" report_008.txt    # lines that START with FIELD
grep "Agent$" report_008.txt    # lines that END with Agent
grep "[0-9]" report_008.txt     # lines containing any number
```

- `^` means "start of line"
- `$` means "end of line"
- `[0-9]` matches any digit

---

## `mdfind` — Spotlight from Terminal

```bash
mdfind "MARINA"
```

Searches your entire Mac using the Spotlight index. Very fast.

```bash
mdfind -onlyin playground/mission_05 "witness"
```

---

## Try It! — Quick Experiments

**Experiment 1:** Read the keyword hints:
```bash
cat playground/mission_05/keyword_hints.txt
```

**Experiment 2:** Try a broad search — how many files mention "Agent"?
```bash
grep -l "Agent" playground/mission_05/*.txt
```

**Experiment 3:** Try searching for something that doesn't exist:
```bash
grep "banana" playground/mission_05/*.txt
```

`grep` returns nothing if there's no match. Silence = not found.

**Experiment 4:** Count words in the English dictionary.
```bash
grep -c "." /usr/share/dict/words
```

`.` in regex matches "any character" — so this counts every line.

---

## Pro Tip — 2>/dev/null

When you run `find ~`, you'll often see permission errors. Hide them:

```bash
find ~ -name "*.txt" 2>/dev/null
```

`2>` redirects error messages to `/dev/null` — a special "trash can" file. Normal output still shows; only errors disappear.

---

## Your Mission — Find the Missing Witness

**Step 1:** Navigate to the case files:
```bash
cd playground/mission_05
ls
```

You'll see 30+ files. This is a lot to read manually.

**Step 2:** Read the keyword hints:
```bash
cat keyword_hints.txt
```

**Step 3:** Search for the witness by first name:
```bash
grep "MARINA" *.txt
```

**Step 4:** If that shows multiple matches, narrow it down:
```bash
grep "MARINA SANTOS" *.txt
```

**Step 5:** Find just the filename:
```bash
grep -l "MARINA SANTOS" *.txt
```

**Step 6:** Read the full report with her information:
```bash
cat report_008.txt
```

**Step 7:** Count how many times her name appears in the report:
```bash
grep -c "MARINA" report_008.txt
```

**Step 8:** Find the hidden code:
```bash
ls -la
cat .secret_code.txt
```

**Bonus:** Search through all types of files at once:
```bash
grep -r "MARINA" .
```

---

## Challenges

### Challenge 1 — Find Your Photos

Find all files with `.jpg`, `.png`, or `.heic` extensions in your home folder. Use `find` and count them.

### Challenge 2 — Dictionary Detective

Using `grep` on `/usr/share/dict/words`:
1. Find all words that start with "detect"
2. Find all words that end with "tion"
3. How many words start with "secret"?

### Challenge 3 — Witness Search Variations

Try finding the witness using different grep approaches:
1. `grep "Marina" playground/mission_05/*.txt` (lowercase m)
2. `grep -i "marina" playground/mission_05/*.txt` (case-insensitive)
3. `grep -rn "SANTOS" playground/mission_05/` (with line numbers, recursive)

Which approach found the most matches?

### Challenge 4 — Recent Files

Find all files in `playground/mission_05/` modified in the last 24 hours:

```bash
find playground/mission_05 -mtime -1
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
| `find path -type f` | Find files only |
| `find path -size +100M` | Find files larger than 100MB |
| `find path -mtime -7` | Find files modified in last 7 days |
| `grep "text" file` | Search for text inside a file |
| `grep -i "text" file` | Search case-insensitively |
| `grep -r "text" folder/` | Search all files recursively |
| `grep -l "text" *.txt` | Show only matching filenames |
| `grep -n "text" file` | Show line numbers with matches |
| `grep -c "text" file` | Count matching lines |
| `mdfind "term"` | Spotlight search from Terminal |
| `2>/dev/null` | Hide error messages |

### Vocabulary

- **grep** — "Global Regular Expression Print" — searches for patterns in text
- **Regular expression** — a pattern language for matching text
- **mdfind** — macOS metadata find (uses Spotlight's index)
- `/dev/null` — the "trash can" — discards anything written to it

---

*You found the witness. You searched 30 files in seconds. That's grep. That's a detective's superpower.*

*Ready for Mission 6?*
