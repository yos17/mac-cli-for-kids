# Mission 6 — Pipes & Superpowers

## Mission Briefing

In action movies, the hero is never alone. They have a team — each person does one thing perfectly. The hacker cracks the code. The driver handles the car. The lookout watches the door. Together, they do something none of them could do alone.

The Unix philosophy is the same idea: each command does **one thing well**. The power comes from *combining* them. The `|` (pipe) connects commands together so the output of one becomes the input of the next.

Today you learn to chain commands into combos more powerful than any single command.

### What You'll Learn
- `|` — the pipe (connect commands)
- `sort` — sort lines alphabetically or numerically
- `uniq` — remove duplicate lines
- `wc` — count words, lines, characters
- `cut` — extract columns from data
- How to analyze files with command chains

---

## The Pipe `|`

The pipe symbol `|` (on your keyboard: hold Shift and press `\`) connects two commands. It sends the output of the command on the left as the input to the command on the right.

Without pipe:
```bash
ls ~
```
Shows all files. Now pipe it:

```bash
ls ~ | wc -l
```

Output: `14`

Translation: "List my home folder, then count the lines." The result is the number of items in your home folder.

---

## `sort` — Put Things in Order

Create a sample file:

```bash
cat > fruits.txt << 'EOF'
banana
apple
mango
cherry
grape
apple
banana
EOF
```

Sort alphabetically:

```bash
sort fruits.txt
```

Output:
```
apple
apple
banana
banana
cherry
grape
mango
```

Sort in reverse:

```bash
sort -r fruits.txt
```

Sort numbers correctly:

```bash
echo "10" > nums.txt
echo "2" >> nums.txt
echo "25" >> nums.txt
echo "1" >> nums.txt
echo "100" >> nums.txt

sort nums.txt        # wrong: 1, 10, 100, 2, 25 (alphabetical)
sort -n nums.txt     # right: 1, 2, 10, 25, 100 (numeric)
```

---

## `uniq` — Remove Duplicates

`uniq` removes consecutive duplicate lines. It works best *after* `sort`:

```bash
sort fruits.txt | uniq
```

Output:
```
apple
banana
cherry
grape
mango
```

The two "apple" and two "banana" are now just one each!

Count how many times each item appears:

```bash
sort fruits.txt | uniq -c
```

Output:
```
   2 apple
   2 banana
   1 cherry
   1 grape
   1 mango
```

The number on the left is the count. Sort by count (most common first):

```bash
sort fruits.txt | uniq -c | sort -rn
```

This chain: sort alphabetically → count duplicates → sort by count (reverse numerical). Three commands, one powerful result.

---

## `wc` — Word Count

`wc` stands for "word count" but it counts more than words:

```bash
wc fruits.txt
```

Output:
```
       7      7     53 fruits.txt
```

Three numbers: **lines**, **words**, **characters**.

Count just lines:
```bash
wc -l fruits.txt
```

Count just words:
```bash
wc -w fruits.txt
```

Count just characters:
```bash
wc -c fruits.txt
```

How many words are in the English dictionary?
```bash
wc -l /usr/share/dict/words
```

---

## `cut` — Extract Columns

`cut` extracts specific parts of each line. It's great for structured data.

Create sample data:

```bash
cat > students.txt << 'EOF'
Alice,12,A
Bob,13,B
Charlie,12,A+
Diana,14,A
Ella,11,B+
EOF
```

Get just the names (first column):

```bash
cut -d',' -f1 students.txt
```

Output:
```
Alice
Bob
Charlie
Diana
Ella
```

`-d','` = delimiter is comma. `-f1` = field 1 (first column).

Get names and grades (columns 1 and 3):

```bash
cut -d',' -f1,3 students.txt
```

Output:
```
Alice,A
Bob,B
Charlie,A+
Diana,A
Ella,B+
```

---

## Try It! — Quick Experiments

**Experiment 1:** Most common words in the dictionary.

```bash
grep "^a" /usr/share/dict/words | wc -l
```

How many dictionary words start with 'a'? Now try different letters.

**Experiment 2:** Sort your diary entries.

```bash
grep "^===" ~/diary/journal.txt | sort
```

See your diary dates in sorted order.

**Experiment 3:** Count unique word lengths.

```bash
awk '{print length}' /usr/share/dict/words | sort -n | uniq -c
```

This shows how many words are each length. (We snuck in `awk` — a powerful text tool you can explore later.)

**Experiment 4:** Build a word frequency counter.

First create a sample paragraph:
```bash
cat > paragraph.txt << 'EOF'
the quick brown fox jumps over the lazy dog the fox ran away
EOF
```

Now count each word:
```bash
tr ' ' '\n' < paragraph.txt | sort | uniq -c | sort -rn
```

Translation: replace spaces with newlines → sort → count → sort by frequency.

---

## Pro Tip — `tee` Splits the Pipe

Sometimes you want to see the output AND save it to a file. That's what `tee` does — it's like a T-junction in a pipe:

```bash
ls ~ | tee home_list.txt | wc -l
```

This: lists home folder → saves to `home_list.txt` AND shows the count. Both happen at once.

---

## Your Mission — Analyze Your Music Library or Photo Collection

Let's analyze what's on your Mac! Choose one:

### Option A — Photo Stats

```bash
# Find all images
find ~/Pictures -type f 2>/dev/null > /tmp/photos.txt
cat /tmp/photos.txt | wc -l
```

Now analyze by type:
```bash
find ~/Pictures -type f 2>/dev/null | grep -o "\.[a-zA-Z]*$" | sort | uniq -c | sort -rn
```

Translation: find photos → grab just the extension (`.jpg`, `.png`, etc.) → sort → count → sort by most common.

Example output:
```
  1423 .jpg
   287 .heic
    52 .png
    14 .gif
```

### Option B — Downloads Analysis

```bash
ls ~/Downloads | sort | head -20
```

Count by file extension:
```bash
ls ~/Downloads | grep -o "\.[a-zA-Z]*$" | sort | uniq -c | sort -rn
```

### Option C — Diary Word Frequency

```bash
# Count the most common words in your diary
cat ~/diary/journal.txt | tr ' ' '\n' | tr '[:upper:]' '[:lower:]' | grep -v "^$" | sort | uniq -c | sort -rn | head -20
```

Translation: print diary → one word per line → make lowercase → remove empty lines → sort → count → sort by frequency → show top 20.

The result tells you what words you use most often. Interesting!

---

## Challenges

### Challenge 1 — The Leaderboard

Create a file called `scores.txt` with 8 names and scores:

```
Alice 95
Bob 72
Charlie 88
Diana 95
Ella 63
Frank 88
Grace 100
Hannah 72
```

Sort by score (highest first). Then show only unique scores.

**Hint:** `sort -k2 -rn` sorts by the 2nd column, numerically, reversed.

### Challenge 2 — Word Count Race

Count the number of words in these three different sources:
1. Your `~/diary/journal.txt`
2. Any file in your Documents folder
3. `/usr/share/dict/words`

Which has the most words?

### Challenge 3 — The Pipeline Challenge

Using a single pipeline (commands connected with `|`), solve this:
"Find all `.txt` files in my home folder, sort them by name, and count how many there are."

No intermediate files — one line, all pipes.

### Challenge 4 — Top 10 Extensions

What are the top 10 most common file types (extensions) in your entire home folder? Build the pipeline. 

**Hint:** `find`, `grep -o`, `sort`, `uniq -c`, `sort -rn`, `head` — chain them all!

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
| `sort -k2 file` | Sort by the 2nd column |
| `uniq file` | Remove consecutive duplicate lines |
| `uniq -c file` | Count occurrences |
| `wc -l file` | Count lines |
| `wc -w file` | Count words |
| `wc -c file` | Count characters |
| `cut -d',' -f1` | Extract column 1, comma-delimited |
| `tee file` | Send output to both file and screen |

### Vocabulary

- **Pipe** — `|` connects commands; output of one = input of the next
- **Delimiter** — the character that separates columns in data (comma, tab, space)
- **Field** — one column in structured data

---

*You've unlocked combo attacks. One command is good. A chain of commands is unstoppable.*

*Ready for Mission 7?*
