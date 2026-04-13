# Mission 4 — Solutions

## Challenge 1 — The Three Poems

```bash
echo "Roses are red," >> poems.txt
echo "Violets are blue," >> poems.txt
echo "I love my computer," >> poems.txt
echo "And Terminal too!" >> poems.txt
echo "" >> poems.txt
echo "---" >> poems.txt
echo "" >> poems.txt
echo "Beware the bug," >> poems.txt
echo "That lurks in the code," >> poems.txt
echo "Fix it with patience," >> poems.txt
echo "Or it will explode." >> poems.txt
echo "" >> poems.txt
echo "---" >> poems.txt
echo "" >> poems.txt
echo "Commands are my friends," >> poems.txt
echo "They never complain," >> poems.txt
echo "Unlike my homework," >> poems.txt
echo "That drives me insane." >> poems.txt

cat poems.txt
```

---

## Challenge 2 — Head vs Tail

First, create the file:
```bash
for i in 1 2 3 4 5 6 7 8 9 10; do
  echo "Item number $i" >> numbers.txt
done
```

First 3:
```bash
head -3 numbers.txt
```

Last 3:
```bash
tail -3 numbers.txt
```

Items 4 through 7 (skip first 3, take next 4):
```bash
tail -n +4 numbers.txt | head -4
```

`tail -n +4` means "start from line 4" (not the last 4!). Then `head -4` takes only 4 lines from there.

---

## Challenge 3 — The Secret Code

```bash
echo "Why don't scientists trust atoms?" > joke.txt
echo "Because they make up everything!" >> joke.txt
cat joke.txt
```

Output:
```
Why don't scientists trust atoms?
Because they make up everything!
```

---

## Challenge 4 — The Diary Entry Script Preview

```bash
echo "=== $(date +"%A, %B %d, %Y") ===" >> ~/diary/journal.txt
echo "" >> ~/diary/journal.txt
echo "Today I learned about reading and writing files in Terminal." >> ~/diary/journal.txt
echo "" >> ~/diary/journal.txt
echo "---" >> ~/diary/journal.txt
tail -5 ~/diary/journal.txt
```

In Mission 7, you'll put exactly these commands into a script file so you never have to type them out again — one command will do all of this automatically!
