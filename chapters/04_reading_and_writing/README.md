# Mission 4 — The Secret Diary

## Mission Briefing

*"Every good detective keeps records," says Director Chen. "Memories fade. Files don't. Your training diary is your most valuable asset — keep it safe, keep it updated."*

Everything in Terminal is either reading or writing. You read files to see what's in them. You write to files to save things. Today you master both — and you'll discover a detective's diary that tells the story of someone just like you.

**The detective's diary is in `playground/mission_04/`. Read every entry. Study the suspects. Decode the clue.**

### What You'll Learn
- `cat` — display a file's contents
- `less` — scroll through big files
- `head` and `tail` — see the beginning or end of a file
- `echo` with `>` and `>>` — write to files
- How to decode a base64 encoded message

---

## Reading Files

### `cat` — Display a File

```bash
cat welcome.txt
```

`cat` stands for "concatenate" — its original job was to join files. But reading a single file is its most common use.

Display with line numbers:

```bash
cat -n diary.txt
```

---

### `less` — Scroll Through Big Files

`cat` dumps everything at once. For longer files, use `less`:

```bash
less playground/mission_04/suspects.txt
```

Controls:
- `Space` or `f` — go forward a page
- `b` — go back a page
- `/` then type — search for a word
- `n` — find the next match
- `q` — quit

---

### `head` — See the Beginning

```bash
head suspects.txt
```

Shows the first 10 lines. Show a specific number:

```bash
head -3 suspects.txt
```

---

### `tail` — See the End

```bash
tail suspects.txt
```

Shows the last 10 lines. **Watch a file update in real time:**

```bash
tail -f /var/log/system.log
```

The `-f` flag means "follow" — stays open and shows new lines as added. Press `Ctrl+C` to stop.

---

## Writing to Files

### `>` — Write (overwrite)

```bash
echo "Case opened." > case_notes.txt
cat case_notes.txt
```

**Warning:** `>` completely replaces what was there before!

```bash
echo "First note" > my_file.txt
echo "Second note" > my_file.txt    # REPLACES first note!
cat my_file.txt
```

### `>>` — Append (add to the end)

```bash
echo "Day 1 notes." > case_notes.txt
echo "Day 2 notes." >> case_notes.txt
echo "Day 3 notes." >> case_notes.txt
cat case_notes.txt
```

`>>` *adds* to the file. This is how your own diary will work — every entry gets appended without erasing what came before.

---

## Try It! — Quick Experiments

**Experiment 1:** Read the detective's diary entries!
```bash
cd playground/mission_04/diary_entries
ls
cat day_01.txt
```

Read all 7 entries. Each one teaches you something.

**Experiment 2:** Read the suspects file:
```bash
cat playground/mission_04/suspects.txt
```

Which suspect do you think is guilty?

**Experiment 3:** The dangerous overwrite:
```bash
echo "Important evidence" > test_note.txt
echo "Oops, overwrote it" > test_note.txt
cat test_note.txt
```

See? The first line is gone. Use `>>` when you want to keep what's there!

**Experiment 4:** Peek at the encrypted clue:
```bash
cat playground/mission_04/encrypted_clue.txt
```

---

## Pro Tip — Multiline Files with `cat`

You can write several lines at once using a **heredoc**:

```bash
cat > my_notes.txt << 'EOF'
Case opened: April 13, 2026
Suspect: Unknown
Evidence: Three clues recovered
Status: Investigating
EOF
```

Everything between the two `EOF` markers gets saved to `my_notes.txt`.

---

## Your Mission — Read the Diary and Decode the Clue

**Step 1:** Navigate to the mission folder:
```bash
cd playground/mission_04
ls
```

**Step 2:** Read ALL seven diary entries:
```bash
cat diary_entries/day_01.txt
cat diary_entries/day_02.txt
# ... through day_07.txt
```

**Step 3:** Study the suspects file:
```bash
cat suspects.txt
```

**Step 4:** Read the encrypted clue instructions:
```bash
cat encrypted_clue.txt
```

**Step 5:** Decode the base64 clue:
```bash
echo "VGhlIHN1c3BlY3Qgd29yZSBhIFJFRCBoYXQgYXQgdGhlIFBBUksgb24gVFVFU0RBWQo=" | base64 -d
```

What did the suspect wear? Where were they seen? When?

**Step 6:** Start your own detective diary:
```bash
echo "=== $(date +"%A, %B %d, %Y") ===" >> ~/detective_diary.txt
echo "" >> ~/detective_diary.txt
echo "Today I read a detective's diary and decoded a secret message." >> ~/detective_diary.txt
echo "The base64 clue revealed..." >> ~/detective_diary.txt
echo "" >> ~/detective_diary.txt
echo "---" >> ~/detective_diary.txt
```

**Step 7:** Find the hidden code:
```bash
ls -la
cat .secret_code.txt
```

---

## Challenges

### Challenge 1 — The Three Case Notes

Write three case notes to a file called `~/case_notes.txt`. Use `>>` to append them one after another. Add a blank line and a `---` separator between them. Read the whole file with `cat`.

### Challenge 2 — Head vs Tail

Read `playground/mission_04/suspects.txt` using only `head` to see the first suspect, and only `tail` to see the last suspect. How many lines does each suspect entry take?

### Challenge 3 — The Diary Counter

Count how many diary entries exist:
```bash
ls playground/mission_04/diary_entries/ | grep -c "."
```

Then count lines in one entry:
```bash
cat playground/mission_04/diary_entries/day_01.txt | grep -c "."
```

### Challenge 4 — Your Diary Entry Script Preview

Write exactly 5 commands that add today's date as a header and one sentence to `~/detective_diary.txt`. Then read the last 5 lines with `tail -5 ~/detective_diary.txt`.

---

## Solutions

Solutions are in the [solutions folder](solutions/README.md).

---

## Powers Unlocked

| Command | What It Does |
|---------|-------------|
| `cat file` | Displays a file's entire contents |
| `cat -n file` | Displays with line numbers |
| `less file` | Opens a scrollable file viewer |
| `head file` | Shows the first 10 lines |
| `head -n file` | Shows the first n lines |
| `tail file` | Shows the last 10 lines |
| `tail -f file` | Follows a file (shows new lines live) |
| `echo "text" > file` | Writes text to a file (overwrites!) |
| `echo "text" >> file` | Appends text to a file (safe!) |
| `echo "base64" \| base64 -d` | Decode a base64 message |

### Vocabulary

- **Overwrite** — replace a file's contents completely (`>`)
- **Append** — add to the end without deleting what's there (`>>`)
- **Heredoc** — `<< 'EOF'` ... `EOF` — write multiple lines at once
- **base64** — text encoding (NOT encryption) that anyone can decode

---

*Reading and writing: the two most fundamental things a detective does. You can now do both from the command line.*

*Ready for Mission 5?*
