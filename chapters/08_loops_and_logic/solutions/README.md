# Mission 8 — Solutions

## Challenge 1 — The Times Tables

```bash
#!/bin/bash
for table in {1..12}; do
    echo "--- Table of $table ---"
    for i in {1..12}; do
        echo "  $table × $i = $((table * i))"
    done
    echo ""
done
```

Save as `~/tables.sh`, run with `bash ~/tables.sh`.

---

## Challenge 2 — FizzBuzz: The Classic Detective Test

```bash
#!/bin/bash
for i in {1..30}; do
    if [ $((i % 15)) -eq 0 ]; then
        echo "FizzBuzz"
    elif [ $((i % 3)) -eq 0 ]; then
        echo "Fizz"
    elif [ $((i % 5)) -eq 0 ]; then
        echo "Buzz"
    else
        echo $i
    fi
done
```

Important: check for divisibility by 15 (both 3 AND 5) FIRST, before checking 3 or 5 individually. Otherwise "FizzBuzz" cases would be caught by the earlier checks.

---

## Challenge 3 — Sort the Evidence by Source

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

---

## Challenge 4 — Countdown Timer

```bash
#!/bin/bash
# countdown.sh

echo "How many seconds?"
read seconds

if ! [[ "$seconds" =~ ^[0-9]+$ ]]; then
    echo "Please enter a number."
    exit 1
fi

for i in $(seq $seconds -1 0); do
    echo "⏱ $i..."
    if [ "$i" -gt 0 ]; then
        sleep 1
    fi
done

echo "Time's up! Submit your findings!"
say "Time's up! Submit your findings!"
```

Save as `~/countdown.sh`, run with `bash ~/countdown.sh`.

`seq $seconds -1 0` counts from `$seconds` down to 0, decrementing by 1. The `sleep 1` pauses for one second between each number, but the script skips that pause after it prints 0.

---

## Challenge 5 — Rename 100 Files Instantly

Use the starter lab:

```bash
cd ~/mac-cli-for-kids/playground/mission_08/bulk_rename_lab
bash create_100_files_starter.sh
bash rename_100_files_starter.sh
ls ~/rename_100_lab | head
```

To customize the output names, edit `rename_100_files_starter.sh` and change this line:

```bash
new_name=$(printf "evidence_%03d.txt" "$counter")
```

For example:

```bash
new_name=$(printf "case_photo_%03d.txt" "$counter")
```
