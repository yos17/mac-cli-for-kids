# Mission 4 — Reading & Writing

## Mission Briefing

_Briefing note_

> "Agent, you've explored the file system and learned to organize it. Now comes one of the most critical skills in detective work: reading evidence carefully, and writing your findings down accurately. Today you master reading files — from quick peeks to scrolling through massive logs — and writing to files, from a single line to a full case diary. We've intercepted some encrypted materials in your playground folder. Your tools today will help you decode and document them. Pay attention to the difference between `>` and `>>`. Getting that wrong can erase an entire case file. Don't say I didn't warn you."

Everything in Terminal is either reading or writing. You read files to see what's in them. You write to files to save things. Today you master both.

You'll also crack an actual encoded message hidden in your case files — and build a **case diary** that lives entirely in Terminal.

### What You'll Learn
- `cat` — display a file's contents
- `less` — scroll through big files
- `head` and `tail` — see the beginning or end of a file
- `echo` with `>` and `>>` — write to files
- How to build a detective case diary

---

## Your Case Files

Navigate to your mission playground:

```bash
cd ~/mac-cli-for-kids/playground/mission_04
ls
```

You should see:

```
diary_entries/   encrypted_clue.txt   suspects.txt   secret_diary_starter.sh
```

Inside `diary_entries/` you'll find seven days of diary entries: `day_01.txt` through `day_07.txt`. The `suspects.txt` file has a list of persons of interest. `secret_diary_starter.sh` is a small scaffold you can run later with `bash secret_diary_starter.sh`. And `encrypted_clue.txt` contains something encoded — you'll need a special command to decode it.

```bash
ls diary_entries/
```

Output:
```
day_01.txt  day_02.txt  day_03.txt  day_04.txt  day_05.txt  day_06.txt  day_07.txt
```

Seven days of evidence. Let's learn how to read it all.

---

## Reading Files

### `cat` — Display a File

First, create a sample file to work with:

```bash
echo "Day 1: The suspect was seen near the docks." > sample.txt
echo "Day 2: A second witness came forward." >> sample.txt
echo "Day 3: The trail leads to the warehouse." >> sample.txt
```

(We'll explain `>` and `>>` in a moment — just run these for now.)

Now read it:

```bash
cat sample.txt
```

Output:
```
Day 1: The suspect was seen near the docks.
Day 2: A second witness came forward.
Day 3: The trail leads to the warehouse.
```

`cat` stands for "concatenate" — its original job was to join files together. But reading a single file is its most common use.

Display with line numbers:

```bash
cat -n sample.txt
```

Output:
```
     1	Day 1: The suspect was seen near the docks.
     2	Day 2: A second witness came forward.
     3	The trail leads to the warehouse.
```

Join two files together (the original purpose!):

```bash
echo "Clue A: footprints." > clue_a.txt
echo "Clue B: fingerprints." > clue_b.txt
cat clue_a.txt clue_b.txt
```

Output:
```
Clue A: footprints.
Clue B: fingerprints.
```

---

### `less` — Scroll Through Big Files

`cat` dumps everything at once. For big files, you want `less`:

```bash
less /usr/share/dict/words
```

This opens a huge dictionary file! Now:
- Press `Space` or `f` to go forward a page
- Press `b` to go back a page
- Press `/` and type a word to search for it
- Press `n` to find the next match
- Press `q` to quit

`less` is essential for reading long logs, lengthy reports, or any file that doesn't fit on screen. Try it on the diary too:

```bash
less ~/mac-cli-for-kids/playground/mission_04/diary_entries/day_01.txt
```

---

### `head` — See the Beginning

```bash
head sample.txt
```

Shows the first 10 lines (default). Show a specific number:

```bash
head -2 sample.txt
```

Output:
```
Day 1: The suspect was seen near the docks.
Day 2: A second witness came forward.
```

`head` is great for peeking at a file without reading all of it. Very useful when you have a file with hundreds of lines and just want to see what kind of data is in it — like scanning the top of a long witness statement.

---

### `tail` — See the End

```bash
tail sample.txt
```

Shows the last 10 lines. Show a specific number:

```bash
tail -1 sample.txt
```

Output:
```
Day 3: The trail leads to the warehouse.
```

**Bonus — Watch a file update in real time:**

```bash
tail -f /var/log/system.log
```

The `-f` flag means "follow" — it stays open and shows new lines as they're added. This is how programmers watch their programs run. Press `Ctrl+C` to stop.

---

## Writing to Files

### `>` — Write (overwrite)

```bash
echo "Suspect identified: unknown." > case_status.txt
cat case_status.txt
```

Output:
```
Suspect identified: unknown.
```

The `>` takes the output of the command on the left and saves it to the file on the right.

**Warning:** `>` completely replaces what was already in the file. Try this:

```bash
echo "First clue found" > evidence_log.txt
cat evidence_log.txt
echo "Second clue found" > evidence_log.txt
cat evidence_log.txt
```

Output (second `cat`):
```
Second clue found
```

"First clue found" is gone! The second `echo` overwrote it. In detective work, that would be a catastrophe. This is why you need `>>`.

---

### `>>` — Append (add to the end)

```bash
echo "Clue 1: footprints near the door." > evidence_log.txt
echo "Clue 2: broken window latch." >> evidence_log.txt
echo "Clue 3: muddy boot mark on the floor." >> evidence_log.txt
cat evidence_log.txt
```

Output:
```
Clue 1: footprints near the door.
Clue 2: broken window latch.
Clue 3: muddy boot mark on the floor.
```

`>>` *adds* to the file instead of replacing it. This is how your case diary works — every entry gets appended without erasing what came before.

---

## The Encrypted Clue

Your playground has a special file that needs decoding:

```bash
cd ~/mac-cli-for-kids/playground/mission_04
cat encrypted_clue.txt
```

You'll see something that looks like scrambled nonsense. That's **Base64 encoding** — a way of encoding text so it can't be read without decoding it. Use this command to decode it:

```bash
cat encrypted_clue.txt | base64 --decode
```

The `|` (pipe) sends the output of `cat` into the `base64 --decode` command, which translates it back into readable text. You'll learn all about pipes in Mission 6 — for now, just run it and see what secret message is revealed!

---

## Try It! — Quick Experiments

**Experiment 1:** The accidental overwrite. Try it safely.

```bash
echo "Critical witness statement" > statement.txt
echo "Oops, overwrote the statement" > statement.txt
cat statement.txt
```

See? The first line is gone. Lesson: always use `>>` when you want to keep what's already in a file.

**Experiment 2:** Read a real file on your Mac.

```bash
cat /etc/hosts
```

This is a system file that maps website names to IP addresses. Reading it is fine — don't edit it! Detectives often examine system files for clues.

**Experiment 3:** Count characters in a clue.

```bash
echo "The treasure is buried under the old oak tree." > measure.txt
wc -c measure.txt
```

`wc -c` counts characters. We'll learn `wc` fully in Mission 6.

**Experiment 4:** Head and tail of the diary.

```bash
head -3 ~/mac-cli-for-kids/playground/mission_04/diary_entries/day_01.txt
tail -3 ~/mac-cli-for-kids/playground/mission_04/diary_entries/day_07.txt
```

What are the opening lines of day 1 and the closing lines of day 7?

---

## Pro Tip — Multiline Files with `cat`

You can write several lines to a file at once using this trick:

```bash
cat > field_notes.txt << 'EOF'
Location: Old warehouse, Dock Street.
Time: 11:45pm.
Findings: disturbed dust, single set of footprints heading east.
Weather: clear, no rain.
EOF
```

This is called a **heredoc**. The `<< 'EOF'` means "start reading input until you see EOF on its own line." Everything between the two `EOF` markers gets saved to `field_notes.txt`.

```bash
cat field_notes.txt
```

Output:
```
Location: Old warehouse, Dock Street.
Time: 11:45pm.
Findings: disturbed dust, single set of footprints heading east.
Weather: clear, no rain.
```

---

## Your Mission — Build a Case Diary

Build a detective case diary that:
1. Shows today's date as the entry header
2. Records your investigation notes
3. Saves each entry to a file so you can look back later

Here's the case diary system, command by command:

**Step 1:** Create the diary folder:
```bash
mkdir -p ~/detective_diary
```

**Step 2:** Write your first entry:
```bash
echo "=== CASE DIARY: $(date +"%A, %B %d, %Y") ===" >> ~/detective_diary/case_log.txt
echo "" >> ~/detective_diary/case_log.txt
echo "Today I learned to read and write files in Terminal." >> ~/detective_diary/case_log.txt
echo "I decoded an encrypted clue. The message read: [write what you found here]" >> ~/detective_diary/case_log.txt
echo "Suspects reviewed: [write what you read in suspects.txt]" >> ~/detective_diary/case_log.txt
echo "" >> ~/detective_diary/case_log.txt
echo "---" >> ~/detective_diary/case_log.txt
```

**Step 3:** Read your diary:
```bash
cat ~/detective_diary/case_log.txt
```

Output:
```
=== CASE DIARY: Sunday, April 13, 2026 ===

Today I learned to read and write files in Terminal.
I decoded an encrypted clue. The message read: [your finding]
Suspects reviewed: [your notes]

---
```

**Step 4:** Add another entry tomorrow (run again):
```bash
echo "=== CASE DIARY: $(date +"%A, %B %d, %Y") ===" >> ~/detective_diary/case_log.txt
echo "" >> ~/detective_diary/case_log.txt
echo "Continued the investigation. New leads found." >> ~/detective_diary/case_log.txt
echo "" >> ~/detective_diary/case_log.txt
echo "---" >> ~/detective_diary/case_log.txt
```

**Step 5:** See how many entries you have:
```bash
grep -c "^=== CASE DIARY" ~/detective_diary/case_log.txt
```

This searches for lines starting with `=== CASE DIARY` and counts them. (You'll learn `grep` fully in Mission 5.)

**Step 6 (bonus):** See just the dates from your diary:
```bash
grep "^=== CASE DIARY" ~/detective_diary/case_log.txt
```

In Mission 7, you'll turn this into a real script you can run with one command!

---

## 🔍 Secret Code Hunt

There's a hidden file in the `mission_04` playground folder. Can you find it?

```bash
cd ~/mac-cli-for-kids/playground/mission_04
ls -la
```

Spot `.secret_code.txt` among the hidden files, then read it:

```bash
cat .secret_code.txt
```

Write down word #4. You're one-third of the way through cracking the master code!

---

## Challenges

### Case #0401 — The Seven-Day Digest

Read all seven diary entries in the playground (`diary_entries/day_01.txt` through `day_07.txt`) using `cat`. Then use `>>` to write a three-sentence summary of what happened across the week into a new file called `weekly_summary.txt`. Add today's date as a header line first.

**Hint:** `cat diary_entries/day_01.txt` reads one entry. Use `>>` to append your summary lines to `weekly_summary.txt`.

### Case #0402 — Head vs Tail

Create a numbered clue list:
```bash
for i in 1 2 3 4 5 6 7 8 9 10; do
  echo "Clue number $i" >> clues.txt
done
```
(This is a sneak peek at Mission 8's loops!)

Then:
- Show only the first 3 clues with `head`
- Show only the last 3 clues with `tail`
- Show clues 4 through 7 (hint: pipe `tail` into `head`)

### Case #0403 — The Suspects File

Read the `suspects.txt` file in your playground. Then:
1. Write the first suspect's name to a new file called `prime_suspect.txt` using `>`
2. Append all other suspects' names one by one using `>>`
3. Read the completed file with `cat -n` to see the numbered list

### Case #0404 — Case Diary Entry

Write exactly 5 commands that, when run in order:
1. Add today's date as a header to `~/detective_diary/case_log.txt`
2. Add one sentence about what you did in this mission
3. Add one sentence about what you found when you decoded `encrypted_clue.txt`
4. Add a separator line `---`
5. Display the last 6 lines with `tail -6`

---

## Solutions

Solutions are in the [solutions folder](solutions/README.md).

---

## Powers Unlocked

| Command | What It Does |
|---------|-------------|
| `cat file` | Displays a file's entire contents |
| `cat -n file` | Displays with line numbers |
| `cat file1 file2` | Joins and displays two files |
| `less file` | Opens a scrollable file viewer |
| `head file` | Shows the first 10 lines |
| `head -n file` | Shows the first n lines |
| `tail file` | Shows the last 10 lines |
| `tail -f file` | Follows a file (shows new lines as added) |
| `echo "text" > file` | Writes text to a file (overwrites!) |
| `echo "text" >> file` | Appends text to a file (adds to end) |
| `base64 --decode` | Decodes base64-encoded text |

### Vocabulary

- **Overwrite** — replace a file's contents completely (`>`)
- **Append** — add to the end without deleting what's there (`>>`)
- **Heredoc** — `<< 'EOF'` ... `EOF` — a way to write multiple lines at once
- **Redirect** — `>` and `>>` redirect output into files
- **Base64** — an encoding method that scrambles text into readable-but-meaningless characters

---

*Reading and writing: the two most fundamental things a computer does. A detective who reads every file and records every finding never loses a case. You can now do both from the command line.*

*Ready for Mission 5?*
