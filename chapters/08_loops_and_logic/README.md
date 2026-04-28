# Mission 8 — Loops & Logic

## Mission Briefing

_Briefing note_

> "Detective, the evidence room has a problem. We have 500 case photos dumped in one folder with inconsistent names — some say `IMG_0042`, some say `DSC00891`, some say `vacation pic` with a space in the middle. Finding anything is impossible.
>
> You could rename them one by one. That would take hours. You are going to write a program that renames them all in seconds.
>
> To do that, you need two new superpowers: **loops** (do something many times) and **logic** (do different things based on conditions). Together, these are the engine of all programming.
>
> This is where Terminal starts to feel fast."

With loops and logic you can write programs that would take a human days to do manually — and your computer finishes them in seconds. These are not just shell script concepts. They are the heart of Python, JavaScript, Ruby, and every other language you will ever learn.

### What You'll Learn
- `for` loops — repeat a command for each item in a list
- `while` loops — repeat as long as something is true
- `if/else` — make decisions
- `test` / `[ ]` — check conditions
- How to batch rename files automatically

---

## Your Case Files

The evidence room is waiting. Navigate to your playground folder:

```bash
cd ~/mac-cli-for-kids/playground/mission_08
ls
```

You should see:

```
photos/              ← 20 inconsistently named .txt files (your evidence photos)
renaming_rules.txt   ← the naming standard you must enforce
bulk_rename_lab/     ← starter scripts for renaming 100 practice files
.secret_code.txt     ← hidden! (find it at the end of the mission)
```

Look inside the `photos/` folder:

```bash
ls photos/
```

You will see a chaotic mix: `IMG_0042.txt`, `DSC00891.txt`, `vacation pic.txt`, `img001.txt`, and more. Some are uppercase, some lowercase, some have spaces. This is the mess you are going to fix.

Read the renaming rules:

```bash
cat renaming_rules.txt
```

That file describes the naming standard the Detective Academy uses. Your job is to write a script that enforces those rules automatically using loops and logic.

---

## The `for` Loop

A `for` loop repeats commands for each item in a list.

Basic form:

```bash
for item in apple banana cherry; do
    echo "Evidence item: $item"
done
```

Output:
```
Evidence item: apple
Evidence item: banana
Evidence item: cherry
```

The loop:
1. Sets `item` to "apple", runs the commands inside
2. Sets `item` to "banana", runs again
3. Sets `item` to "cherry", runs again
4. Stops when the list is exhausted

---

### Loop Over Numbers

```bash
for i in 1 2 3 4 5; do
    echo "Case #: $i"
done
```

Or use a range (much cleaner!):

```bash
for i in {1..10}; do
    echo "File $i processed"
done
```

Or count by 2s:

```bash
for i in {0..20..2}; do
    echo "Even number: $i"
done
```

---

### Loop Over Files

This is where things get powerful. Loop over every file matching a pattern:

```bash
for file in ~/mac-cli-for-kids/playground/mission_08/photos/*.txt; do
    echo "Found evidence: $file"
done
```

Or loop over all files in a folder:

```bash
for file in ~/mac-cli-for-kids/playground/mission_08/photos/*; do
    echo "Processing: $(basename "$file")"
done
```

`basename` strips the folder path and gives you just the filename. Very useful.

---

## `if/else` — Making Decisions

An `if` statement checks a condition and runs different code based on whether it is true or false.

```bash
case_count=12

if [ $case_count -ge 10 ]; then
    echo "Heavy caseload this week!"
else
    echo "Manageable number of cases."
fi
```

The `[ ]` is a **test**. `-ge` means "greater than or equal to." Note the spaces inside `[ ]` — they are required.

### Comparison Operators

Numbers:
| Operator | Meaning |
|----------|---------|
| `-eq` | equal to |
| `-ne` | not equal to |
| `-lt` | less than |
| `-le` | less than or equal to |
| `-gt` | greater than |
| `-ge` | greater than or equal to |

Strings:
| Operator | Meaning |
|----------|---------|
| `=` | equal (strings) |
| `!=` | not equal (strings) |
| `-z` | is empty |
| `-n` | is not empty |

Files:
| Operator | Meaning |
|----------|---------|
| `-f file` | file exists and is a regular file |
| `-d dir` | directory exists |
| `-e path` | path exists (file or directory) |

---

### `if/elif/else`

```bash
suspect_count=4

if [ $suspect_count -eq 0 ]; then
    echo "No suspects — case is cold."
elif [ $suspect_count -eq 1 ]; then
    echo "One suspect — focus your investigation."
elif [ $suspect_count -le 5 ]; then
    echo "A manageable number of suspects."
else
    echo "Too many suspects — narrow it down first."
fi
```

`elif` = "else if" — checks another condition when the first was false. You can chain as many as you need.

---

## The `while` Loop

`while` loops keep going *as long as* a condition is true.

```bash
files_processed=0

while [ $files_processed -lt 5 ]; do
    echo "Processing file $files_processed..."
    files_processed=$((files_processed + 1))
done
echo "All done!"
```

Output:
```
Processing file 0...
Processing file 1...
Processing file 2...
Processing file 3...
Processing file 4...
All done!
```

Be careful: if the condition never becomes false, the loop runs forever. Press `Ctrl+C` to stop a runaway loop.

---

## Try It! — Quick Experiments

**Experiment 1:** Count down from 10.

```bash
for i in {10..1}; do
    echo "Countdown: $i"
done
echo "Evidence room unlocked!"
```

**Experiment 2:** Check if a file exists before reading it.

```bash
report="$HOME/mac-cli-for-kids/playground/mission_08/renaming_rules.txt"

if [ -f "$report" ]; then
    echo "Rules file found!"
    wc -l "$report"
else
    echo "No rules file — check your path!"
fi
```

**Experiment 3:** Multiplication table — quick detective math.

```bash
num=7
for i in {1..12}; do
    echo "$num × $i = $((num * i))"
done
```

**Experiment 4:** Loop with a decision inside.

```bash
for i in {1..10}; do
    if [ $((i % 2)) -eq 0 ]; then
        echo "Case $i: solved (even)"
    else
        echo "Case $i: still open (odd)"
    fi
done
```

`%` is the **modulo operator** — it gives the remainder after division. `7 % 2 = 1`, `8 % 2 = 0`. If the remainder when divided by 2 is 0, the number is even.

---

## Pro Tip — `break` and `continue`

- `break` — exit the loop immediately
- `continue` — skip the rest of this iteration and jump to the next one

```bash
for i in {1..10}; do
    if [ $i -eq 5 ]; then
        echo "Skipping suspect $i (alibi confirmed)"
        continue
    fi
    if [ $i -eq 8 ]; then
        echo "Stopping at $i — all other suspects cleared"
        break
    fi
    echo "Investigating suspect $i"
done
```

Output:
```
Investigating suspect 1
Investigating suspect 2
Investigating suspect 3
Investigating suspect 4
Skipping suspect 5 (alibi confirmed)
Investigating suspect 6
Investigating suspect 7
Stopping at 8 — all other suspects cleared
```

---

## Your Mission — Evidence Photo Renamer

Write a script that automatically fixes all the inconsistently named photos in the `mission_08/photos/` folder.

The goal: every file should end up named `evidence_NNN.txt` where NNN is a three-digit number with leading zeros (001, 002, 003...). No spaces, no mixed case, just clean consistent names.

```bash
nano ~/rename_evidence.sh
```

```bash
#!/bin/bash
# rename_evidence.sh — Standardize evidence photo names
# Renames all files in a folder to evidence_001.txt, evidence_002.txt, etc.

PHOTO_DIR="$HOME/mac-cli-for-kids/playground/mission_08/photos"

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║       EVIDENCE PHOTO RENAMER             ║"
echo "╚══════════════════════════════════════════╝"
echo ""
echo "Target folder: $PHOTO_DIR"
echo ""

# Count how many files we will process
total=$(ls "$PHOTO_DIR"/*.txt 2>/dev/null | wc -l | tr -d ' ')
echo "Files to rename: $total"
echo ""

counter=1

for file in "$PHOTO_DIR"/*.txt; do
    # Skip if no .txt files exist
    [ -e "$file" ] || continue

    # Get the old filename (without the path)
    old_name=$(basename "$file")

    # Build the new name with leading zeros: 001, 002, ...
    new_name=$(printf "evidence_%03d.txt" "$counter")

    # Only rename if the name is actually changing
    if [ "$old_name" != "$new_name" ]; then
        mv "$PHOTO_DIR/$old_name" "$PHOTO_DIR/$new_name"
        echo "  Renamed: $old_name  →  $new_name"
    else
        echo "  Already correct: $old_name"
    fi

    counter=$((counter + 1))
done

echo ""
echo "Done! All $total files renamed."
echo ""
echo "New file list:"
ls "$PHOTO_DIR"
```

Save, exit, make executable, and run:

```bash
chmod +x ~/rename_evidence.sh
bash ~/rename_evidence.sh
```

Watch it blast through all 20 files in a second. Then look at the photos folder:

```bash
ls ~/mac-cli-for-kids/playground/mission_08/photos/
```

Clean, consistent, numbered. Commander Chen approves.

---

## Challenges

### Case #0801 — The Times Tables

Write a script that prints the complete times tables from 1 to 12 using a **nested loop** (a loop inside a loop):

```bash
for table in {1..12}; do
    echo "--- Table of $table ---"
    for i in {1..12}; do
        echo "  $table × $i = $((table * i))"
    done
done
```

Run it and verify the answers. This is a nested loop: the outer loop sets `table`, the inner loop runs 12 times for each value of `table`.

### Case #0802 — FizzBuzz: The Classic Detective Test

FizzBuzz is a famous programming challenge used in real job interviews. Print numbers 1 to 30, but:
- If the number is divisible by 3, print "Fizz" instead
- If divisible by 5, print "Buzz" instead
- If divisible by both 3 and 5, print "FizzBuzz" instead
- Otherwise, print the number itself

**Hint:** Use `$((n % 3))` to check divisibility. You need to check the "both" condition first — why?

### Case #0803 — Sort the Evidence by Source

Look at the filenames in `photos/` before you run your renamer. Some start with `IMG_`, some with `DSC`, some with `img`, some with `vacation`. Write a loop that **counts** how many files came from each source prefix:

```bash
cd ~/mac-cli-for-kids/playground/mission_08/photos
img_count=0
dsc_count=0
other_count=0

for file in *.txt; do
    filename=$(basename "$file")
    if [[ "$filename" == IMG_* ]] || [[ "$filename" == img* ]]; then
        img_count=$((img_count + 1))
    elif [[ "$filename" == DSC* ]]; then
        dsc_count=$((dsc_count + 1))
    else
        other_count=$((other_count + 1))
    fi
done

echo "IMG files: $img_count"
echo "DSC files: $dsc_count"
echo "Other:     $other_count"
```

(Run this before running the renamer, so the original names are still there.)

### Case #0804 — Countdown Timer

Write a script that:
1. Asks the user to enter a number of seconds for an investigation timer
2. Counts down from that number to 0, printing each second
3. Says "Time's up! Submit your findings!" (with `say`) when it reaches 0

**Hint:** Use `sleep 1` to pause for one second between counts.

### Case #0805 — Rename 100 Files Instantly

Use the bulk rename lab:

```bash
cd ~/mac-cli-for-kids/playground/mission_08/bulk_rename_lab
bash create_100_files_starter.sh
bash rename_100_files_starter.sh
ls ~/rename_100_lab | head
```

Then open the starter scripts and change the naming format from `evidence_001.txt` to your own detective style.

---

## Secret Code Hunt

You know how to loop over files in a folder and how to use `ls -a` to reveal hidden files. The `mission_08` playground contains a hidden file.

Navigate to the playground folder and list all files including hidden ones:

```bash
cd ~/mac-cli-for-kids/playground/mission_08
ls -a
```

Find the file starting with `.` and read it. That is your eighth secret code word. Write it down on your certificate sheet.

---

## Solutions

Solutions are in the [solutions folder](solutions/README.md).

---

## Powers Unlocked

| Concept | Syntax |
|---------|--------|
| For loop over list | `for item in a b c; do ... done` |
| For loop over range | `for i in {1..10}; do ... done` |
| For loop over files | `for f in folder/*.txt; do ... done` |
| While loop | `while [ condition ]; do ... done` |
| If statement | `if [ condition ]; then ... fi` |
| If/else | `if [...]; then ... else ... fi` |
| If/elif/else | `if [...]; then ... elif [...]; then ... else ... fi` |
| Number comparison | `-eq -ne -lt -le -gt -ge` |
| String comparison | `= != -z -n` |
| File test | `-f file`, `-d dir`, `-e path` |
| Arithmetic | `$((expression))` |
| Formatted numbers | `printf "%03d" $n` (zero-padded to 3 digits) |
| Skip iteration | `continue` |
| Exit loop | `break` |
| Basename | `basename "/path/to/file.txt"` → `file.txt` |

### Vocabulary

- **Loop** — a structure that repeats commands
- **Iteration** — one pass through a loop
- **Condition** — something that evaluates to true or false
- **Modulo** — `%` gives the remainder after division (`7 % 3 = 1`)
- **Nested loop** — a loop inside another loop
- **`printf`** — like `echo` but with formatting (e.g. `%03d` = 3-digit zero-padded number)

---

*Loops and logic. These are the heart of all programming — not just shell scripts, but Python, Ruby, Java, Swift, everything. Commander Chen says you are officially dangerous now.*

*Ready for Mission 9?*
