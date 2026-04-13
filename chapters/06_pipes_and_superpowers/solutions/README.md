# Mission 6 — Solutions

## Challenge 1 — The Leaderboard

```bash
cat > scores.txt << 'EOF'
Alice 95
Bob 72
Charlie 88
Diana 95
Ella 63
Frank 88
Grace 100
Hannah 72
EOF

# Sort by score, highest first:
sort -k2 -rn scores.txt
```

Output:
```
Grace 100
Alice 95
Diana 95
Charlie 88
Frank 88
Bob 72
Hannah 72
Ella 63
```

Unique scores only:
```bash
sort -k2 -rn scores.txt | cut -d' ' -f2 | uniq
```

Output:
```
100
95
88
72
63
```

---

## Challenge 2 — Word Count Race

```bash
wc -w ~/diary/journal.txt
wc -w ~/Documents/somefile.txt   # replace with your actual file
wc -w /usr/share/dict/words
```

`/usr/share/dict/words` almost certainly wins — it has 235,886 words!

---

## Challenge 3 — The Pipeline Challenge

```bash
find ~ -name "*.txt" 2>/dev/null | sort | wc -l
```

One line, three commands, all piped together. The result is a single number: how many `.txt` files are in your home folder.

---

## Challenge 4 — Top 10 Extensions

```bash
find ~ -type f 2>/dev/null | grep -o "\.[a-zA-Z0-9]*$" | sort | uniq -c | sort -rn | head -10
```

Translation:
1. `find ~ -type f` — list all files
2. `grep -o "\.[a-zA-Z0-9]*$"` — extract just the extension (the last `.something`)
3. `sort` — sort alphabetically (needed for `uniq`)
4. `uniq -c` — count each unique extension
5. `sort -rn` — sort by count, highest first
6. `head -10` — keep only the top 10

Your output will look something like:
```
 1423 .jpg
  892 .png
  445 .txt
  312 .pdf
  201 .mp3
  ...
```
