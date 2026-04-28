# Mission 1 — Solutions

## Challenge 1 — Your Own Voice Message

Example:

```bash
echo "Hi, my name is Joanna"
say -v Samantha "Hi, my name is Joanna"

echo "I am twelve years old"
say -v Fred "I am twelve years old"

echo "My favorite thing to do is draw"
say -v Victoria "My favorite thing to do is draw"
```

Pick any three voices you like. Run `say -v '?' 2>&1 | head -20` to see available voices in smaller chunks.

---

## Challenge 2 — Read the Case Files

```bash
cd ~/mac-cli-for-kids/playground/mission_01
cat welcome.txt
cat agents.txt
```

Example summaries:

```bash
echo "welcome.txt explains that Terminal is a direct way to control my Mac."
echo "agents.txt lists Academy agents and their specialties."
```

Bonus:

```bash
say "$(cat welcome.txt)"
```

If that speaks too much at once, try just the first few lines:

```bash
head -5 welcome.txt
say "$(head -5 welcome.txt)"
```

---

## Challenge 3 — Echo Art

Here's a simple cat:

```bash
echo "  /\\_/\\  "
echo " ( o.o ) "
echo "  > ^ <  "
echo " (_____) "
```

A small badge:

```bash
echo "  _______  "
echo " /       \\ "
echo "|  DA-1   |"
echo "| DETECT  |"
echo " \\_______/ "
```

There is no single right answer. If `echo` prints the shape you intended, it worked.

---

## Challenge 4 — Custom Date Formats

Print only the current year:

```bash
date +"%Y"
```

Print only the current month name:

```bash
date +"%B"
```

Print only the day of the week:

```bash
date +"%A"
```

Try voices:

```bash
say -v Samantha "Today is $(date +"%A")"
say -v Fred "Today is $(date +"%A")"
say -v Victoria "Today is $(date +"%A")"
say -v Alex "Today is $(date +"%A")"
say -v Zarvox "Today is $(date +"%A")"
```
