# Mission 7 — Solutions

## Challenge 1 — Personalize the Script

Open the script and add more facts to the FACTS array:

```bash
nano ~/morning.sh
```

Add inside the FACTS array:
```bash
FACTS=(
    "A group of flamingos is called a flamboyance."
    "Honey never expires. Archaeologists found 3000-year-old honey in Egyptian tombs."
    "Octopuses have three hearts and blue blood."
    "A day on Venus is longer than a year on Venus."
    "Bananas are technically berries. Strawberries are not."
    "The unicorn is the national animal of Scotland."
    "There are more possible chess games than atoms in the observable universe."
    "Crows can recognize human faces and hold grudges."
    # --- New facts ---
    "Wombats produce cube-shaped poop. They are the only animals that do."
    "A snail can sleep for three years."
    "Cats have a special organ that lets them taste the air."
    "The shortest war in history lasted 38 minutes."
)
```

Run multiple times to see different facts:
```bash
~/morning.sh
~/morning.sh
~/morning.sh
```

---

## Challenge 2 — Add Your Name to the Banner

The banner width needs adjusting. Count characters to center. Here's one approach:

```bash
echo "╔════════════════════════════════════════════════╗"
echo "║       MORNING BRIEFING FOR $MY_NAME              ║"
echo "╚════════════════════════════════════════════════╝"
```

Or for a simpler banner that always works:
```bash
echo "=========================================="
echo "   MORNING BRIEFING FOR $MY_NAME"
echo "=========================================="
```

---

## Challenge 3 — Time Trivia

Add this section to your morning script before the closing `say` lines:

```bash
# Days until something special
TODAY=$(date +%s)
# Change this date to YOUR special date:
SPECIAL_DATE=$(date -j -f "%Y-%m-%d" "2026-12-25" +%s 2>/dev/null)
if [ ! -z "$SPECIAL_DATE" ]; then
    DAYS_LEFT=$(( (SPECIAL_DATE - TODAY) / 86400 ))
    if [ "$DAYS_LEFT" -gt 0 ]; then
        echo "  Days until Christmas: $DAYS_LEFT"
        say -v "$MY_VOICE" "Christmas is in $DAYS_LEFT days."
    fi
fi
```

---

## Challenge 4 — The Welcome Script

```bash
nano ~/welcome.sh
```

```bash
#!/bin/bash
# welcome.sh — Personalized greeting

echo "What is your name?"
read user_name

echo "What is your favorite color?"
read fav_color

MESSAGE="Welcome, $user_name! Your favorite color $fav_color is a great choice."

echo ""
echo "$MESSAGE"
echo ""

say "$MESSAGE"
```

```bash
chmod +x ~/welcome.sh
~/welcome.sh
```
