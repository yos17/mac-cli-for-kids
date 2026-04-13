# Mission 8 — Loops & Logic

## Mission Briefing

What if you had 500 photos to rename? Or 100 files to organize? Doing it one at a time would take forever — and that's exactly the kind of boring, repetitive task that computers are *perfect* at.

You already know variables. Now you learn two more programming superpowers: **loops** (do something many times) and **logic** (do different things based on conditions).

With these two tools, you can write programs that would take a human days to do manually — and your computer does them in seconds.

### What You'll Learn
- `for` loops — repeat a command for each item in a list
- `while` loops — repeat as long as something is true
- `if/else` — make decisions
- `test` / `[ ]` — check conditions
- How to batch rename files and auto-organize them

---

## The `for` Loop

A `for` loop repeats commands for each item in a list.

Basic form:

```bash
for item in apple banana cherry; do
    echo "I like $item"
done
```

Output:
```
I like apple
I like banana
I like cherry
```

The loop:
1. Sets `item` to "apple", runs the commands
2. Sets `item` to "banana", runs again
3. Sets `item` to "cherry", runs again
4. Stops

---

### Loop Over Numbers

```bash
for i in 1 2 3 4 5; do
    echo "Count: $i"
done
```

Or use a range (much easier!):

```bash
for i in {1..10}; do
    echo "Number $i"
done
```

Or count by 2s:

```bash
for i in {0..20..2}; do
    echo "Even: $i"
done
```

---

### Loop Over Files

This is where it gets powerful. Loop over files matching a pattern:

```bash
for file in ~/Pictures/*.jpg; do
    echo "Found photo: $file"
done
```

Or loop over all files in a folder:

```bash
for file in ~/Downloads/*; do
    echo "Item: $file"
done
```

---

## `if/else` — Making Decisions

An `if` statement checks a condition and runs different code based on whether it's true or false.

```bash
age=12

if [ $age -ge 13 ]; then
    echo "You're a teenager!"
else
    echo "You're a kid — enjoy it!"
fi
```

The `[ ]` is a test. `-ge` means "greater than or equal to."

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
score=85

if [ $score -ge 90 ]; then
    echo "Grade: A"
elif [ $score -ge 80 ]; then
    echo "Grade: B"
elif [ $score -ge 70 ]; then
    echo "Grade: C"
else
    echo "Grade: needs improvement"
fi
```

`elif` = "else if" — checks another condition when the first was false.

---

## The `while` Loop

`while` loops keep going *as long as* a condition is true.

```bash
count=1

while [ $count -le 5 ]; do
    echo "Count: $count"
    count=$((count + 1))
done
```

Output:
```
Count: 1
Count: 2
Count: 3
Count: 4
Count: 5
```

Be careful: if the condition never becomes false, the loop runs forever! Press `Ctrl+C` to stop a runaway loop.

---

## Try It! — Quick Experiments

**Experiment 1:** Count from 10 down to 1.

```bash
for i in {10..1}; do
    echo "Countdown: $i"
done
echo "Blastoff!"
```

**Experiment 2:** Check if a file exists.

```bash
if [ -f ~/diary/journal.txt ]; then
    echo "Your diary exists!"
    wc -l ~/diary/journal.txt
else
    echo "No diary found. Run Mission 4 first!"
fi
```

**Experiment 3:** Multiplication table.

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
        echo "$i is even"
    else
        echo "$i is odd"
    fi
done
```

`%` is the modulo operator — it gives the remainder of division. `$((i % 2))` equals 0 for even numbers, 1 for odd.

---

## Pro Tip — `break` and `continue`

- `break` — exit the loop immediately
- `continue` — skip the rest of this iteration and go to the next

```bash
for i in {1..10}; do
    if [ $i -eq 5 ]; then
        echo "Skipping 5!"
        continue
    fi
    if [ $i -eq 8 ]; then
        echo "Stopping at 8!"
        break
    fi
    echo "Number: $i"
done
```

Output:
```
Number: 1
Number: 2
Number: 3
Number: 4
Skipping 5!
Number: 6
Number: 7
Stopping at 8!
```

---

## Your Mission — Batch File Organizer

Write a script that takes a messy folder and organizes photos by type.

First, create a test folder with messy fake files:

```bash
mkdir ~/test_photos
cd ~/test_photos

# Create fake photo files with different extensions
touch vacation_01.jpg vacation_02.jpg vacation_03.jpg
touch birthday_01.png birthday_02.png
touch video_summer.mp4 video_birthday.mp4
touch notes.txt shopping_list.txt
touch drawing.png art_project.heic
```

Now create the organizer script:

```bash
nano ~/test_photos/organize.sh
```

```bash
#!/bin/bash
# organize.sh — Sort files by type into subfolders
# Usage: bash organize.sh [folder]

TARGET="${1:-.}"    # Use argument, or current folder if none given

echo "Organizing files in: $TARGET"
echo ""

# Create destination folders
mkdir -p "$TARGET/Photos"
mkdir -p "$TARGET/Videos"
mkdir -p "$TARGET/Documents"
mkdir -p "$TARGET/Other"

moved=0
skipped=0

for file in "$TARGET"/*; do
    # Skip if it's a directory
    if [ -d "$file" ]; then
        continue
    fi

    # Skip this script itself
    if [ "$file" = "$TARGET/organize.sh" ]; then
        continue
    fi

    # Get the filename and extension
    filename=$(basename "$file")
    ext="${filename##*.}"   # everything after the last dot
    ext_lower=$(echo "$ext" | tr '[:upper:]' '[:lower:]')

    # Decide where it goes based on extension
    case "$ext_lower" in
        jpg|jpeg|png|gif|heic|webp)
            dest="$TARGET/Photos"
            ;;
        mp4|mov|avi|mkv|m4v)
            dest="$TARGET/Videos"
            ;;
        txt|doc|docx|pdf|pages|md)
            dest="$TARGET/Documents"
            ;;
        *)
            dest="$TARGET/Other"
            ;;
    esac

    # Move the file
    mv "$file" "$dest/"
    echo "  Moved: $filename → $(basename $dest)/"
    moved=$((moved + 1))
done

echo ""
echo "Done! Moved $moved files."
echo ""
echo "Summary:"
echo "  Photos:    $(ls "$TARGET/Photos/" | wc -l | tr -d ' ') files"
echo "  Videos:    $(ls "$TARGET/Videos/" | wc -l | tr -d ' ') files"
echo "  Documents: $(ls "$TARGET/Documents/" | wc -l | tr -d ' ') files"
echo "  Other:     $(ls "$TARGET/Other/" | wc -l | tr -d ' ') files"
```

Save, exit, and run it:

```bash
chmod +x ~/test_photos/organize.sh
bash ~/test_photos/organize.sh ~/test_photos
```

Watch it sort everything! Then check:

```bash
ls ~/test_photos/Photos/
ls ~/test_photos/Videos/
ls ~/test_photos/Documents/
```

Clean it up when done:
```bash
rm -r ~/test_photos
```

---

## Challenges

### Challenge 1 — The Times Tables

Write a script that prints the complete times tables from 1 to 12 (all 12 tables). Use a nested loop (a loop inside a loop):

```bash
for table in {1..12}; do
    echo "--- Table of $table ---"
    for i in {1..12}; do
        echo "  $table × $i = $((table * i))"
    done
done
```

Run it and check your work!

### Challenge 2 — The FizzBuzz Classic

FizzBuzz is a famous programming challenge. Print numbers 1 to 30, but:
- If the number is divisible by 3, print "Fizz" instead
- If divisible by 5, print "Buzz" instead
- If divisible by both 3 and 5, print "FizzBuzz" instead
- Otherwise, print the number

**Hint:** Use `$((n % 3))` to check divisibility.

### Challenge 3 — The File Renamer

Create a folder with 5 files named `old_file_1.txt` through `old_file_5.txt`. Write a loop that renames them to `new_file_1.txt` through `new_file_5.txt`.

**Hint:** Loop over `{1..5}` and use `mv` inside the loop.

### Challenge 4 — Countdown Timer

Write a script that:
1. Asks the user to enter a number of seconds
2. Counts down from that number to 0
3. Says "Time's up!" (with `say`) when it reaches 0

**Hint:** Use `sleep 1` to pause for 1 second between counts.

---

## Solutions

Solutions are in the [solutions folder](solutions/README.md).

---

## Powers Unlocked

| Concept | Syntax |
|---------|--------|
| For loop over list | `for item in a b c; do ... done` |
| For loop over range | `for i in {1..10}; do ... done` |
| For loop over files | `for f in folder/*; do ... done` |
| While loop | `while [ condition ]; do ... done` |
| If statement | `if [ condition ]; then ... fi` |
| If/else | `if [...]; then ... else ... fi` |
| If/elif/else | `if [...]; then ... elif [...]; then ... else ... fi` |
| Number comparison | `-eq -ne -lt -le -gt -ge` |
| String comparison | `= != -z -n` |
| File test | `-f file`, `-d dir`, `-e path` |
| Arithmetic | `$((expression))` |
| Skip iteration | `continue` |
| Exit loop | `break` |

### Vocabulary

- **Loop** — a structure that repeats commands
- **Iteration** — one pass through a loop
- **Condition** — something that evaluates to true or false
- **Modulo** — `%` gives the remainder of division (`7 % 3 = 1`)
- **Case statement** — a cleaner way to write many if/elif checks

---

*Loops and logic. These are the heart of all programming — not just shell scripts, but Python, Ruby, Java, everything. You've got them now.*

*Ready for Mission 9?*
