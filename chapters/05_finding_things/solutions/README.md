# Mission 5 — Solutions

## Challenge 1 — Find the Witness

```bash
grep "MARINA SANTOS" ~/mac-cli-for-kids/playground/mission_05/report_*.txt
```

The match is in:

```text
report_008.txt
```

Read the full report:

```bash
cat ~/mac-cli-for-kids/playground/mission_05/report_008.txt
```

Find the exact line number:

```bash
grep -n "MARINA SANTOS" ~/mac-cli-for-kids/playground/mission_05/report_008.txt
```

---

## Challenge 2 — Evidence Log Analysis

Use at least three keywords from `keyword_hints.txt`. Examples:

```bash
cd ~/mac-cli-for-kids/playground/mission_05

grep -i "alert" evidence_*.log
grep -i "harbor" evidence_*.log
grep -i "decryption" evidence_*.log
```

Count lines containing numbers in each log:

```bash
grep -c "[0-9]" evidence_*.log
```

In these training files, each evidence log has timestamped lines, so each file reports numbered matches.

Bonus count for alerts:

```bash
grep -i "alert" evidence_*.log | wc -l
```

Expected alert count: `13`.

---

## Challenge 3 — Dictionary Detective

Words starting with `detect`:

```bash
grep "^detect" /usr/share/dict/words
grep -c "^detect" /usr/share/dict/words
```

Words ending with `tion`:

```bash
grep "tion$" /usr/share/dict/words
grep -c "tion$" /usr/share/dict/words
```

Words containing `clue`:

```bash
grep "clue" /usr/share/dict/words
grep -i "clue" /usr/share/dict/words
```

Five-letter words:

```bash
grep "^.....$" /usr/share/dict/words | wc -l
```

Each `.` matches exactly one character. So `^.....$` means start, five characters, end.

---

## Challenge 4 — Full Folder Sweep

Search the whole mission folder:

```bash
grep -Rli "MARINA" ~/mac-cli-for-kids/playground/mission_05
```

You should see `report_008.txt`. You may also see `search_toolkit_starter.sh`, because that starter script uses `MARINA` as its default search term.

Search only content matches with line numbers:

```bash
grep -Rni "MARINA" ~/mac-cli-for-kids/playground/mission_05
```

Find files modified in the last 7 days:

```bash
find ~/mac-cli-for-kids/playground/mission_05 -type f -mtime -7 2>/dev/null
```

To show the newest files first:

```bash
find ~/mac-cli-for-kids/playground/mission_05 -type f -exec ls -lt {} \; 2>/dev/null | head
```
