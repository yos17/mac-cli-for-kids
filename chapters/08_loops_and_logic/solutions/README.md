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

## Challenge 2 — FizzBuzz

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

## Challenge 3 — The File Renamer

```bash
mkdir ~/rename_test
touch ~/rename_test/old_file_{1..5}.txt
ls ~/rename_test/

for i in {1..5}; do
    mv ~/rename_test/old_file_$i.txt ~/rename_test/new_file_$i.txt
done

ls ~/rename_test/
rm -r ~/rename_test
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

for i in $(seq $seconds -1 1); do
    echo "⏱ $i..."
    sleep 1
done

echo "Time's up!"
say "Time's up!"
```

Save as `~/countdown.sh`, run with `bash ~/countdown.sh`.

`seq $seconds -1 1` counts from `$seconds` down to 1, decrementing by 1. The `sleep 1` pauses for one second between each number.
