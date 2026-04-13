# Mission 5 — Solutions

## Challenge 1 — Find Your Photos

```bash
find ~ \( -name "*.jpg" -o -name "*.png" -o -name "*.heic" \) 2>/dev/null | wc -l
```

The `\(` and `\)` group the `-o` (or) conditions together. The count will vary depending on your Mac.

---

## Challenge 2 — Dictionary Detective

Words starting with "cat":
```bash
grep "^cat" /usr/share/dict/words
grep -c "^cat" /usr/share/dict/words
```

Words ending with "tion":
```bash
grep "tion$" /usr/share/dict/words
grep -c "tion$" /usr/share/dict/words
```

Words containing "xyz":
```bash
grep "xyz" /usr/share/dict/words
```
(Probably none, or very few!)

5-letter words:
```bash
grep "^.....$" /usr/share/dict/words | wc -l
```
Each `.` matches exactly one character. So `^.....$` matches "start, any char, any char, any char, any char, any char, end" = exactly 5 characters.

---

## Challenge 3 — Recent Activity

```bash
find ~ -mtime -1 2>/dev/null
```

To find the MOST recently changed file, sort by modification time:
```bash
find ~ -mtime -1 2>/dev/null -exec ls -lt {} \; 2>/dev/null | head -5
```

Or more simply:
```bash
ls -lt ~ | head -10
```

---

## Challenge 4 — Search Your Diary

Entry headers:
```bash
grep "^===" ~/diary/journal.txt
```

Search for a specific word (case-insensitive):
```bash
grep -i "learned" ~/diary/journal.txt
```

Count "today":
```bash
grep -c "today" ~/diary/journal.txt
```

Or for case-insensitive count:
```bash
grep -ic "today" ~/diary/journal.txt
```
