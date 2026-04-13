# Mission 8 — The Pattern Hunter

## Mission Briefing

*"The evidence photos folder is a disaster," Agent NOVA reports. "Official TDA photos mixed in with someone's vacation pictures, screenshots, and random unlabeled files. We need them sorted before the court hearing tomorrow. There are 20 files. You could do it manually… or you could write a loop."*

What if you had 500 photos to rename? Or 100 files to organize? Doing it one at a time would take forever — and that's exactly the kind of boring, repetitive task that computers are *perfect* at.

With **loops** and **logic**, you can write programs that would take a human days to do manually — and your computer does them in seconds.

**The messy photos folder is in `playground/mission_08/photos/`. Sort it with loops.**

### What You'll Learn
- `for` loops — repeat a command for each item in a list
- `while` loops — repeat as long as something is true
- `if/else` — make decisions
- `test` / `[ ]` — check conditions
- How to batch rename and organize files

---

## The `for` Loop

A `for` loop repeats commands for each item in a list:

```bash
for agent in GHOST CIPHER SWIFT; do
    echo "Briefing Agent $agent"
done
```

Output:
```
Briefing Agent GHOST
Briefing Agent CIPHER
Briefing Agent SWIFT
```

---

### Loop Over Numbers

```bash
for i in {1..5}; do
    echo "Count: $i"
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

This is where it gets powerful:

```bash
for file in playground/mission_08/photos/IMG_2024_*.txt; do
    echo "Found photo: $file"
done
```

---

## `if/else` — Making Decisions

```bash
score=85

if [ $score -ge 90 ]; then
    echo "Grade: A"
elif [ $score -ge 80 ]; then
    echo "Grade: B"
else
    echo "Grade: needs improvement"
fi
```

### Comparison Operators

Numbers: `-eq` `-ne` `-lt` `-le` `-gt` `-ge`

Files:
| Operator | Meaning |
|----------|---------|
| `-f file` | file exists and is a regular file |
| `-d dir` | directory exists |
| `-e path` | path exists (file or directory) |

---

## The `while` Loop

```bash
count=1

while [ $count -le 5 ]; do
    echo "Count: $count"
    count=$((count + 1))
done
```

Press `Ctrl+C` to stop a runaway loop!

---

## Try It! — Quick Experiments

**Experiment 1:** List all the official TDA photos:
```bash
for file in playground/mission_08/photos/IMG_2024_*.txt; do
    echo "Official: $(basename $file)"
done
```

**Experiment 2:** List the unofficial/messy files:
```bash
for file in playground/mission_08/photos/*.txt; do
    name=$(basename "$file")
    if [[ "$name" != IMG_2024_* ]]; then
        echo "Messy file: $name"
    fi
done
```

**Experiment 3:** Read the renaming rules:
```bash
cat playground/mission_08/renaming_rules.txt
```

**Experiment 4:** Countdown to the court hearing:
```bash
for i in {5..1}; do
    echo "Hours until deadline: $i"
done
echo "Case files due NOW!"
```

---

## Pro Tip — `break` and `continue`

- `break` — exit the loop immediately
- `continue` — skip to the next iteration

```bash
for i in {1..10}; do
    if [ $i -eq 5 ]; then
        continue    # skip 5
    fi
    if [ $i -eq 8 ]; then
        break       # stop at 8
    fi
    echo "Number: $i"
done
```

---

## Your Mission — Sort the Evidence Photos

**Step 1:** See the mess:
```bash
cd playground/mission_08
ls photos/
```

**Step 2:** Read the renaming rules:
```bash
cat renaming_rules.txt
```

**Step 3:** Create organized folders:
```bash
mkdir -p photos/official
mkdir -p photos/personal
mkdir -p photos/other
```

**Step 4:** Move the official TDA evidence photos with a loop:
```bash
counter=1
for file in photos/IMG_2024_*.txt; do
    new_name=$(printf "evidence_%03d.txt" $counter)
    mv "$file" "photos/official/$new_name"
    echo "Renamed: $(basename $file) → $new_name"
    counter=$((counter + 1))
done
```

**Step 5:** Move personal photos:
```bash
for file in photos/vacation_*.txt photos/birthday*.txt photos/sports_*.txt; do
    if [ -f "$file" ]; then
        mv "$file" photos/personal/
        echo "Personal: $(basename $file)"
    fi
done
```

**Step 6:** Move remaining files to other:
```bash
for file in photos/*.txt; do
    if [ -f "$file" ]; then
        mv "$file" photos/other/
        echo "Other: $(basename $file)"
    fi
done
```

**Step 7:** Check the results:
```bash
ls photos/official/
ls photos/personal/
ls photos/other/
```

**Step 8:** Find the hidden code:
```bash
ls -la
cat .secret_code.txt
```

---

## Challenges

### Challenge 1 — The Times Tables

Write a script that prints the complete multiplication tables from 1 to 12 using a nested loop:

```bash
for table in {1..12}; do
    echo "--- Table of $table ---"
    for i in {1..12}; do
        echo "  $table × $i = $((table * i))"
    done
done
```

### Challenge 2 — FizzBuzz

Print numbers 1 to 30, but:
- Divisible by 3: print "Fizz"
- Divisible by 5: print "Buzz"
- Divisible by both: print "FizzBuzz"
- Otherwise: print the number

**Hint:** `$((n % 3))` checks divisibility.

### Challenge 3 — The File Counter

Write a loop that goes through each folder in `playground/mission_08/photos/` and reports how many files are in each:

```bash
for folder in photos/official photos/personal photos/other; do
    count=$(ls "$folder" | grep -c ".")
    echo "$folder: $count files"
done
```

### Challenge 4 — Countdown Timer

Write a script that:
1. Asks the user for a number of seconds
2. Counts down to 0
3. Says "Time's up!" when done

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
| Number comparison | `-eq -ne -lt -le -gt -ge` |
| File test | `-f file`, `-d dir`, `-e path` |
| Arithmetic | `$((expression))` |
| Zero-pad numbers | `printf "%03d" 7` → `007` |
| Skip iteration | `continue` |
| Exit loop | `break` |

### Vocabulary

- **Loop** — a structure that repeats commands
- **Iteration** — one pass through a loop
- **Condition** — something that evaluates to true or false
- **Modulo** — `%` gives the remainder of division

---

*Loops and logic. These are the heart of all programming. You've got them now.*

*Ready for Mission 9?*
