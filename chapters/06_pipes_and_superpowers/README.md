# Mission 6 — The Code Breaker

## Mission Briefing

*"The suspect left data behind," Director Chen says, dropping three files on your desk. "An access log, a suspect database, and a word list. I need to know: who accessed what? How many times? Which suspects live in the same city? You have pipes. Use them."*

In action movies, the hero is never alone — the team does more together than any one person can alone. The Unix philosophy is the same idea: each command does **one thing well**. The `|` (pipe) connects commands together so the output of one becomes the input of the next.

**The data files are in `playground/mission_06/`. Analyze them with pipes.**

### What You'll Learn
- `|` — the pipe (connect commands)
- `sort` — sort lines alphabetically or numerically
- `uniq` — remove duplicate lines
- `wc` — count words, lines, characters
- `cut` — extract columns from data

---

## The Pipe `|`

The pipe symbol `|` (Shift + `\`) connects two commands:

```bash
ls ~ | grep -c "."
```

Translation: "List my home folder, then count the lines." The result is the number of items.

---

## `sort` — Put Things in Order

Sort alphabetically:

```bash
sort playground/mission_06/word_scramble.txt
```

Sort in reverse:

```bash
sort -r playground/mission_06/word_scramble.txt
```

Sort numbers correctly:

```bash
# Without -n: "alphabetical" order (wrong for numbers!)
# With -n: actual numeric order (correct!)
sort -n numbers.txt
```

---

## `uniq` — Remove Duplicates

`uniq` removes consecutive duplicate lines. Use it *after* `sort`:

```bash
sort playground/mission_06/word_scramble.txt | uniq
```

Count how many times each item appears:

```bash
sort playground/mission_06/word_scramble.txt | uniq -c
```

Sort by count (most common first):

```bash
sort playground/mission_06/word_scramble.txt | uniq -c | sort -rn
```

Three commands. One powerful result.

---

## `wc` — Word Count

```bash
wc playground/mission_06/word_scramble.txt
```

Output:
```
      50      50     456 word_scramble.txt
```

Three numbers: **lines**, **words**, **characters**.

```bash
wc -l word_scramble.txt   # count lines only
wc -w word_scramble.txt   # count words only
```

---

## `cut` — Extract Columns

`cut` extracts specific parts of each line. Perfect for CSV files:

```bash
cut -d',' -f1 playground/mission_06/suspects_database.csv
```

`-d','` = delimiter is comma. `-f1` = field 1 (first column).

Get names and cities (columns 1 and 2):

```bash
cut -d',' -f1,2 playground/mission_06/suspects_database.csv
```

---

## Try It! — Quick Experiments

**Experiment 1:** How many words are in the word scramble? How many are unique?
```bash
cat playground/mission_06/word_scramble.txt | grep -c "."
sort playground/mission_06/word_scramble.txt | uniq | grep -c "."
```

**Experiment 2:** What are the most common HTTP status codes in the access log?
```bash
cut -d',' -f4 playground/mission_06/access_log.csv | sort | uniq -c | sort -rn
```

**Experiment 3:** Which cities appear in the suspects database?
```bash
cut -d',' -f2 playground/mission_06/suspects_database.csv | sort | uniq
```

**Experiment 4:** Count suspects per city:
```bash
cut -d',' -f2 playground/mission_06/suspects_database.csv | sort | uniq -c | sort -rn
```

---

## Pro Tip — `tee` Splits the Pipe

Sometimes you want to see output AND save it:

```bash
cut -d',' -f2 playground/mission_06/suspects_database.csv | tee cities.txt | sort | uniq -c
```

This saves the cities to `cities.txt` AND shows the count. Both happen at once.

---

## Your Mission — Analyze the Case Data

**Step 1:** Navigate to the data files:
```bash
cd playground/mission_06
ls
```

**Step 2:** Get an overview of each file:
```bash
cat access_log.csv | grep -c "."           # how many log entries?
cat suspects_database.csv | grep -c "."    # how many suspects?
cat word_scramble.txt | grep -c "."        # how many words?
```

**Step 3:** Crack the access log — which pages were accessed most?
```bash
cut -d',' -f3 access_log.csv | sort | uniq -c | sort -rn
```

**Step 4:** Find suspicious IPs (which ones accessed the most pages):
```bash
cut -d',' -f2 access_log.csv | sort | uniq -c | sort -rn
```

**Step 5:** Analyze the suspects database — which cities have the most suspects?
```bash
cut -d',' -f2 suspects_database.csv | sort | uniq -c | sort -rn
```

**Step 6:** Get just the names of suspects in "Old Quarter":
```bash
grep "Old Quarter" suspects_database.csv | cut -d',' -f1
```

**Step 7:** Find the hidden code:
```bash
ls -la
cat .secret_code.txt
```

---

## Challenges

### Challenge 1 — The Status Code Report

How many times did each HTTP status code appear in `access_log.csv`? Build the pipeline. Show counts sorted highest to lowest.

### Challenge 2 — Age Analysis

What is the average age of suspects in `suspects_database.csv`? 
Steps:
1. Extract the age column: `cut -d',' -f3 suspects_database.csv`
2. Remove the header row
3. Use `sort -n` to sort numerically
4. Use `head` and `tail` to find youngest and oldest

### Challenge 3 — The Pipeline Challenge

Using a single pipeline, find how many suspects work in "Technology" or "IT Security" departments. (Hint: `grep`, `cut`, `grep -c`)

### Challenge 4 — Word Frequency

Which word in `word_scramble.txt` appears most often?
```bash
sort playground/mission_06/word_scramble.txt | uniq -c | sort -rn | head -5
```

---

## Solutions

Solutions are in the [solutions folder](solutions/README.md).

---

## Powers Unlocked

| Command | What It Does |
|---------|-------------|
| `cmd1 \| cmd2` | Pipes output of cmd1 into cmd2 |
| `sort file` | Sort lines alphabetically |
| `sort -r file` | Sort in reverse |
| `sort -n file` | Sort numerically |
| `uniq file` | Remove consecutive duplicate lines |
| `uniq -c file` | Count occurrences |
| `wc -l file` | Count lines |
| `wc -w file` | Count words |
| `cut -d',' -f1` | Extract column 1, comma-delimited |
| `tee file` | Send output to both file and screen |

### Vocabulary

- **Pipe** — `|` connects commands; output of one = input of the next
- **Delimiter** — the character separating columns (comma, tab, space)
- **Field** — one column in structured data
- **CSV** — Comma-Separated Values — a common data format

---

*You've unlocked combo attacks. One command is good. A chain of commands is unstoppable.*

*Ready for Mission 7?*
