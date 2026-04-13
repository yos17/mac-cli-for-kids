# CASE FILE #4 — The Secret Diary

**Terminal Detective Agency | Clearance Level: Junior Detective**

---

## 🔍 MISSION BRIEFING

Agent, we've caught a major break in the case.

Our surveillance team has intercepted what appears to be the primary suspect's personal diary — 10 entries spanning nearly three months. Intelligence suggests the suspect has been documenting their entire operation in these entries, including meeting locations, codenames, and most importantly: an escape plan.

The diary is encrypted in places, but our cryptography division has confirmed one section uses a simple base64 encoding that you can crack right from your terminal. There's also a list of six suspects who may be connected to the operation. Your job is to read through the evidence carefully, identify the key clues, and document your findings in your own detective notes file.

One more thing: one of the diary entries contains a piece of a secret code that could unlock something big later in your career at the Agency. Keep your eyes open for it.

**Access your case files:**
```bash
cd playground/mission_04
```

---

## 📚 DETECTIVE TRAINING: Reading & Writing Files

Every detective needs two core skills: reading evidence and writing reports. In the Terminal, those skills are `cat`, `less`, `head`, `tail`, `>`, and `>>`. Master these and no file will be able to keep its secrets from you.

---

### `cat` — Read a File Instantly

`cat` displays an entire file's contents right in your terminal. Think of it as opening a document and reading it cover to cover.

First, read your case briefing to understand what we're dealing with:

```bash
cat playground/mission_04/case_briefing.txt
```

The word "cat" stands for **concatenate** — its original job was to join multiple files together. But reading a single file is what it's used for most. Let's look at both uses.

Read a single file:
```bash
cat playground/mission_04/suspects.txt
```

Display with line numbers (useful for referencing specific lines in your report):
```bash
cat -n playground/mission_04/suspects.txt
```

Output example:
```
     1  Name: Marcus K.
     2  Last Known Location: Harbor District
     3  Status: WANTED
     ...
```

Join and display two files together (cat's original superpower):
```bash
cat playground/mission_04/diary_entries/entry_2024_01_15.txt playground/mission_04/diary_entries/entry_2024_01_28.txt
```

This shows both diary entries back to back — perfect for comparing what the suspect wrote on different dates.

---

### `less` — Scroll Through Long Files

`cat` dumps everything at once. For longer files, you want `less` — it opens a scrollable viewer so you can read at your own pace. This is perfect for reading the full diary without everything flying past you.

```bash
less playground/mission_04/suspects.txt
```

Once you're inside `less`, use these controls:

| Key | Action |
|-----|--------|
| `Space` or `f` | Move forward one page |
| `b` | Move back one page |
| `/` then a word | Search for a word |
| `n` | Jump to the next search match |
| `N` | Jump to the previous search match |
| `g` | Jump to the beginning |
| `G` | Jump to the end |
| `q` | Quit |

Try searching for a suspect name while inside `less`:
1. Press `/`
2. Type `Marcus`
3. Press Enter
4. Press `n` to find the next mention

`less` is essential for reading log files, long documents, or any file that doesn't fit on screen. Real detectives use it constantly.

---

### `head` — See the Beginning

`head` shows the first lines of a file — great for getting a quick preview before you commit to reading the whole thing.

Show the first 10 lines (default):
```bash
head playground/mission_04/diary_entries/entry_2024_02_12.txt
```

Show only the first 3 lines:
```bash
head -3 playground/mission_04/diary_entries/entry_2024_02_12.txt
```

`head` is great for peeking at a file without reading all of it. Very useful when you have dozens of files and need to identify which ones are worth reading fully.

---

### `tail` — See the End

`tail` shows the last lines of a file. Sometimes the most important information — like a final plan or a signature — is at the very end.

Show the last 10 lines (default):
```bash
tail playground/mission_04/diary_entries/entry_2024_03_05.txt
```

Show the last 3 lines:
```bash
tail -3 playground/mission_04/diary_entries/entry_2024_03_05.txt
```

**Bonus — Watch a file update in real time:**

Investigators monitoring live systems use this trick constantly:
```bash
tail -f /var/log/system.log
```

The `-f` flag means **"follow"** — the terminal stays open and shows new lines as they're added to the file. This is how programmers watch their programs run. Press `Ctrl+C` to stop following.

---

### Writing to Files: `>` and `>>`

As a detective, reading evidence is only half your job. You also need to **write up your notes** and **document your findings**. That's where `>` and `>>` come in.

#### `>` — Write (overwrite)

The `>` symbol takes whatever a command prints out and saves it to a file instead:

```bash
echo "Suspect M.K. was spotted on February 26th" > my_notes.txt
cat my_notes.txt
```

Output:
```
Suspect M.K. was spotted on February 26th
```

**Critical warning for detectives:** `>` completely replaces whatever was already in the file. Try this and watch what happens:

```bash
echo "First clue discovered" > notes_test.txt
cat notes_test.txt
echo "Second clue discovered" > notes_test.txt
cat notes_test.txt
```

Your first clue is gone! The second `echo` overwrote it. A careless detective can lose evidence this way. Always pay attention to which operator you're using.

#### `>>` — Append (add to the end)

`>>` **adds** to a file instead of replacing it. This is the safe way to build up your notes over time:

```bash
echo "Suspect M.K. was spotted on February 26th" > my_notes.txt
echo "They meet someone named 'Z'" >> my_notes.txt
echo "Meeting location: Harbor District" >> my_notes.txt
cat my_notes.txt
```

Output:
```
Suspect M.K. was spotted on February 26th
They meet someone named 'Z'
Meeting location: Harbor District
```

Every `>>` added to the file without erasing what came before. This is how your detective notes grow safely over time.

---

### Multi-line Files with `cat` and Heredoc

Sometimes you want to write several lines at once without running echo over and over. There's a neat trick for this called a **heredoc**:

```bash
cat > interview_notes.txt << 'EOF'
Witness interview - 2024-03-15
Subject: Unknown informant, goes by "Z"
Confirmed the suspect is planning to leave the country.
Meeting spot: the old lighthouse on Maple Street.
EOF
```

The `<< 'EOF'` means "start reading input until you see EOF on its own line." Everything between the two `EOF` markers gets saved to the file. Check it:

```bash
cat interview_notes.txt
```

Output:
```
Witness interview - 2024-03-15
Subject: Unknown informant, goes by "Z"
Confirmed the suspect is planning to leave the country.
Meeting spot: the old lighthouse on Maple Street.
```

Heredocs are incredibly useful when you need to write a structured report with multiple lines. No quotes to escape, no multiple echo commands — just write naturally between the markers.

---

### `wc` — Count the Evidence

`wc` stands for **word count**, but it counts more than just words. It's useful for getting a quick size estimate on evidence files.

```bash
wc playground/mission_04/suspects.txt
```

Output example:
```
      42     187    1204 suspects.txt
```

Three numbers: **lines**, **words**, **characters**.

Count just lines:
```bash
wc -l playground/mission_04/diary_entries/entry_2024_01_15.txt
```

Count just words:
```bash
wc -w playground/mission_04/diary_entries/entry_2024_01_15.txt
```

Count just characters:
```bash
wc -c playground/mission_04/encrypted_clue.txt
```

---

## 🧪 FIELD WORK

Time to dig into the actual evidence. Work through these experiments in order — they build on each other.

**Step 1: Read the case briefing first**

Before touching any evidence, a good detective always reads their briefing:

```bash
cat playground/mission_04/case_briefing.txt
```

**Step 2: Survey the diary folder**

See what evidence files we have:

```bash
ls playground/mission_04/diary_entries/
```

How many diary entries are there?
```bash
ls playground/mission_04/diary_entries/ | wc -l
```

**Step 3: Read the earliest diary entry**

```bash
cat playground/mission_04/diary_entries/entry_2024_01_15.txt
```

**Step 4: Get a quick preview of an entry**

Read only the first 3 lines of the February 12th entry:

```bash
head -3 playground/mission_04/diary_entries/entry_2024_02_12.txt
```

**Step 5: Read ALL diary entries in date order**

The `*` wildcard matches multiple files. Reading them in order reveals the timeline:

```bash
cat playground/mission_04/diary_entries/entry_*.txt
```

Watch for any mentions of travel plans, meeting locations, or unusual codenames.

**Step 6: Check the suspects list**

```bash
cat playground/mission_04/suspects.txt
```

Read it with line numbers so you can reference specific suspects by line:
```bash
cat -n playground/mission_04/suspects.txt
```

**Step 7: Crack the encrypted clue**

The suspect tried to hide this message using base64 encoding — a simple way to scramble text. Our cryptography team says you can decode it instantly:

```bash
base64 -d playground/mission_04/encrypted_clue.txt
```

Write down what it says — this could be the key to the whole case!

**Step 8: Start your detective notes**

Now document your findings:

```bash
echo "Suspect M.K. was spotted on February 26th" > my_notes.txt
echo "They meet someone named 'Z'" >> my_notes.txt
echo "Decoded message:" >> my_notes.txt
```

Add your own observations with `>>` as you read through the diary. Never use `>` after that first line, or you'll lose your previous notes!

**Step 9: Review your notes**

```bash
cat my_notes.txt
```

---

## 🎯 MISSION: Build Your Detective Notes System

Build a structured notes system using `>` and `>>` operators that documents all your findings from the diary.

**Step 1:** Create a properly structured case notes file:

```bash
echo "====================================" > case_notes.txt
echo "CASE FILE #4 — THE SECRET DIARY" >> case_notes.txt
echo "Detective Notes" >> case_notes.txt
echo "====================================" >> case_notes.txt
echo "" >> case_notes.txt
echo "DATE: $(date +"%A, %B %d, %Y")" >> case_notes.txt
echo "" >> case_notes.txt
```

**Step 2:** Add a suspects section:

```bash
echo "--- SUSPECTS ---" >> case_notes.txt
echo "Primary: Marcus K. (see suspects.txt, line 3)" >> case_notes.txt
echo "Contact: Person known as 'Z'" >> case_notes.txt
echo "" >> case_notes.txt
```

**Step 3:** Add a timeline section using a heredoc:

```bash
cat >> case_notes.txt << 'EOF'
--- TIMELINE FROM DIARY ---
January 15: First entry — suspect notes unusual activity
February 12: Mentions meeting with 'Z' at undisclosed location
February 26: Spotted in Harbor District
March 5: References an escape plan
March 18: Final entry — departure imminent?

EOF
```

**Step 4:** Add the decoded clue:

```bash
echo "--- DECODED CLUE ---" >> case_notes.txt
base64 -d playground/mission_04/encrypted_clue.txt >> case_notes.txt
echo "" >> case_notes.txt
echo "--- END OF NOTES ---" >> case_notes.txt
```

**Step 5:** Read your complete case notes:

```bash
cat case_notes.txt
```

**Step 6:** Check how much evidence you've documented:

```bash
wc -l case_notes.txt
wc -w case_notes.txt
```

**Step 7:** See just the section headers from your notes:

```bash
grep "^---" case_notes.txt
```

This searches for lines starting with `---` and shows just those. (We'll learn `grep` fully in Mission 5 — but you already got a sneak peek!)

**Bonus Step:** Add today's date entry to a running journal:

```bash
echo "=== $(date +"%A, %B %d, %Y") ===" >> ~/diary/journal.txt
echo "" >> ~/diary/journal.txt
echo "Today I cracked Case #4 and decoded an encrypted message." >> ~/diary/journal.txt
echo "Key suspect: Marcus K., contact: 'Z', location: Harbor District." >> ~/diary/journal.txt
echo "" >> ~/diary/journal.txt
echo "---" >> ~/diary/journal.txt
```

Read your journal with `cat ~/diary/journal.txt` and check how many entries you've made with `grep -c "^===" ~/diary/journal.txt`.

---

## 🏆 BONUS MISSIONS

### Bonus Mission 1 — The Three Witness Statements

Write three short witness statements (they can be made up, 2-4 lines each) to a file called `witness_statements.txt`. Use `>>` to append them one after another. Add a blank line and a `---` separator between each statement. Then read the whole file with `cat`.

### Bonus Mission 2 — Head vs Tail Investigation

Read the diary entries carefully using `head` and `tail`:

```bash
# Read first 3 lines of each entry
head -3 playground/mission_04/diary_entries/entry_2024_01_15.txt
head -3 playground/mission_04/diary_entries/entry_2024_02_26.txt

# Read last 3 lines of each entry
tail -3 playground/mission_04/diary_entries/entry_2024_01_15.txt
tail -3 playground/mission_04/diary_entries/entry_2024_02_26.txt
```

Now the tricky challenge: show lines 3 through 5 of an entry (hint: pipe `head` into `tail`):

```bash
head -5 playground/mission_04/diary_entries/entry_2024_02_12.txt | tail -3
```

### Bonus Mission 3 — The Joke Evidence File

Write a two-line "joke" to a file using `>` and `>>` where the second line is the punchline. For example:
- Line 1: "Why did the suspect always carry a pen?"
- Line 2: "Because they were always writing their own alibi!"

Use `cat` to verify the joke reads correctly.

### Bonus Mission 4 — Diary Entry Count

Add at least three entries to your journal at `~/diary/journal.txt` (use the diary commands from the mission). Then:
- See all your entry dates: `grep "^===" ~/diary/journal.txt`
- Count total entries: `grep -c "^===" ~/diary/journal.txt`
- See only the last entry: `tail -8 ~/diary/journal.txt`

---

## 🔐 CODE PIECE UNLOCKED!

Nice work, Agent. You decoded the encrypted message and documented your findings. One of the diary entries contains a piece of the secret code hidden in the case files folder.

**Code Piece #4: AN**

```bash
cat playground/mission_04/diary_entries/secret_code_piece.txt
```

Write it down — you'll need all the code pieces to unlock something at the end of your training.

---

## ⚡ POWERS UNLOCKED

| Command | What It Does |
|---------|-------------|
| `cat file` | Displays a file's entire contents |
| `cat -n file` | Displays with line numbers |
| `cat file1 file2` | Joins and displays two files |
| `less file` | Opens a scrollable file viewer |
| `head file` | Shows the first 10 lines |
| `head -n file` | Shows the first n lines |
| `tail file` | Shows the last 10 lines |
| `tail -n file` | Shows the last n lines |
| `tail -f file` | Follows a file live (shows new lines as added) |
| `echo "text" > file` | Writes text to a file (overwrites — be careful!) |
| `echo "text" >> file` | Appends text to a file (adds to end safely) |
| `cat >> file << 'EOF'` | Heredoc — write multiple lines at once |
| `wc -l file` | Counts lines in a file |
| `wc -w file` | Counts words in a file |
| `wc -c file` | Counts characters in a file |
| `base64 -d file` | Decodes a base64 encoded file |

### Detective Vocabulary

- **Overwrite** — replace a file's contents completely (`>`)
- **Append** — add to the end without deleting what's there (`>>`)
- **Heredoc** — `<< 'EOF'` ... `EOF` — a way to write multiple lines at once
- **Redirect** — `>` and `>>` redirect output into files instead of the screen
- **base64** — a simple encoding method that scrambles text into letters and numbers (easily decoded!)

---

*Reading and writing: the two most fundamental things a computer does. You've mastered both from the command line — and you've cracked an encoded message while you were at it.*

*Case #4 closed. Ready for Case #5?*
