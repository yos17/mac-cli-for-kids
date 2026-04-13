# CASE FILE #8 — The Pattern Hunter

**Terminal Detective Agency | Clearance Level: SENIOR OPERATIVE**

---

## 🔍 MISSION BRIEFING

The suspect knew exactly what they were doing.

When the Terminal Detective Agency's evidence vault was broken into, the intruder didn't steal anything. They did something worse: they scrambled everything. Thirty photo files — critical crime scene documentation from six months of investigations — are now named completely randomly. `IMG_0001.txt`, `DSC_0014.txt`, `crime_scene_photo.txt`, `blurry_image.txt`... it's chaos. No system. No order. No way to tell which file is which without opening every single one.

And there's a deadline: the investigation team needs this evidence submitted in one hour.

Renaming thirty files by hand — clicking, reading, typing, clicking again, reading again, typing again — would consume almost the entire hour. And that's before you even look at the `evidence_files` folder, which contains ten dated files you need to sort by month to build the suspect's timeline.

Manual work is exactly what the suspect is counting on. They scrambled the evidence specifically to slow down the investigation. They think chaos is their ally.

They haven't met a detective who knows loops and logic.

A single `for` loop can rename all 30 files in under a second — faster than you could blink. An `if` statement can automatically scan every evidence file and sort them into categories without you touching a single one. What would take a careful human over an hour takes your script about as long as it takes to sneeze.

Your mission today: master loops and conditional logic, then deploy them to restore order to the chaos, build the timeline, and outsmart the Pattern Hunter.

**Access your case files:**
```bash
cd playground/mission_08
```

---

## 📚 DETECTIVE TRAINING: Loops and Logic

### The `for` Loop — Repeat for Every Item

A `for` loop runs a block of commands once for each item in a list. When the list runs out, the loop stops automatically.

Basic form:
```bash
for item in apple banana cherry; do
    echo "Found: $item"
done
```

Output:
```
Found: apple
Found: banana
Found: cherry
```

How the loop works step by step:
1. Sets `item` to `"apple"`, runs everything between `do` and `done`
2. Sets `item` to `"banana"`, runs everything again
3. Sets `item` to `"cherry"`, runs everything again
4. List is empty — loop stops

The words `do` and `done` are required syntax. They mark the start and end of the **loop body** — the commands that get repeated. Don't forget `done` at the end!

The variable name (here `item`) is your choice. Call it whatever makes the code most readable:
```bash
for agent in Rivera Yamamoto Okafor; do
    echo "Agent $agent is briefed"
done

for filename in file1 file2 file3; do
    echo "Processing: $filename"
done
```

---

### Loop Over a Range of Numbers

```bash
for i in 1 2 3 4 5; do
    echo "Number: $i"
done
```

That works, but listing every number manually is tedious. Use a **range** instead:

```bash
for i in {1..10}; do
    echo "Count: $i"
done
```

`{1..10}` expands to `1 2 3 4 5 6 7 8 9 10` automatically.

**Count by steps:**
```bash
for i in {0..20..2}; do
    echo "Even: $i"       # 0, 2, 4, 6, ..., 20
done
```

**Count backwards:**
```bash
for i in {10..1}; do
    echo "Countdown: $i"
done
echo "Blastoff!"
```

**Loop with a counter variable:**
```bash
for i in {1..5}; do
    squared=$((i * i))
    echo "$i squared = $squared"
done
```

Output:
```
1 squared = 1
2 squared = 4
3 squared = 9
4 squared = 16
5 squared = 25
```

---

### Loop Over Files — The Real Power

This is where loops become a detective's most valuable weapon. Loop over every file matching a pattern:

```bash
for file in playground/mission_08/photos/*; do
    echo "Found: $file"
done
```

The `*` is a **wildcard** that matches any filename. The shell expands `playground/mission_08/photos/*` into the complete list of all files in that folder, and the loop processes them one by one.

Loop over files with a specific extension:
```bash
for file in playground/mission_08/evidence_files/*.txt; do
    echo "Evidence: $file"
done
```

Loop over multiple patterns at once:
```bash
for file in *.txt *.jpg *.png; do
    echo "Processing: $file"
done
```

**What `$file` contains:** When looping over files, `$file` holds the full path like `playground/mission_08/photos/IMG_0001.txt`. If you're inside the folder, it might be just `IMG_0001.txt`. The value depends on how you wrote the pattern.

---

### Getting the Base Filename

When the loop variable contains a full path, you often want just the filename portion. `basename` extracts it:

```bash
for file in playground/mission_08/photos/*; do
    filename=$(basename "$file")
    echo "Just the name: $filename"     # → IMG_0001.txt (no path prefix)
done
```

Always quote `"$file"` with double quotes when it might contain spaces. Filenames with spaces are common in the real world, and missing quotes will break your loop in confusing ways.

**Strip the extension:**
```bash
filename="IMG_0001.txt"
name_only="${filename%.txt}"     # Remove .txt from the end
echo "$name_only"                # → IMG_0001
```

`${variable%pattern}` removes the **shortest matching** pattern from the **end** of a variable.

**Strip a prefix:**
```bash
filename="file_20240115.txt"
date_part=${filename#file_}      # Remove "file_" from the START
date_part=${date_part%.txt}      # Remove ".txt" from the end
echo "$date_part"                # → 20240115
```

`${variable#pattern}` removes the **shortest matching** pattern from the **beginning**.

These are called **parameter expansions** — shell syntax for manipulating variable values without calling external commands. They're fast and very useful for processing filenames.

---

### Formatting Numbers with `printf`

When renaming files in sequence, you want zero-padded numbers so files sort correctly: `evidence_001.txt`, `evidence_002.txt`, not `evidence_1.txt`, `evidence_2.txt` (which sorts wrong — `evidence_10.txt` would come before `evidence_2.txt` alphabetically).

```bash
printf "evidence_%03d.txt" 1     # → evidence_001.txt
printf "evidence_%03d.txt" 9     # → evidence_009.txt
printf "evidence_%03d.txt" 14    # → evidence_014.txt
printf "evidence_%03d.txt" 100   # → evidence_100.txt
```

`%03d` = format as a **d**ecimal integer, minimum **3** digits wide, padded with **0**s.

Capture the formatted string into a variable:
```bash
counter=1
new_name=$(printf "evidence_%03d.txt" $counter)
echo "$new_name"     # → evidence_001.txt
```

This is how your batch renamer will generate properly-padded output names.

---

### Renaming Files with `mv`

`mv` moves or renames files. To rename a file:
```bash
mv "old_name.txt" "new_name.txt"
```

To rename a file to a different folder:
```bash
mv "file.txt" "folder/file.txt"
```

Inside a loop, you can rename every file systematically:
```bash
counter=1
for file in playground/mission_08/photos/*; do
    new_name=$(printf "evidence_%03d.txt" $counter)
    new_path="playground/mission_08/photos/$new_name"
    mv "$file" "$new_path"
    echo "Renamed: $(basename $file) → $new_name"
    counter=$((counter + 1))
done
```

This renames every file in the photos folder to `evidence_001.txt`, `evidence_002.txt`, etc. Thirty files in about one second.

**Always print what you're doing** (`echo "Renamed: ..."`) so you can see what the script did. If something goes wrong, you'll know where it happened.

---

### `if/else` — Making Decisions

An `if` statement checks a condition and runs different commands based on whether it's true or false.

```bash
score=85

if [ $score -ge 90 ]; then
    echo "Grade: A — excellent work, Agent!"
elif [ $score -ge 80 ]; then
    echo "Grade: B — solid performance"
elif [ $score -ge 70 ]; then
    echo "Grade: C — room to improve"
else
    echo "Needs more training"
fi
```

Breaking it down:
- `if [ condition ]; then` — check the condition; if true, run what follows
- `elif [ condition ]; then` — check another condition if the previous was false
- `else` — run this if ALL previous conditions were false
- `fi` — end the if block (`if` spelled backwards — shell scripting's favorite trick)

`[ ]` is a **test command**. It evaluates the condition and returns true or false. The spaces inside the brackets are required: `[ $score -ge 90 ]` works, but `[$score -ge 90]` fails.

---

### Comparison Operators — The Language of Conditions

Shell has different comparison operators for numbers, strings, and files. Using the wrong type causes confusing bugs.

**For numbers (use these with integers):**

| Operator | Meaning | Example |
|----------|---------|---------|
| `-eq` | equal to | `[ $count -eq 10 ]` |
| `-ne` | not equal to | `[ $count -ne 0 ]` |
| `-lt` | less than | `[ $x -lt 100 ]` |
| `-le` | less than or equal to | `[ $x -le 30 ]` |
| `-gt` | greater than | `[ $score -gt 90 ]` |
| `-ge` | greater than or equal to | `[ $score -ge 60 ]` |

**For strings (use these with text):**

| Operator | Meaning | Example |
|----------|---------|---------|
| `=` | strings are equal | `[ "$name" = "Rivera" ]` |
| `!=` | strings are NOT equal | `[ "$status" != "closed" ]` |
| `-z` | string is empty (zero length) | `[ -z "$result" ]` |
| `-n` | string is NOT empty | `[ -n "$agent" ]` |

**For files:**

| Operator | Meaning | Example |
|----------|---------|---------|
| `-f file` | exists as a regular file | `[ -f "evidence.txt" ]` |
| `-d path` | exists as a directory | `[ -d "photos/" ]` |
| `-e path` | exists (file or directory) | `[ -e "report.txt" ]` |
| `-r file` | file is readable | `[ -r "secret.txt" ]` |
| `-w file` | file is writable | `[ -w "log.txt" ]` |
| `-s file` | file is not empty (size > 0) | `[ -s "data.txt" ]` |

**Critical rule — always quote string variables:**
```bash
name="Agent Rivera"
if [ "$name" = "Agent Rivera" ]; then    # CORRECT — quoted
    echo "Match!"
fi

if [ $name = "Agent Rivera" ]; then      # BROKEN — unquoted, fails with spaces
    echo "Match!"
fi
```

An unquoted variable containing spaces gets split into multiple words, which confuses the `[ ]` test. Always use double quotes around variables in conditions.

---

### Double Brackets `[[ ]]` — The Upgraded Test

The double-bracket `[[ ]]` is a more powerful test built into zsh. It's safer with string variables and supports additional features:

**Pattern matching with wildcards:**
```bash
filename="IMG_0001.txt"
if [[ $filename == IMG_* ]]; then
    echo "This is an IMG file"
fi
```

**Check if a string contains a substring:**
```bash
content=$(cat playground/mission_08/evidence_files/file_20240115.txt)
if [[ $content == *"January"* ]]; then
    echo "January evidence found!"
fi
```

The `*` wildcards mean "any characters can appear here."

**Regular expression matching with `=~`:**
```bash
filename="evidence_007.txt"
if [[ $filename =~ evidence_[0-9]+\.txt ]]; then
    echo "This is a properly named evidence file"
fi
```

`=~` matches the right side as a regular expression. This is very powerful for validating filenames.

**Compared to `[ ]`, double brackets `[[ ]]`:**
- Don't require quoting variables (safer)
- Support `==` and `!=` with wildcards
- Support `=~` regex matching
- Support `&&` and `||` directly inside the brackets

Use `[[ ]]` when working with strings, patterns, and file content. Use `[ ]` for arithmetic comparisons (though `[[ ]]` works for those too).

---

### The `while` Loop — Repeat While True

`while` loops keep running as long as their condition stays true. The moment the condition becomes false, the loop stops.

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

When `count` reaches 6, `[ 6 -le 5 ]` is false, and the loop exits.

**WARNING — infinite loops:** If the condition never becomes false, the loop runs forever and your Terminal gets stuck. This is called an **infinite loop**. Press `Ctrl+C` immediately to stop it.

Common infinite loop mistakes:
```bash
# Forgot to increment count — will run forever!
while [ $count -le 5 ]; do
    echo "Count: $count"
    # Oops — forgot: count=$((count + 1))
done
```

**Reading a file line by line with `while`:**

```bash
while IFS= read -r line; do
    echo "Line: $line"
done < playground/mission_08/evidence_files/file_20240115.txt
```

Two important flags:
- `IFS=` — clears the Input Field Separator, preventing trimming of leading/trailing whitespace
- `-r` — raw mode, prevents backslash characters from being interpreted as escape sequences

These two flags together (`IFS= read -r`) are the correct, safe way to read files line by line. Without them, you might silently lose data from files with unusual whitespace or backslashes.

The `< filename` at the end redirects the file into the `while` loop — the loop reads from the file instead of from the keyboard.

---

### `break` and `continue` — Controlling Loop Flow

Two keywords give you precise control over loop execution:

**`break`** — exit the entire loop immediately and move to the code after `done`:
```bash
for file in playground/mission_08/evidence_files/*.txt; do
    content=$(cat "$file")
    if [[ $content == *"critical"* ]]; then
        echo "Found critical evidence: $file"
        break     # Stop searching — we found what we needed
    fi
    echo "Checked: $(basename $file)"
done
echo "Search complete"
```

Once `break` runs, the loop stops entirely. Useful when you're searching for something and don't need to keep going after finding it.

**`continue`** — skip the rest of the current iteration and jump to the next one:
```bash
for file in playground/mission_08/evidence_files/*.txt; do
    # Skip empty files
    if [ ! -s "$file" ]; then
        echo "Skipping empty file: $(basename $file)"
        continue     # Jump to next file
    fi
    echo "Processing: $(basename $file)"
    # ... process the non-empty file
done
```

`continue` skips the rest of the loop body for the current iteration but keeps the loop going. Useful for skipping files that don't meet criteria (directories in a file loop, empty files, etc.).

**Both together:**
```bash
for i in {1..10}; do
    if [ $i -eq 5 ]; then
        echo "Skipping 5 — contaminated evidence"
        continue
    fi
    if [ $i -eq 8 ]; then
        echo "Found the key piece at #8 — stopping search"
        break
    fi
    echo "Reviewing piece #$i"
done
```

Output:
```
Reviewing piece #1
Reviewing piece #2
Reviewing piece #3
Reviewing piece #4
Skipping 5 — contaminated evidence
Reviewing piece #6
Reviewing piece #7
Found the key piece at #8 — stopping search
```

---

### Logical Operators — AND and OR

Combine multiple conditions using logical operators:

- `&&` — AND (both conditions must be true)
- `||` — OR (at least one condition must be true)

```bash
month="01"
count=5

# Both must be true
if [ "$month" = "01" ] && [ $count -gt 3 ]; then
    echo "January file with 3+ entries"
fi

# Either can be true
if [ "$month" = "01" ] || [ "$month" = "03" ]; then
    echo "January or March evidence"
fi
```

Inside `[[ ]]`, you can write them more naturally:
```bash
if [[ $month == "01" && $count -gt 3 ]]; then
    echo "January file with 3+ entries"
fi
```

**NOT — negate a condition:**
```bash
# Check that a file does NOT exist
if [ ! -f "report.txt" ]; then
    echo "Report not found — creating it"
fi

# Check that a string is NOT empty
if [ ! -z "$agent_name" ]; then
    echo "Agent: $agent_name"
fi
```

The `!` before a condition inverts it (true becomes false, false becomes true).

---

### The `case` Statement — Pattern Matching Made Clean

When you need to check one variable against many possible values, a `case` statement is much cleaner than a long chain of `elif`:

```bash
ext="jpg"

case "$ext" in
    jpg|jpeg|png|gif|heic|webp)
        echo "Image file"
        ;;
    mp4|mov|avi|mkv)
        echo "Video file"
        ;;
    txt|doc|pdf|pages)
        echo "Document"
        ;;
    sh|py|rb|js)
        echo "Script/code file"
        ;;
    *)
        echo "Unknown type: $ext"
        ;;
esac
```

The structure:
- `case "$variable" in` — start the case, checking `$variable`
- `pattern)` — match if variable equals this pattern
- `pat1|pat2)` — match if variable equals pat1 OR pat2
- `;;` — end of this case branch (required after each block)
- `*)` — the default case (like `else`) — matches everything not caught above
- `esac` — end of case (`case` spelled backwards)

`case` is especially useful when you have 4+ specific values to check. Compared to if/elif chains, case statements are easier to read and maintain.

---

### Nested Loops — A Loop Inside a Loop

You can put one loop inside another. The inner loop runs completely for each iteration of the outer loop:

```bash
# Print a multiplication table
for table in {1..3}; do
    echo "--- Table of $table ---"
    for i in {1..5}; do
        echo "  $table × $i = $((table * i))"
    done
done
```

Output:
```
--- Table of 1 ---
  1 × 1 = 1
  1 × 2 = 2
  1 × 3 = 3
  1 × 4 = 4
  1 × 5 = 5
--- Table of 2 ---
  2 × 1 = 2
  2 × 2 = 4
  ...
```

For every value of `table` (1, 2, 3), the inner loop runs all the way through (1, 2, 3, 4, 5). Total iterations = 3 × 5 = 15.

Be careful with nested loops over files — if each folder has many files, it can run a very long time!

---

### The Modulo Operator — Checking Divisibility

The `%` operator gives the **remainder** after division. This is called **modulo** (or just "mod"):

```bash
echo $((10 % 3))    # → 1 (10 = 3×3 + 1, remainder is 1)
echo $((9 % 3))     # → 0 (9 = 3×3 + 0, remainder is 0)
echo $((7 % 2))     # → 1 (7 = 2×3 + 1, remainder is 1)
echo $((8 % 2))     # → 0 (8 = 2×4 + 0, remainder is 0)
```

**Key insight:** if `$((n % x))` equals 0, then n is perfectly divisible by x.
- `$((n % 2)) = 0` → n is even
- `$((n % 3)) = 0` → n is divisible by 3
- `$((n % 10)) = 0` → n is a multiple of 10

Check if a number is even or odd:
```bash
for i in {1..8}; do
    if [ $((i % 2)) -eq 0 ]; then
        echo "$i is EVEN"
    else
        echo "$i is ODD"
    fi
done
```

Modulo is used everywhere in programming — for cycling through lists, creating patterns, checking divisibility, and generating rhythmic behavior in loops.

---

### Pro Tips — Loops and Logic in Practice

**1. Always preview destructive loops with `echo` before running them.**

Before a loop that renames or deletes files, replace the actual command with `echo` to see what *would* happen:

```bash
# Preview mode — safe
for file in playground/mission_08/photos/*; do
    new_name=$(printf "evidence_%03d.txt" $counter)
    echo "WOULD RENAME: $(basename $file) → $new_name"    # Preview only!
    counter=$((counter + 1))
done

# Then once it looks right, swap echo for mv:
# mv "$file" "playground/mission_08/photos/$new_name"
```

This "dry run" habit saves you from accidentally destroying work.

**2. Handle the case where a glob matches nothing.**

If a folder is empty, `for file in folder/*` still runs once with `file` set to the literal string `folder/*`. Always check:
```bash
for file in "$PHOTOS_DIR"/*; do
    [ -f "$file" ] || continue    # Skip if not a real file
    echo "Processing: $(basename $file)"
done
```

**3. Use `counter=$((counter + 1))` for running counts.**

Declare your counter before the loop and increment it inside:
```bash
count=0
for file in "$EVIDENCE_DIR"/*.txt; do
    [ -f "$file" ] || continue
    count=$((count + 1))
done
echo "Found $count evidence files"
```

**4. Quote variables that might contain spaces — always.**

```bash
for file in "$PHOTOS_DIR"/*; do
    mv "$file" "$OUTPUT_DIR/"      # Quoted — safe with spaces
    # mv $file $OUTPUT_DIR/        # Unquoted — BREAKS with spaces
done
```

**5. Know when `for` beats `while` and vice versa.**

Use `for` when you have a known list (files, numbers, array items). Use `while` when you're reading input that streams in — like a file line by line or a command whose output you're processing. Both are valid; choosing the right one makes your code cleaner.

---

## 🧪 FIELD WORK

Time to survey the damage in the evidence department. Work through every experiment — they're building the skills you'll need for the mission.

**Read the case briefing:**
```bash
cat playground/mission_08/case_briefing.txt
```

**Survey the chaos — list the photo files:**
```bash
ls playground/mission_08/photos/
```

**Count them precisely:**
```bash
ls playground/mission_08/photos/ | wc -l
```

You should see exactly 30 files with wildly inconsistent names. Some start with `IMG_`, some with `DSC_`, some have completely random names.

**Read the renaming rules:**
```bash
cat playground/mission_08/renaming_rules.txt
```

**Look at the evidence_files folder:**
```bash
ls playground/mission_08/evidence_files/
```

Each filename contains a date: `file_20240115.txt` means January 15, 2024. You'll need to extract and analyze these dates.

---

**Experiment 1:** Loop over the photos and print just their basenames.

```bash
for file in playground/mission_08/photos/*; do
    filename=$(basename "$file")
    echo "Found: $filename"
done
```

**Experiment 2:** Preview what the renaming would look like (without actually renaming).

```bash
counter=1
for file in playground/mission_08/photos/*; do
    new_name=$(printf "evidence_%03d.txt" $counter)
    echo "$(basename $file) → $new_name"
    counter=$((counter + 1))
done
```

Run this first to preview. Make sure the mapping looks right before you commit to the rename.

**Experiment 3:** Actually rename all 30 files.

```bash
counter=1
for file in playground/mission_08/photos/*; do
    # Only process regular files (not subdirectories)
    if [ ! -f "$file" ]; then
        continue
    fi

    new_name=$(printf "evidence_%03d.txt" $counter)
    new_path="playground/mission_08/photos/$new_name"

    echo "Renaming: $(basename $file) → $new_name"
    mv "$file" "$new_path"
    counter=$((counter + 1))
done
```

After running, check the result:
```bash
ls playground/mission_08/photos/
```

All 30 files should now be named `evidence_001.txt` through `evidence_030.txt`. Alphabetically perfect. The chaos is gone.

**Experiment 4:** Extract dates from the evidence_files filenames.

```bash
for file in playground/mission_08/evidence_files/*.txt; do
    filename=$(basename "$file")
    date_part=${filename#file_}      # Remove "file_" prefix
    date_part=${date_part%.txt}      # Remove ".txt" suffix
    echo "Evidence date: $date_part"
done
```

**Experiment 5:** Extract just the month from each date.

```bash
for file in playground/mission_08/evidence_files/*.txt; do
    filename=$(basename "$file")
    date_part=${filename#file_}
    date_part=${date_part%.txt}
    # Date format: YYYYMMDD — month is characters 5-6 (0-indexed: positions 4 and 5)
    month=${date_part:4:2}
    echo "File: $filename | Month: $month"
done
```

`${variable:start:length}` extracts a **substring** — start at position `start` (zero-indexed), take `length` characters. Position 4, length 2, extracts the month from `20240115`.

**Experiment 6:** Find January files by checking file content.

```bash
for file in playground/mission_08/evidence_files/*.txt; do
    if [[ $(cat "$file") == *"January"* ]]; then
        echo "January evidence: $(basename $file)"
    fi
done
```

**Experiment 7:** Categorize files by month using conditionals.

```bash
for file in playground/mission_08/evidence_files/*.txt; do
    filename=$(basename "$file")
    date_part=${filename#file_}
    date_part=${date_part%.txt}
    month=${date_part:4:2}

    if [ "$month" = "01" ]; then
        echo "JANUARY:  $filename"
    elif [ "$month" = "02" ]; then
        echo "FEBRUARY: $filename"
    elif [ "$month" = "03" ]; then
        echo "MARCH:    $filename"
    else
        echo "OTHER:    $filename (month $month)"
    fi
done
```

**Experiment 8:** Even and odd numbers with modulo.

```bash
for i in {1..10}; do
    if [ $((i % 2)) -eq 0 ]; then
        echo "$i is EVEN"
    else
        echo "$i is ODD"
    fi
done
```

**Experiment 9:** Use `break` and `continue` — detective-style.

```bash
for i in {1..10}; do
    if [ $i -eq 5 ]; then
        echo "Piece #5 is contaminated — skipping"
        continue
    fi
    if [ $i -eq 8 ]; then
        echo "Piece #8 is the critical evidence — stopping search"
        break
    fi
    echo "Examining evidence piece #$i"
done
```

**Experiment 10:** Test a `case` statement with file extensions.

```bash
for ext in jpg txt mp4 py heic unknown; do
    case "$ext" in
        jpg|jpeg|png|gif)
            printf "%-10s → Image\n" "$ext"
            ;;
        mp4|mov|avi)
            printf "%-10s → Video\n" "$ext"
            ;;
        txt|doc|pdf)
            printf "%-10s → Document\n" "$ext"
            ;;
        py|sh|rb)
            printf "%-10s → Code\n" "$ext"
            ;;
        *)
            printf "%-10s → Unknown\n" "$ext"
            ;;
    esac
done
```

**Experiment 11:** Countdown timer with `sleep`.

```bash
for i in {5..1}; do
    echo "Detonating in $i seconds..."
    sleep 1
done
echo "BOOM! Evidence vault secured."
```

`sleep 1` pauses the script for exactly 1 second. `sleep 0.5` pauses for half a second. Useful for creating timed sequences.

**Experiment 12:** The times tables (nested loops).

```bash
for table in {1..5}; do
    echo "--- $table times table ---"
    for i in {1..10}; do
        echo "  $table × $i = $((table * i))"
    done
    echo ""
done
```

---

## 🎯 MISSION: The Complete Batch File Organizer

Write a script that handles the entire evidence department recovery:
1. Renames all photos in `playground/mission_08/photos/` to `evidence_NNN.txt` format
2. Reads through `playground/mission_08/evidence_files/` and categorizes files by month
3. Counts how many evidence files belong to each month
4. Prints a complete summary report

Create the script:
```bash
nano playground/mission_08/batch_organizer.sh
```

**Complete solution:**

```bash
#!/bin/zsh
# batch_organizer.sh — Evidence Department File Organizer
# Terminal Detective Agency — Mission 8
# Restores order to the scrambled evidence vault

PHOTOS_DIR="playground/mission_08/photos"
EVIDENCE_DIR="playground/mission_08/evidence_files"

echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║   TERMINAL DETECTIVE AGENCY                  ║"
echo "║   EVIDENCE DEPARTMENT ORGANIZER              ║"
echo "╚══════════════════════════════════════════════╝"
echo ""

# ═══════════════════════════════════════════════
# PART 1: RENAME ALL PHOTOS TO EVIDENCE FORMAT
# ═══════════════════════════════════════════════

echo "PART 1: PHOTO FILE NORMALIZATION"
echo "──────────────────────────────────────────────"
echo ""

counter=1
renamed=0
already_named=0

for file in "$PHOTOS_DIR"/*; do
    # Skip directories (only process regular files)
    if [ ! -f "$file" ]; then
        continue
    fi

    # Build the target filename with zero-padded counter
    new_name=$(printf "evidence_%03d.txt" $counter)
    new_path="$PHOTOS_DIR/$new_name"

    current_name=$(basename "$file")

    # Only rename if the file doesn't already have the right name
    if [ "$current_name" != "$new_name" ]; then
        mv "$file" "$new_path"
        printf "  Renamed: %-35s → %s\n" "$current_name" "$new_name"
        renamed=$((renamed + 1))
    else
        already_named=$((already_named + 1))
    fi

    counter=$((counter + 1))
done

total_photos=$((counter - 1))
echo ""
printf "  Files renamed:      %d\n" "$renamed"
printf "  Already correct:    %d\n" "$already_named"
printf "  Total photos:       %d\n" "$total_photos"

# ═══════════════════════════════════════════════
# PART 2: ANALYZE EVIDENCE FILES BY MONTH
# ═══════════════════════════════════════════════

echo ""
echo "──────────────────────────────────────────────"
echo ""
echo "PART 2: EVIDENCE TIMELINE ANALYSIS"
echo "──────────────────────────────────────────────"
echo ""

# Initialize month counters
january=0
february=0
march=0
other=0

for file in "$EVIDENCE_DIR"/*.txt; do
    if [ ! -f "$file" ]; then
        continue
    fi

    filename=$(basename "$file")

    # Extract the date: file_20240115.txt → 20240115
    date_part=${filename#file_}
    date_part=${date_part%.txt}

    # Extract the month (characters at positions 4-5 in YYYYMMDD)
    month=${date_part:4:2}

    # Categorize by month using conditionals
    if [ "$month" = "01" ]; then
        printf "  JANUARY  — %s\n" "$filename"
        january=$((january + 1))
    elif [ "$month" = "02" ]; then
        printf "  FEBRUARY — %s\n" "$filename"
        february=$((february + 1))
    elif [ "$month" = "03" ]; then
        printf "  MARCH    — %s\n" "$filename"
        march=$((march + 1))
    else
        printf "  OTHER    — %s (month: %s)\n" "$filename" "$month"
        other=$((other + 1))
    fi

done

# ═══════════════════════════════════════════════
# PART 3: FINAL SUMMARY REPORT
# ═══════════════════════════════════════════════

echo ""
echo "──────────────────────────────────────────────"
echo ""
echo "EVIDENCE TIMELINE SUMMARY:"
echo ""
printf "  January files:    %d\n" $january
printf "  February files:   %d\n" $february
printf "  March files:      %d\n" $march

if [ $other -gt 0 ]; then
    printf "  Other months:     %d\n" $other
fi

echo ""
total=$((january + february + march + other))
printf "  Total analyzed:   %d\n" $total
echo ""

# Determine the most active month
if [ $january -ge $february ] && [ $january -ge $march ]; then
    peak_month="January"
    peak_count=$january
elif [ $february -ge $january ] && [ $february -ge $march ]; then
    peak_month="February"
    peak_count=$february
else
    peak_month="March"
    peak_count=$march
fi

printf "  Peak activity:    %s (%d files)\n" "$peak_month" "$peak_count"
echo ""
echo "Timeline established. Order restored."
echo "The Pattern Hunter's chaos plan has failed."
echo ""
```

**Make it executable and run it:**
```bash
chmod +x playground/mission_08/batch_organizer.sh
./playground/mission_08/batch_organizer.sh
```

**Verify the photo renaming:**
```bash
ls playground/mission_08/photos/
ls playground/mission_08/photos/ | wc -l
```

**Read one of the evidence files to see its content:**
```bash
cat playground/mission_08/evidence_files/file_20240115.txt
```

Thirty files, organized in under a second. Timeline established. The Pattern Hunter never had a chance.

---

## 🏆 BONUS MISSIONS

### Bonus Mission 1 — The Complete Times Tables

Write a script that prints all 12 multiplication tables (1 through 12), each up to 12. Use a nested loop:

```bash
#!/bin/zsh
for table in {1..12}; do
    echo ""
    echo "═══ $table Times Table ═══"
    for i in {1..12}; do
        printf "  %2d × %2d = %3d\n" $table $i $((table * i))
    done
done
```

The `%2d` format pads single-digit numbers with a space so columns align perfectly. Run it and use it to practice your multiplication!

### Bonus Mission 2 — FizzBuzz: The Classic Code Challenge

FizzBuzz is one of the most famous programming problems in the world. It's asked in tech company interviews because it tests whether you actually understand loops and conditionals. Your challenge:

Print the numbers 1 to 30, but:
- If the number is divisible by 3, print `Fizz` instead
- If the number is divisible by 5, print `Buzz` instead
- If it's divisible by BOTH 3 AND 5, print `FizzBuzz` instead
- Otherwise, just print the number

**Hint:** A number is divisible by 3 if `$((n % 3))` equals 0. You'll need to check the `FizzBuzz` condition before checking `Fizz` alone and `Buzz` alone, or use `&&` for the combined check.

Try to write it completely yourself before looking at any solutions! This is genuinely the kind of thing real developers are asked.

### Bonus Mission 3 — The Rename Log and Undo

Extend your batch organizer to create a **rename log** before it renames anything. The log records the original names, so you can undo the renaming if needed:

```bash
#!/bin/zsh
PHOTOS_DIR="playground/mission_08/photos"
LOG_FILE="playground/mission_08/rename_log.txt"

# Log original names before renaming
echo "# Rename log — $(date)" > "$LOG_FILE"
counter=1
for file in "$PHOTOS_DIR"/*; do
    if [ -f "$file" ]; then
        original=$(basename "$file")
        new_name=$(printf "evidence_%03d.txt" $counter)
        echo "$new_name|$original" >> "$LOG_FILE"
        counter=$((counter + 1))
    fi
done
echo "Logged $((counter-1)) original names to $LOG_FILE"
cat "$LOG_FILE"
```

Then write an `undo_rename.sh` script that reads the log file and renames everything back to original names! (Hint: use `while IFS='|' read -r new original; do ... done < "$LOG_FILE"`)

### Bonus Mission 4 — Countdown Timer with Voice

Write a script that:
1. Asks the user for a number of seconds
2. Counts down from that number to zero, printing each second
3. Says "Time's up!" with `say` when it reaches zero

```bash
#!/bin/zsh
read -p "Enter countdown seconds: " seconds

# Validate input
if ! [[ $seconds =~ ^[0-9]+$ ]]; then
    echo "Please enter a positive number"
    exit 1
fi

echo ""
for i in $(seq $seconds -1 1); do
    printf "\r  Counting down: %d   " $i    # \r overwrites the same line
    sleep 1
done

echo ""
echo "TIME'S UP!"
say "Time's up!"
```

`seq $seconds -1 1` generates numbers from `$seconds` down to 1 in steps of -1. The `\r` character makes the cursor return to the start of the line without a newline — so the counter overwrites itself instead of printing 30 lines.

### Bonus Mission 5 — While Loop Password Guard

Write a script that requires the correct password to continue:

```bash
#!/bin/zsh
secret_code="detective2026"
attempts=0
max_attempts=3

echo ""
echo "=== TERMINAL DETECTIVE AGENCY ==="
echo "=== SECURE ACCESS REQUIRED ==="
echo ""

while true; do
    read -s -p "Enter access code: " guess
    echo ""     # Add newline since -s suppresses it
    attempts=$((attempts + 1))

    if [ "$guess" = "$secret_code" ]; then
        echo ""
        echo "Access granted. Welcome, Agent."
        echo ""
        break
    else
        remaining=$((max_attempts - attempts))
        if [ $remaining -le 0 ]; then
            echo "Too many failed attempts. Terminal locked."
            exit 1
        fi
        echo "Incorrect code. $remaining attempt(s) remaining."
    fi
done

echo "Proceeding to classified files..."
```

`read -s` makes the input silent — characters don't appear on screen. `while true` creates a loop that only exits via `break` or `exit`. The `exit 1` command terminates the entire script (the `1` means failure — `exit 0` means success).

### Bonus Mission 6 — File Type Sorter

Write a complete script that takes the renamed `evidence_001.txt` through `evidence_030.txt` files and sorts them into subfolders based on what's inside each file (you'd need to add different content to test this, or adapt it for filenames):

```bash
#!/bin/zsh
PHOTOS_DIR="playground/mission_08/photos"
mkdir -p "$PHOTOS_DIR/batch_1"     # evidence 1-10
mkdir -p "$PHOTOS_DIR/batch_2"     # evidence 11-20
mkdir -p "$PHOTOS_DIR/batch_3"     # evidence 21-30

counter=0
for file in "$PHOTOS_DIR"/evidence_*.txt; do
    [ -f "$file" ] || continue
    counter=$((counter + 1))

    if [ $counter -le 10 ]; then
        mv "$file" "$PHOTOS_DIR/batch_1/"
    elif [ $counter -le 20 ]; then
        mv "$file" "$PHOTOS_DIR/batch_2/"
    else
        mv "$file" "$PHOTOS_DIR/batch_3/"
    fi
done

echo "Sorted $counter files into 3 batches"
ls "$PHOTOS_DIR/batch_1/" | wc -l
ls "$PHOTOS_DIR/batch_2/" | wc -l
ls "$PHOTOS_DIR/batch_3/" | wc -l
```

---

## 🔐 CODE PIECE UNLOCKED!

Thirty files, renamed in a second. Ten evidence entries, sorted by month. A complete timeline assembled automatically. The Pattern Hunter scattered chaos across the entire evidence vault — and you sorted through all of it without breaking a sweat.

Loops make the impossible routine. Logic makes the complex clear. Together, they're the heart of every program ever written.

**Code Piece #8: TERMINAL**

```bash
cat playground/mission_08/secret_code_piece.txt
```

Write it down carefully. The full phrase is almost within reach.

---

## ⚡ POWERS UNLOCKED

| Concept | Syntax |
|---------|--------|
| For loop over a list | `for item in a b c; do ... done` |
| For loop over a range | `for i in {1..10}; do ... done` |
| For loop countdown | `for i in {10..1}; do ... done` |
| For loop with step | `for i in {0..20..2}; do ... done` |
| For loop over files | `for f in folder/*; do ... done` |
| While loop | `while [ condition ]; do ... done` |
| Read file line by line | `while IFS= read -r line; do ... done < file` |
| Infinite loop | `while true; do ... done` (exit with `break` or `Ctrl+C`) |
| If statement | `if [ condition ]; then ... fi` |
| If/else | `if [ condition ]; then ... else ... fi` |
| If/elif/else | `if [...]; then ... elif [...]; then ... else ... fi` |
| Number comparison operators | `-eq -ne -lt -le -gt -ge` |
| String comparison operators | `= != -z -n` |
| File test operators | `-f file`, `-d dir`, `-e path`, `-s file` |
| NOT operator | `!` inverts a condition: `if [ ! -f file ]` |
| AND operator | `&&` — both conditions must be true |
| OR operator | `\|\|` — at least one condition must be true |
| Double bracket test | `[[ condition ]]` — safer, supports patterns and regex |
| Pattern matching | `[[ $var == IMG_* ]]` |
| Substring check | `[[ $var == *"word"* ]]` |
| Regex matching | `[[ $var =~ pattern ]]` |
| Arithmetic | `$((expression))` |
| Modulo (remainder) | `$((n % 3))` — 0 means n is divisible by 3 |
| Skip iteration | `continue` |
| Exit loop | `break` |
| Exit script | `exit 0` (success) or `exit 1` (failure) |
| Case statement | `case "$var" in pattern) ... ;; esac` |
| Multiple patterns | `jpg\|jpeg\|png)` — OR in case patterns |
| Default case | `*)` — matches anything not caught above |
| Get basename | `basename "$filepath"` |
| Strip prefix | `${var#prefix}` |
| Strip suffix | `${var%suffix}` |
| Extract substring | `${var:start:length}` |
| Zero-padded numbers | `printf "evidence_%03d.txt" $counter` |
| Rename a file | `mv "old.txt" "new.txt"` |
| Pause N seconds | `sleep N` or `sleep 0.5` |
| Silent input | `read -s varname` |
| Count down a sequence | `seq $start -1 $end` |
| Overwrite same line | `printf "\r text"` |

### Detective Vocabulary

- **Loop** — a structure that repeats a block of commands
- **Iteration** — one single pass through the loop body
- **Loop body** — the commands between `do` and `done` that get repeated
- **Condition** — an expression that evaluates to either true or false
- **Modulo** — `%` gives the remainder of integer division (`7 % 3 = 1`)
- **Break** — exits the current loop entirely and continues after `done`
- **Continue** — skips to the next iteration without finishing the current one
- **Case statement** — matches a variable against multiple patterns cleanly
- **Wildcard** — `*` matches any characters in filename patterns and `[[ == ]]` comparisons
- **Nested loop** — a loop that contains another loop inside its body
- **Infinite loop** — a loop that never stops because its condition never becomes false
- **Parameter expansion** — shell syntax for manipulating variable values: `${var#prefix}`, `${var%suffix}`, `${var:start:len}`

---

*Loops and logic. These are the heartbeat of every program ever written — not just shell scripts, but Python, JavaScript, Java, Swift, everything. Every app on your phone uses these exact same concepts. Every video game, every website, every AI model.*

*You have them now. They're yours.*

*Ready for Mission 9?*
