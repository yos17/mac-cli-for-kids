# Mission 1 — Solutions

## Challenge 1 — Your Own Voice Message

```bash
say -v Samantha "Hi, my name is Joanna"
say -v Fred "I am twelve years old"
say -v Victoria "My favorite thing to do is draw"
```

Pick any three voices you like! Run `say -v '?' 2>&1` to see all available voices.

---

## Challenge 2 — The Custom Date

Print only the current year:
```bash
date +"%Y"
```
Output: `2026`

Print only the current month name:
```bash
date +"%B"
```
Output: `April`

**Bonus:** Print just the day of the week:
```bash
date +"%A"
```
Output: `Sunday`

---

## Challenge 3 — Echo Art

Here's a simple cat:
```bash
echo "  /\_/\  "
echo " ( o.o ) "
echo "  > ^ <  "
echo " (_____)  "
```

A rocket:
```bash
echo "   /\ "
echo "  /  \ "
echo " | ** | "
echo " |    | "
echo "  \  / "
echo "  /  \ "
echo " / /\ \ "
echo "/_/  \_\\"
```

A house:
```bash
echo "    /\ "
echo "   /  \ "
echo "  /    \ "
echo " /______\ "
echo " |      | "
echo " |  []  | "
echo " |______| "
```

There's no single right answer here — have fun with it!

---

## Challenge 4 — Explore Voices

To see all voices:
```bash
say -v '?' 2>&1
```

Some fun ones to try:
```bash
say -v Zarvox "Take me to your leader"
say -v Cellos "I am speaking in a very deep voice"
say -v Trinoids "I am a tiny alien"
say -v Pipe Organ "La la la la la"
say -v Whisper "Can you hear me?"
say -v Bahh "I am a sheep. Baa."
```

Keep a mental note of your favorite — you'll get to use it in Mission 7 when you build your morning briefing script!
