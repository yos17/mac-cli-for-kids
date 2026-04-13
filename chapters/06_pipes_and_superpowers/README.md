# CASE FILE #6 — The Code Breaker

**Terminal Detective Agency | Clearance Level: Senior Detective**

---

## 🔍 MISSION BRIEFING

Agent, congratulations on reaching Senior Detective clearance. This case is going to test everything you've learned.

Our network security team has intercepted three data files from the suspect's private server: an access log with 120 entries of web traffic, a text document with hidden patterns, and a database of 25 suspects. Individually, these files look like noise. But analyzed together using the right tools, they tell a complete story.

Here's what we know: somewhere in the access log is a suspicious IP address that probed our systems over 20 times. In the suspects database, five individuals share a connection to a city called "Shadowport" — and one of them is listed as WANTED. The word frequency document has a pattern in it that our analysts believe is a coded message.

Your job is to use **pipes** — the most powerful technique in Terminal — to chain commands together and cut through the noise. A single well-built pipeline can analyze 120 log entries in one second and hand you the answer directly. No scrolling. No manual counting. Just results.

**Access your case files:**
```bash
cd playground/mission_06
cat case_briefing.txt
```

---

## 📚 DETECTIVE TRAINING: Pipes & Superpowers

In action movies, the hero is never alone. They have a team — each person does one thing perfectly. The hacker cracks the code. The driver handles the car. The lookout watches the door. Together, they accomplish what none of them could do alone.

The Unix philosophy works the same way: each command does **one thing well**. The power comes from *combining* them. The `|` (pipe) connects commands together so the output of one becomes the input of the next.

Today you learn to chain commands into combos more powerful than any single command.

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

Output: `14` (or however many items you have)

Translation: "List my home folder, then count the lines." The result is the number of items in your home folder. Two simple commands, one combined result.

You can chain as many as you need:

```bash
ls ~ | sort | head -10
```

Translation: "List home folder → sort alphabetically → show first 10." Three commands, one clean pipeline.

---

## `sort` — Put Things in Order

`sort` arranges lines alphabetically or numerically. Create a sample file to practice with:

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

sort nums.txt      # alphabetical (wrong for numbers): 1, 10, 100, 2, 25
sort -n nums.txt   # numeric (correct): 1, 2, 10, 25, 100
```

**Important:** Always use `sort -n` when sorting numbers. Without it, "10" sorts before "2" because "1" comes before "2" alphabetically — just like how "10" would come before "2" in a phone book.

Sort by a specific column:

```bash
# Sort by the 2nd column, numerically, in reverse (highest first)
sort -k2 -rn scores.txt
```

---

## `uniq` — Remove Duplicates

`uniq` removes consecutive duplicate lines. It works best **after** `sort` (because `sort` puts duplicates next to each other):

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

The two "apple" and two "banana" are now just one each.

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

## `wc` — Count the Evidence

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

## `cut` — Extract Columns from Data

`cut` extracts specific columns from structured data. It's perfect for analyzing log files and databases.

Create sample data:

```bash
cat > agents.txt << 'EOF'
Rivera,active,Shadowport
Torres,inactive,Metro City
Kim,active,Harbor District
Walsh,WANTED,Shadowport
Chen,active,Northern Zone
EOF
```

Get just the names (first column):
```bash
cut -d',' -f1 agents.txt
```

Output:
```
Rivera
Torres
Kim
Walsh
Chen
```

`-d','` = the delimiter (separator) is a comma. `-f1` = field 1 (the first column).

Get names and status (columns 1 and 2):
```bash
cut -d',' -f1,2 agents.txt
```

Output:
```
Rivera,active
Torres,inactive
Kim,active
Walsh,WANTED
Chen,active
```

Get just the cities (column 3):
```bash
cut -d',' -f3 agents.txt
```

---

## Pro Tip — `tee` Splits the Pipe

Sometimes you want to see output on screen AND save it to a file at the same time. That's what `tee` does — it's like a T-junction in a pipe: the data flows both directions.

```bash
ls ~ | tee home_list.txt | wc -l
```

This: lists home folder → saves to `home_list.txt` AND shows the count on screen. Both happen at once.

Use `tee` when you're running a long analysis and want to save intermediate results:

```bash
grep "suspicious" playground/mission_06/access_log.csv | tee suspicious_entries.txt | wc -l
```

Now you know the count AND you have the full list saved to `suspicious_entries.txt`.

---

## 🧪 FIELD WORK

Time to analyze the intercepted data. These experiments build toward finding the suspect.

**Step 1: Read the case briefing**

```bash
cat playground/mission_06/case_briefing.txt
```

**Step 2: Preview the access log**

Always preview a file before doing heavy analysis — this helps you understand its structure:

```bash
cat playground/mission_06/access_log.csv | head -5
```

What columns do you see? What's the format?

**Step 3: Count total entries in the log**

```bash
wc -l playground/mission_06/access_log.csv
```

120 entries is a lot to read manually. That's why we have pipes.

**Step 4: Find the most active IP addresses**

This is the key pipeline for log analysis. Read it left to right:

```bash
cut -d',' -f2 playground/mission_06/access_log.csv | sort | uniq -c | sort -rn | head -10
```

Step by step:
1. `cut -d',' -f2` — extract column 2 (the IP address column)
2. `sort` — sort all IP addresses alphabetically (puts identical ones next to each other)
3. `uniq -c` — count how many times each IP appears
4. `sort -rn` — sort those counts from highest to lowest
5. `head -10` — show only the top 10

The IP at the very top is the most active. Does one look suspicious?

**Step 5: Investigate the suspicious IP directly**

```bash
grep "192.168.1.99" playground/mission_06/access_log.csv | wc -l
```

How many times did this IP hit our systems?

**Step 6: See what the suspicious IP was actually doing**

```bash
grep "192.168.1.99" playground/mission_06/access_log.csv | head -20
```

**Step 7: Analyze word frequency in the coded document**

The `tr` command translates characters — here we use it to put each word on its own line:

```bash
cat playground/mission_06/word_frequency.txt | tr ' ' '\n' | sort | uniq -c | sort -rn | head -10
```

Step by step:
1. `cat` — read the file
2. `tr ' ' '\n'` — replace every space with a newline (one word per line)
3. `sort` — alphabetical sort (groups identical words together)
4. `uniq -c` — count occurrences of each word
5. `sort -rn` — sort by count, highest first
6. `head -10` — show the top 10 most frequent words

Which words appear most often? Does the pattern tell you anything?

**Step 8: Analyze the suspects database**

Get a count of suspects from each city:

```bash
cut -d',' -f2 playground/mission_06/suspects_database.csv | sort | uniq -c | sort -rn
```

How many suspects are connected to "Shadowport"?

**Step 9: Find the WANTED suspect**

```bash
grep "WANTED" playground/mission_06/suspects_database.csv
```

There's your primary target. Cross-reference with the access log — do you see their name connected to that suspicious IP?

---

## 🎯 MISSION: Analyze the Data to Identify the Suspect

Use pipes to build a complete analysis report of all three intercepted files.

**Step 1: Set up your report file**

```bash
echo "======================================" > analysis_report.txt
echo "CASE #6 — CODE BREAKER ANALYSIS REPORT" >> analysis_report.txt
echo "$(date +"%A, %B %d, %Y")" >> analysis_report.txt
echo "======================================" >> analysis_report.txt
echo "" >> analysis_report.txt
```

**Step 2: Analyze the access log**

```bash
echo "--- ACCESS LOG ANALYSIS ---" >> analysis_report.txt
echo "Total entries:" >> analysis_report.txt
wc -l playground/mission_06/access_log.csv >> analysis_report.txt
echo "" >> analysis_report.txt
echo "Top 10 most active IPs:" >> analysis_report.txt
cut -d',' -f2 playground/mission_06/access_log.csv | sort | uniq -c | sort -rn | head -10 >> analysis_report.txt
echo "" >> analysis_report.txt
echo "Hits from suspicious IP (192.168.1.99):" >> analysis_report.txt
grep "192.168.1.99" playground/mission_06/access_log.csv | wc -l >> analysis_report.txt
echo "" >> analysis_report.txt
```

**Step 3: Analyze the word frequency document**

```bash
echo "--- WORD FREQUENCY ANALYSIS ---" >> analysis_report.txt
echo "Top 10 most frequent words:" >> analysis_report.txt
cat playground/mission_06/word_frequency.txt | tr ' ' '\n' | sort | uniq -c | sort -rn | head -10 >> analysis_report.txt
echo "" >> analysis_report.txt
echo "Occurrences of 'shadow':" >> analysis_report.txt
grep -o "shadow" playground/mission_06/word_frequency.txt | wc -l >> analysis_report.txt
echo "" >> analysis_report.txt
```

**Step 4: Analyze the suspects database**

```bash
echo "--- SUSPECTS DATABASE ANALYSIS ---" >> analysis_report.txt
echo "Total suspects:" >> analysis_report.txt
wc -l playground/mission_06/suspects_database.csv >> analysis_report.txt
echo "" >> analysis_report.txt
echo "Suspects by city:" >> analysis_report.txt
cut -d',' -f2 playground/mission_06/suspects_database.csv | sort | uniq -c | sort -rn >> analysis_report.txt
echo "" >> analysis_report.txt
echo "WANTED suspects:" >> analysis_report.txt
grep "WANTED" playground/mission_06/suspects_database.csv >> analysis_report.txt
echo "" >> analysis_report.txt
echo "======================================" >> analysis_report.txt
echo "END OF REPORT" >> analysis_report.txt
```

**Step 5: Read your complete report**

```bash
cat analysis_report.txt
```

**Step 6: Use `less` for comfortable reading**

```bash
less analysis_report.txt
```

**Step 7: Check report stats**

```bash
wc analysis_report.txt
```

**Step 8: Save a copy with tee while also viewing it**

```bash
cat analysis_report.txt | tee ~/case_6_report_backup.txt | wc -l
```

---

## 🏆 BONUS MISSIONS

### Bonus Mission 1 — The Leaderboard

Create a file called `scores.txt` with 8 names and scores:

```bash
cat > scores.txt << 'EOF'
Alice 95
Bob 72
Charlie 88
Diana 95
Ella 63
Frank 88
Grace 100
Hannah 72
EOF
```

Sort by score (highest first):
```bash
sort -k2 -rn scores.txt
```

Show only unique scores (no repeats):
```bash
sort -k2 -rn scores.txt | cut -d' ' -f2 | uniq
```

Who's in first place? Are there any ties?

### Bonus Mission 2 — Word Count Race

Count the number of words in three different sources:
```bash
wc -w playground/mission_06/word_frequency.txt
wc -w playground/mission_06/suspects_database.csv
wc -l /usr/share/dict/words
```

Which has the most words?

### Bonus Mission 3 — The One-Line Pipeline Challenge

Using a single pipeline (commands connected with `|`), solve this:
"Find all `.txt` files in the mission_06 folder, sort them by name, and count how many there are."

No intermediate files — one line, all pipes. Hint: you'll need `find`, `sort`, and `wc`.

### Bonus Mission 4 — Top Extensions

What are the top 5 most common file types (extensions) in your home folder? Build the pipeline:

```bash
find ~ -type f 2>/dev/null | grep -o "\.[a-zA-Z]*$" | sort | uniq -c | sort -rn | head -5
```

Step by step:
1. `find ~ -type f 2>/dev/null` — find all files (suppress errors)
2. `grep -o "\.[a-zA-Z]*$"` — extract just the extension from each filename
3. `sort` — group identical extensions
4. `uniq -c` — count each extension
5. `sort -rn` — sort by count, highest first
6. `head -5` — show top 5

What file types do you have most of?

### Bonus Mission 5 — Diary Word Frequency

Analyze your own detective journal:

```bash
cat ~/diary/journal.txt | tr ' ' '\n' | tr '[:upper:]' '[:lower:]' | grep -v "^$" | sort | uniq -c | sort -rn | head -20
```

Step by step:
1. `cat ~/diary/journal.txt` — read your journal
2. `tr ' ' '\n'` — one word per line
3. `tr '[:upper:]' '[:lower:]'` — make everything lowercase (so "The" and "the" count together)
4. `grep -v "^$"` — remove empty lines (`-v` means "exclude")
5. `sort` — group identical words
6. `uniq -c` — count each word
7. `sort -rn` — sort by frequency
8. `head -20` — show top 20

What words do you write most often? Interesting, right?

---

## 🔐 CODE PIECE UNLOCKED!

Incredible analysis work, Agent. You identified the suspicious IP, found the WANTED suspect, and decoded the word frequency pattern — all with pipes.

**Code Piece #6: CODE**

```bash
cat playground/mission_06/secret_code_piece.txt
```

You now have four code pieces. Keep collecting them.

---

## ⚡ POWERS UNLOCKED

| Command | What It Does |
|---------|-------------|
| `cmd1 \| cmd2` | Pipes output of cmd1 into cmd2 |
| `sort file` | Sort lines alphabetically |
| `sort -r file` | Sort in reverse order |
| `sort -n file` | Sort numerically (correct for numbers) |
| `sort -k2 file` | Sort by the 2nd column |
| `sort -rn file` | Sort numerically, reversed (highest first) |
| `uniq file` | Remove consecutive duplicate lines |
| `uniq -c file` | Count occurrences of each unique line |
| `wc -l file` | Count lines |
| `wc -w file` | Count words |
| `wc -c file` | Count characters |
| `cut -d',' -f1` | Extract column 1 from comma-separated data |
| `cut -d',' -f1,3` | Extract columns 1 and 3 |
| `tee file` | Send output to both file and screen |
| `tr ' ' '\n'` | Replace spaces with newlines (one word per line) |
| `tr '[:upper:]' '[:lower:]'` | Convert text to lowercase |
| `grep -v "pattern"` | Show lines that do NOT match the pattern |
| `grep -o "pattern"` | Show only the matched text, not the whole line |

### Detective Vocabulary

- **Pipe** — `|` connects commands; output of one becomes input of the next
- **Delimiter** — the character that separates columns in data (comma, tab, space)
- **Field** — one column in structured data
- **tee** — splits a pipeline so data goes to both a file and the next command
- **tr** — translate: replace one character with another throughout a stream
- **Pipeline** — a chain of commands connected by pipes, working as a team
- **Word frequency** — counting how many times each word appears in a text

---

*You've unlocked combo attacks. One command is good. A chain of commands is unstoppable. And now you're building the kind of analysis pipelines that real security investigators use every day.*

*Code pieces collected: #4 (AN), #5 (ELITE), #6 (CODE). Ready for Case #7?*
