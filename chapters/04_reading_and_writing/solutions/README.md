# Mission 4 — Solutions

## Challenge 1 — The Seven-Day Digest

```bash
cd ~/mac-cli-for-kids/playground/mission_04

cat diary_entries/day_01.txt
cat diary_entries/day_02.txt
cat diary_entries/day_03.txt
cat diary_entries/day_04.txt
cat diary_entries/day_05.txt
cat diary_entries/day_06.txt
cat diary_entries/day_07.txt
```

Create the summary:

```bash
echo "=== Weekly Summary: $(date +"%A, %B %d, %Y") ===" > weekly_summary.txt
echo "The investigation followed a missing USB drive through several false leads." >> weekly_summary.txt
echo "The suspect file showed multiple people of interest, but the evidence changed over time." >> weekly_summary.txt
echo "The final twist was that the USB was in Dr. Amari's coat pocket all along." >> weekly_summary.txt
cat weekly_summary.txt
```

Use `>` for the first line so the file starts fresh. Use `>>` after that so each summary line is appended.

---

## Challenge 2 — Head vs Tail

Create the clue list:

```bash
cd ~/mac-cli-for-kids/playground/mission_04
rm -f clues.txt
for i in 1 2 3 4 5 6 7 8 9 10; do
  echo "Clue number $i" >> clues.txt
done
```

First 3:

```bash
head -3 clues.txt
```

Last 3:

```bash
tail -3 clues.txt
```

Clues 4 through 7:

```bash
tail -n +4 clues.txt | head -4
```

`tail -n +4` starts at line 4. `head -4` keeps four lines: 4, 5, 6, and 7.

---

## Challenge 3 — The Suspects File

```bash
cd ~/mac-cli-for-kids/playground/mission_04

grep "^SUSPECT #1" suspects.txt > prime_suspect.txt
grep "^SUSPECT #2" suspects.txt >> prime_suspect.txt
grep "^SUSPECT #3" suspects.txt >> prime_suspect.txt
grep "^SUSPECT #4" suspects.txt >> prime_suspect.txt
grep "^SUSPECT #5" suspects.txt >> prime_suspect.txt

cat -n prime_suspect.txt
```

This writes the first suspect line with `>`, then appends the rest with `>>`.

---

## Challenge 4 — Case Diary Entry

If the diary folder does not exist yet, create it first:

```bash
mkdir -p ~/detective_diary
```

The five requested commands:

```bash
echo "=== CASE DIARY: $(date +"%A, %B %d, %Y") ===" >> ~/detective_diary/case_log.txt
echo "Today I read diary entries, suspect notes, and clue files from Mission 4." >> ~/detective_diary/case_log.txt
echo "The decoded clue said the USB drive was in the coat pocket all along." >> ~/detective_diary/case_log.txt
echo "---" >> ~/detective_diary/case_log.txt
tail -6 ~/detective_diary/case_log.txt
```
