# Mission 4 — Reading & Writing

## Mission Briefing

Everything in Terminal is either reading or writing. You read files to see what's in them. You write to files to save things. Today you master both.

You'll also create something special: a **secret diary** that lives entirely in Terminal. No app. No cloud. Just files and commands. It's yours.

### What You'll Learn
- `cat` — display a file's contents
- `less` — scroll through big files
- `head` and `tail` — see the beginning or end of a file
- `echo` with `>` and `>>` — write to files
- How to build a diary from the command line

---

## Reading Files

### `cat` — Display a File

First, create a sample file to work with:

```bash
echo "This is line one." > sample.txt
echo "This is line two." >> sample.txt
echo "This is line three." >> sample.txt
```

(We'll explain `>` and `>>` in a moment — just run these for now.)

Now read it:

```bash
cat sample.txt
```

Output:
```
This is line one.
This is line two.
This is line three.
```

`cat` stands for "concatenate" — its original job was to join files together. But reading a single file is its most common use.

Display with line numbers:

```bash
cat -n sample.txt
```

Output:
```
     1	This is line one.
     2	This is line two.
     3	This is line three.
```

Join two files together (the original purpose!):

```bash
echo "File A content." > filea.txt
echo "File B content." > fileb.txt
cat filea.txt fileb.txt
```

Output:
```
File A content.
File B content.
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

`less` is essential for reading log files, long documents, or any file that doesn't fit on screen.

---

### `head` — See the Beginning

```bash
head sample.txt
```

Shows the first 10 lines (default). Show a specific number:

```bash
head -3 sample.txt
```

Output:
```
This is line one.
This is line two.
This is line three.
```

`head` is great for peeking at a file without reading all of it. Very useful when you have a file with thousands of lines and just want to see what kind of data is in it.

---

### `tail` — See the End

```bash
tail sample.txt
```

Shows the last 10 lines. Show a specific number:

```bash
tail -2 sample.txt
```

Output:
```
This is line two.
This is line three.
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
echo "Hello!" > greeting.txt
cat greeting.txt
```

Output:
```
Hello!
```

The `>` takes the output of the command on the left and saves it to the file on the right.

**Warning:** `>` completely replaces what was already in the file. Try this:

```bash
echo "First content" > my_file.txt
cat my_file.txt
echo "Second content" > my_file.txt
cat my_file.txt
```

Output:
```
First content
---
Second content
```

"First content" is gone! The second `echo` overwrote it.

---

### `>>` — Append (add to the end)

```bash
echo "Line 1" > my_file.txt
echo "Line 2" >> my_file.txt
echo "Line 3" >> my_file.txt
cat my_file.txt
```

Output:
```
Line 1
Line 2
Line 3
```

`>>` *adds* to the file instead of replacing it. This is how your diary works — every entry gets appended to the file without erasing what came before.

---

## Try It! — Quick Experiments

**Experiment 1:** The accidental overwrite. Try it safely first.

```bash
echo "Important thing" > important.txt
echo "Oops, overwrote it" > important.txt
cat important.txt
```

See? The first line is gone. Lesson: always use `>>` when you want to keep what's already in a file.

**Experiment 2:** Read a real file on your Mac.

```bash
cat /etc/hosts
```

This is a system file that maps website names to IP addresses. Reading it is fine — don't edit it!

**Experiment 3:** How long is a line?

```bash
echo "A very long line that I want to measure for fun and learning." > measure.txt
wc -c measure.txt
```

`wc -c` counts characters. We'll learn `wc` fully in Mission 6.

**Experiment 4:** Head and tail of the dictionary.

```bash
head -5 /usr/share/dict/words
tail -5 /usr/share/dict/words
```

What are the first 5 and last 5 words in the English dictionary?

---

## Pro Tip — Multiline Files with `cat`

You can write several lines to a file at once using this trick:

```bash
cat > poem.txt << 'EOF'
Roses are red,
Violets are blue,
Terminal is cool,
And so are you.
EOF
```

This is called a **heredoc**. The `<< 'EOF'` means "start reading input until you see EOF on its own line." Everything between the two `EOF` markers gets saved to `poem.txt`.

```bash
cat poem.txt
```

Output:
```
Roses are red,
Violets are blue,
Terminal is cool,
And so are you.
```

---

## Your Mission — A Secret Terminal Diary

Build a diary that:
1. Shows today's date as the entry header
2. Asks you what happened today
3. Saves the entry to a file
4. Shows you the whole diary at the end

Here's the diary system, command by command:

**Step 1:** Create the diary folder:
```bash
mkdir -p ~/diary
```

**Step 2:** Write your first entry manually:
```bash
echo "=== $(date +"%A, %B %d, %Y") ===" >> ~/diary/journal.txt
echo "" >> ~/diary/journal.txt
echo "Today I learned how to use the Terminal." >> ~/diary/journal.txt
echo "I created files, read them, and built a diary!" >> ~/diary/journal.txt
echo "" >> ~/diary/journal.txt
echo "---" >> ~/diary/journal.txt
```

**Step 3:** Read your diary:
```bash
cat ~/diary/journal.txt
```

Output:
```
=== Sunday, April 13, 2026 ===

Today I learned how to use the Terminal.
I created files, read them, and built a diary!

---
```

**Step 4:** Add another entry tomorrow (run again):
```bash
echo "=== $(date +"%A, %B %d, %Y") ===" >> ~/diary/journal.txt
echo "" >> ~/diary/journal.txt
echo "Continued learning. Tried experiments." >> ~/diary/journal.txt
echo "" >> ~/diary/journal.txt
echo "---" >> ~/diary/journal.txt
```

**Step 5:** See how many entries you have:
```bash
grep -c "^===" ~/diary/journal.txt
```

This searches for lines starting with `===` and counts them. Each one is a diary entry. (We'll learn `grep` fully in Mission 5.)

**Step 6 (bonus):** See just the dates from your diary:
```bash
grep "^===" ~/diary/journal.txt
```

Output:
```
=== Sunday, April 13, 2026 ===
=== Monday, April 14, 2026 ===
```

In Mission 7, you'll turn this into a real script you can run with one command!

---

## Challenges

### Challenge 1 — The Three Poems

Write three short poems (they can be silly, 2-4 lines each) to a file called `poems.txt`. Use `>>` to append them one after another. Add a blank line and a `---` separator between them. Then read the whole file with `cat`.

### Challenge 2 — Head vs Tail

Create a numbered list file:
```bash
for i in 1 2 3 4 5 6 7 8 9 10; do
  echo "Item number $i" >> numbers.txt
done
```
(This is a sneak peek at Mission 8's loops!)

Then:
- Show only the first 3 items
- Show only the last 3 items
- Show items 4 through 7 (hint: pipe `tail` into `head`)

### Challenge 3 — The Secret Code

Write a sentence to a file using `>`. Then add a second sentence using `>>`. But here's the twist: write the second sentence so that it makes the whole file a joke.

For example:
- Line 1: "Why don't scientists trust atoms?"
- Line 2: "Because they make up everything!"

Use `cat` to verify the joke.

### Challenge 4 — The Diary Entry Script Preview

Write exactly 5 commands that, when run in order, add today's date as a header and one sentence to your diary. The sentence should say something real about your day. Then read the last 5 lines of your diary with `tail -5`.

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

### Vocabulary

- **Overwrite** — replace a file's contents completely (`>`)
- **Append** — add to the end without deleting what's there (`>>`)
- **Heredoc** — `<< 'EOF'` ... `EOF` — a way to write multiple lines at once
- **Redirect** — `>` and `>>` redirect output into files

---

*Reading and writing: the two most fundamental things a computer does. You can now do both from the command line.*

*Ready for Mission 5?*
