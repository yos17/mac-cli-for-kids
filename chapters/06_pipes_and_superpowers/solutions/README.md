# Mission 6 — Solutions

## Challenge 1 — The Leaderboard

Create the file:

```bash
cat > agent_scores.txt << 'EOF'
Agent Phoenix 95
Agent Shadow 72
Agent Cipher 88
Agent Storm 95
Agent Echo 63
Agent Frost 88
Agent Nova 100
Agent Blaze 72
EOF
```

Sort highest first:

```bash
sort -k3 -rn agent_scores.txt
```

Show only unique scores, highest first:

```bash
sort -k3 -rn agent_scores.txt | cut -d' ' -f3 | uniq
```

Expected unique scores:

```text
100
95
88
72
63
```

---

## Challenge 2 — Access Log Deep Dive

Go to the mission folder:

```bash
cd ~/mac-cli-for-kids/playground/mission_06
```

Unique IP addresses:

```bash
cut -d',' -f2 access_log.csv | tail -n +2 | sort | uniq | wc -l
```

Expected answer: `68`.

Most common URL:

```bash
cut -d',' -f4 access_log.csv | tail -n +2 | sort | uniq -c | sort -rn | head -1
```

Expected top URL: `/index.html`.

IP address with the most requests:

```bash
cut -d',' -f2 access_log.csv | tail -n +2 | sort | uniq -c | sort -rn | head -1
```

Expected top IP: `10.0.0.99`.

---

## Challenge 3 — The Pipeline Challenge

```bash
cd ~/mac-cli-for-kids/playground/mission_06
grep ',at_large' suspects_database.csv | cut -d',' -f2 | sort
```

Active suspect names:

```text
Celeste Moreau
Dmitri Volkov
Vera Blackstone
Victor "The Ghost" Malenko
Yuki Tanaka
```

Count them:

```bash
grep ',at_large' suspects_database.csv | cut -d',' -f2 | sort | wc -l
```

Expected count: `5`.

---

## Challenge 4 — Crack the Word Scramble

```bash
cd ~/mac-cli-for-kids/playground/mission_06
cat word_scramble.txt | tr ' ' '\n' | tr '[:upper:]' '[:lower:]' | grep -v "^$" | sort | uniq -c | sort -rn | head -5
```

This file includes punctuation and lesson text, so the raw top results include symbols such as `_`, `.`, and `—`. That is useful to notice: real text data is messy.

To count cleaner word-like tokens only:

```bash
cat word_scramble.txt \
  | tr '[:upper:]' '[:lower:]' \
  | tr -cs '[:alpha:]' '\n' \
  | grep -v "^$" \
  | sort \
  | uniq -c \
  | sort -rn \
  | head -5
```

The important skill is understanding the pipeline: split text into words, normalize case, remove blanks, sort, count, sort by count, then show the top results.
