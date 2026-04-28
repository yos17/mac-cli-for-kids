# Mission 6 — Pipes & Superpowers

## Mission Briefing — Commander Chen Speaks

*Incoming transmission...*

> "Agent, you've made it to the final foundational mission. This is where everything comes together. We have two real case files waiting for you: `access_log.csv` — a 100-line server access log from a hacked building system — and `suspects_database.csv` — 20 suspected individuals. A single command won't crack either of these. You need to chain commands together. The pipe symbol `|` is how you build those chains. Today you learn the Unix way: each command does one thing perfectly, and you combine them into something unstoppable. Let's go."

In action movies, the hero is never alone. They have a team — each person does one thing perfectly. The analyst cracks the code. The driver handles the escape. The lookout watches the door. Together, they do something none of them could do alone.

The Unix philosophy is the same idea: each command does **one thing well**. The power comes from *combining* them. The `|` (pipe) connects commands together so the output of one becomes the input of the next.

Today you learn to chain commands into combos more powerful than any single command.

### What You'll Learn
- `|` — the pipe (connect commands)
- `sort` — sort lines alphabetically or numerically
- `uniq` — remove duplicate lines
- `wc` — count words, lines, characters
- `cut` — extract columns from data
- How to analyze real case file data with command chains

> **Typing the pipe character `|`:**
> - **US keyboard:** Shift + `\` (the key above Enter or to the left of Enter)
> - **German keyboard:** Option + 7
>
> You'll type `|` constantly in this mission. Find the key now before you start.

---

## Your Case Files

Navigate to your mission playground:

```bash
cd ~/mac-cli-for-kids/playground/mission_06
ls
```

You should see:

```
access_log.csv   suspects_database.csv   word_scramble.txt
```

These are real structured data files. Let's peek at them:

```bash
head -3 access_log.csv
```

Output (something like):
```
timestamp,ip_address,method,url,status_code,bytes
2026-04-13 00:01:44,192.168.1.47,GET,/dashboard,200,4521
2026-04-13 00:03:12,10.0.0.8,POST,/login,401,312
```

The access log has 100 rows. It records who accessed what and when. And:

```bash
head -3 suspects_database.csv
```

Output (something like):
```
suspect_id,name,known_alias,last_seen_location,status
S001,Victor Kane,The Ghost,Dockside Warehouse,active
S002,Priya Nair,Cipher,Central Library,inactive
```

The suspects database has 20 rows. Your mission will use pipes to analyze both files and find connections. First, learn the tools.

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
cat > suspects_list.txt << 'EOF'
Victor Kane
Priya Nair
Marco Delgado
Priya Nair
Victor Kane
Sara Chen
EOF
```

Sort alphabetically:

```bash
sort suspects_list.txt
```

Output:
```
Marco Delgado
Priya Nair
Priya Nair
Sara Chen
Victor Kane
Victor Kane
```

Sort in reverse:

```bash
sort -r suspects_list.txt
```

Sort numbers correctly:

```bash
echo "10" > case_numbers.txt
echo "2" >> case_numbers.txt
echo "25" >> case_numbers.txt
echo "1" >> case_numbers.txt
echo "100" >> case_numbers.txt

sort case_numbers.txt        # wrong: 1, 10, 100, 2, 25 (alphabetical)
sort -n case_numbers.txt     # right: 1, 2, 10, 25, 100 (numeric)
```

---

## `uniq` — Remove Duplicates

`uniq` removes consecutive duplicate lines. It works best *after* `sort`:

```bash
sort suspects_list.txt | uniq
```

Output:
```
Marco Delgado
Priya Nair
Sara Chen
Victor Kane
```

The duplicate names are now just one each! A clean list of unique suspects.

Count how many times each name appears:

```bash
sort suspects_list.txt | uniq -c
```

Output:
```
   1 Marco Delgado
   2 Priya Nair
   1 Sara Chen
   2 Victor Kane
```

The number on the left is the count. Sort by count (most frequent first):

```bash
sort suspects_list.txt | uniq -c | sort -rn
```

This chain: sort alphabetically → count duplicates → sort by count (reverse numerical). Three commands, one powerful result. Who shows up most often?

---

## `wc` — Word Count

`wc` stands for "word count" but it counts more than words:

```bash
wc suspects_list.txt
```

Output:
```
       6     12     65 suspects_list.txt
```

Three numbers: **lines**, **words**, **characters**.

Count just lines:
```bash
wc -l suspects_list.txt
```

Count just words:
```bash
wc -w suspects_list.txt
```

Count just characters:
```bash
wc -c suspects_list.txt
```

Count the total lines in your access log (including header):
```bash
wc -l ~/mac-cli-for-kids/playground/mission_06/access_log.csv
```

How many words are in the English dictionary?
```bash
wc -l /usr/share/dict/words
```

---

## `cut` — Extract Columns

`cut` extracts specific parts of each line. It's great for structured data like CSV files.

Create sample data:

```bash
cat > witness_list.txt << 'EOF'
Alice Chen,42,Dockside
Bob Marsh,33,City Hall
Carol Diaz,28,Airport
Diana Wu,51,Warehouse
EOF
```

Get just the names (first column):

```bash
cut -d',' -f1 witness_list.txt
```

Output:
```
Alice Chen
Bob Marsh
Carol Diaz
Diana Wu
```

`-d','` = delimiter is comma. `-f1` = field 1 (first column).

Get names and locations (columns 1 and 3):

```bash
cut -d',' -f1,3 witness_list.txt
```

Output:
```
Alice Chen,Dockside
Bob Marsh,City Hall
Carol Diaz,Airport
Diana Wu,Warehouse
```

Now apply this to your real case file:

```bash
# Get just the IP addresses from the access log (column 2)
cut -d',' -f2 ~/mac-cli-for-kids/playground/mission_06/access_log.csv | head -10
```

```bash
# Get just the names from the suspects database (column 2)
cut -d',' -f2 ~/mac-cli-for-kids/playground/mission_06/suspects_database.csv
```

---

## Try It! — Quick Experiments

**Experiment 1:** Count how many access log entries use each HTTP method (GET, POST, etc.).

```bash
cut -d',' -f3 ~/mac-cli-for-kids/playground/mission_06/access_log.csv | sort | uniq -c | sort -rn
```

Translation: extract column 3 (method) → sort → count each unique value → sort by count.

**Experiment 2:** Find all unique IP addresses that appear in the access log.

```bash
cut -d',' -f2 ~/mac-cli-for-kids/playground/mission_06/access_log.csv | sort | uniq
```

**Experiment 3:** Count dictionary words starting with each letter.

```bash
grep "^a" /usr/share/dict/words | wc -l
```

How many dictionary words start with 'a'? Now try different letters.

**Experiment 4:** Build a word frequency counter using the word_scramble.txt file.

```bash
cat ~/mac-cli-for-kids/playground/mission_06/word_scramble.txt | tr ' ' '\n' | sort | uniq -c | sort -rn | head -10
```

Translation: print file → one word per line → sort → count each word → sort by frequency → show top 10.

---

## Pro Tip — `tee` Splits the Pipe

Sometimes you want to see the output AND save it to a file. That's what `tee` does — it's like a T-junction in a pipe:

```bash
cut -d',' -f2 ~/mac-cli-for-kids/playground/mission_06/access_log.csv | tee ip_list.txt | wc -l
```

This: extracts IP addresses → saves to `ip_list.txt` AND shows the count. Both happen at once.

---

## Secret Streams: Where Output Really Goes

Every command your Mac runs actually has **two voices**:

- **stdout** (standard output) — the normal voice. This is the regular results that appear on your screen and flow through pipes.
- **stderr** (standard error) — the error voice. This is where warnings and error messages go. It also shows on your screen, but it is a *separate stream* — pipes ignore it by default.

Think of it like a radio station with two frequencies. Your pipe is tuned to frequency 1 (stdout). Frequency 2 (stderr) plays in the background whether you want it or not.

In the shell, these streams have numbers:
- Stream **1** = stdout (normal output)
- Stream **2** = stderr (errors and warnings)

### What `2>&1` Does

`2>&1` means: **"send stream 2 into stream 1."** It merges the error voice into the normal voice so both flow together — through pipes, into files, wherever you send them.

```bash
some_command 2>&1
```

Read it aloud: "two greater-than ampersand one" — stderr into stdout.

### Why It Matters for Pipes

Here's the problem without it. Run this:

```bash
say -v '?'
```

Your Mac prints all available voices — but to *stderr*, not stdout. That means if you try to pipe it:

```bash
say -v '?' | head -20    # BROKEN — head gets nothing, voices go straight to screen
```

The list still flies past uncontrolled. `head -20` never sees it because the data went on stream 2 and the pipe only carries stream 1.

**The fix — merge both streams first, then pipe:**

```bash
say -v '?' 2>&1 | head -20
```

Now the voice list flows through stream 1, `head` can catch it, and you see exactly the first 20 voices — clean and controlled.

Output:
```
Agnes               en_US    # Hello, my name is Agnes.
Albert              en_US    # Hello, my name is Albert.
Alex                en_US    # Hello, my name is Alex.
Alice               it_IT    # Salve, mi chiamo Alice.
Allison             en_US    # Hello, my name is Allison.
...
```

### Other places you'll see `2>&1`

```bash
find ~ -name "*.txt" 2>&1 | wc -l        # count files, including "permission denied" messages
grep -r "secret" / 2>&1 | head -5        # search everywhere, see first 5 results
bash my_script.sh 2>&1 | tee output.log  # run a script, save ALL output (including errors)
```

### Sending stderr to the trash

Sometimes you want the *opposite* — you want to **hide** error messages and only keep normal output. Send stream 2 to `/dev/null` (the trash can of Terminal):

```bash
find ~ -name "*.txt" 2>/dev/null | wc -l
```

`2>/dev/null` redirects stderr to nowhere. Error messages disappear silently. Normal results still come through.

| What you write | What it does |
|---------------|-------------|
| `2>&1` | Merge stderr into stdout (errors flow through pipes) |
| `2>/dev/null` | Discard all errors silently |
| `> file.txt` | Redirect stdout to a file |
| `2> errors.txt` | Redirect only stderr to a file |
| `> out.txt 2>&1` | Redirect everything (stdout + stderr) to a file |

### The Rule to Remember

> If you pipe a command and the output seems to ignore your pipe — try adding `2>&1` before the `|`. The data might be on the wrong stream.

---

## Your Mission — Analyze the Case Files

Use your new pipe superpowers to crack both case files.

### Part 1: Access Log Analysis

```bash
cd ~/mac-cli-for-kids/playground/mission_06

# How many total access events are there? (subtract 1 for the header)
wc -l access_log.csv

# What are the most common status codes? (column 5)
cut -d',' -f5 access_log.csv | tail -n +2 | sort | uniq -c | sort -rn

# Which IP addresses appear most often?
cut -d',' -f2 access_log.csv | tail -n +2 | sort | uniq -c | sort -rn | head -5

# Find all failed logins (status code 401 or 403)
grep ",401,\|,403," access_log.csv

# Find all POST requests (potentially more suspicious)
grep ",POST," access_log.csv
```

`tail -n +2` skips the first line (the header row). It's a useful trick for CSV files.

### Part 2: Suspects Database Analysis

```bash
# List all active suspects
grep ",active$" suspects_database.csv | cut -d',' -f2

# List all suspects sorted by name
cut -d',' -f2 suspects_database.csv | tail -n +2 | sort

# Find suspects last seen at a specific location
grep "Warehouse" suspects_database.csv

# How many suspects are active vs inactive?
cut -d',' -f5 suspects_database.csv | tail -n +2 | sort | uniq -c
```

### Part 3: Cross-Reference

Can you find any IP addresses in the access log that might connect to suspects in the database? Look for any names that appear in both files:

```bash
grep -f <(cut -d',' -f2 suspects_database.csv | tail -n +2) access_log.csv
```

This is an advanced command — it uses one command's output as the search terms for another. Don't worry if it's complex; just run it and see what it finds.

---

## 🔍 Secret Code Hunt

This is the sixth secret code word in your playground collection. Find it:

```bash
cd ~/mac-cli-for-kids/playground/mission_06
ls -la
```

Spot `.secret_code.txt` and read it:

```bash
cat .secret_code.txt
```

Write down word #6. Once you've collected all 12 words from all 12 missions, line them up in order. They spell a secret message from Commander Chen himself. The full phrase reveals something amazing about what you've accomplished.

---

## Challenges

### Case #0601 — The Leaderboard

Create a file called `agent_scores.txt` with 8 agents and their mission scores:

```
Agent Phoenix 95
Agent Shadow 72
Agent Cipher 88
Agent Storm 95
Agent Echo 63
Agent Frost 88
Agent Nova 100
Agent Blaze 72
```

Use pipes to sort by score (highest first), then show only unique scores.

**Hint:** `sort -k3 -rn` sorts by the 3rd column, numerically, reversed.

### Case #0602 — Access Log Deep Dive

Using the `access_log.csv` in your playground, answer these three questions using pipes:

1. How many unique IP addresses appear in the log?
   - `cut -d',' -f2 access_log.csv | tail -n +2 | sort | uniq | wc -l`

2. What is the most common URL being accessed (column 4)?
   - Build a pipeline using `cut`, `sort`, `uniq -c`, and `sort -rn`

3. Which single IP address made the most requests?
   - Build a pipeline to find the top IP address by count

### Case #0603 — The Pipeline Challenge

Using a single pipeline (commands connected with `|`), solve this:
"From the `suspects_database.csv`, extract only the names of active suspects, sort them alphabetically, and count how many there are."

No intermediate files — one line, all pipes.

**Hint:** You'll use `grep`, `cut`, `sort`, and `wc -l`.

### Case #0604 — Crack the Word Scramble

Your playground has a `word_scramble.txt` file. Using pipes, find the top 5 most frequently occurring words in it:

```bash
cat word_scramble.txt | tr ' ' '\n' | tr '[:upper:]' '[:lower:]' | grep -v "^$" | sort | uniq -c | sort -rn | head -5
```

Translation: print file → one word per line → make lowercase → remove empty lines → sort → count → sort by frequency → show top 5.

What are the five most common words? Do they spell anything?

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
| `tail -n +2 file` | Skip the first line (e.g. CSV headers) |
| `cmd 2>&1` | Merge stderr into stdout so pipes can catch everything |
| `cmd 2>/dev/null` | Discard error messages silently |
| `cmd \| head -N` | Show only the first N lines of output |

### Vocabulary

- **Pipe** — `|` connects commands; output of one = input of the next
- **stdout** — standard output (stream 1); where normal results go
- **stderr** — standard error (stream 2); where error messages and warnings go
- **`2>&1`** — merge stream 2 into stream 1 so both flow together
- **`/dev/null`** — the trash can of Terminal; anything sent here disappears
- **Delimiter** — the character that separates columns in data (comma, tab, space)
- **Field** — one column in structured data
- **CSV** — Comma-Separated Values — a simple spreadsheet format readable in Terminal

---

*You've unlocked combo attacks. One command is good. A chain of commands is unstoppable. You've gone from typing `whoami` to analyzing 100-line server logs and cross-referencing suspect databases. That's not beginner work — that's detective work.*

*Collect all 12 secret code words. Line them up. See what Commander Chen has to say to you.*

*Ready for Mission 7?*
