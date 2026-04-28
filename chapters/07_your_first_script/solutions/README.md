# Mission 7 — Solutions

## Challenge 1 — Personalize the Briefing Script

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
    "Eugene Francois Vidocq founded one of the first modern detective agencies in 1833."
    "Kate Warne became the first female Pinkerton detective in 1856."
    "Fingerprint evidence helped solve a murder case in Argentina in 1892."
    "The FBI was founded in 1908."
)
```

Run multiple times to see different facts:
```bash
~/morning.sh
~/morning.sh
~/morning.sh
```

---

## Challenge 2 — Report Generator

Create `~/make_report.sh`:

```bash
nano ~/make_report.sh
```

```bash
#!/bin/bash
# make_report.sh — Fill a detective report template

MISSION_DIR="$HOME/mac-cli-for-kids/playground/mission_07"

name_count=$(wc -l < "$MISSION_DIR/names.txt")
case_count=$(wc -l < "$MISSION_DIR/case_numbers.txt")

random_name=$((RANDOM % name_count + 1))
random_case=$((RANDOM % case_count + 1))

chosen_name=$(sed -n "${random_name}p" "$MISSION_DIR/names.txt")
chosen_case=$(sed -n "${random_case}p" "$MISSION_DIR/case_numbers.txt")

sed \
    -e "s|{{DETECTIVE_NAME}}|$chosen_name|g" \
    -e "s|{{CASE_NUMBER}}|$chosen_case|g" \
    "$MISSION_DIR/template.txt" > "$HOME/completed_report.txt"

echo "Report filed!"
echo "Saved to: $HOME/completed_report.txt"
```

Run it:

```bash
bash ~/make_report.sh
cat ~/completed_report.txt
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

echo "What is your detective code name?"
read code_name

echo "What is your specialty?"
read specialty

MESSAGE="Welcome, Agent $code_name. Specialty confirmed: $specialty. Detective Academy is ready."

echo ""
echo "$MESSAGE"
echo ""

say "$MESSAGE"
```

```bash
chmod +x ~/welcome.sh
~/welcome.sh
```

---

## Challenge 5 — Customize the Number Lock Game

Start by running the scaffold:

```bash
cd ~/mac-cli-for-kids/playground/mission_07
bash shell_game_starter.sh
```

Then copy it and edit your own version:

```bash
cp shell_game_starter.sh ~/number_lock.sh
nano ~/number_lock.sh
bash ~/number_lock.sh
```

Ideas to add:

Change the success block so it reveals a message:

```bash
if [ "$guess" -eq "$secret_number" ]; then
    echo "Case unlocked. Secret message: Trust the evidence."
    exit 0
fi
```

After the existing `tries_left=$((tries_left - 1))` line, replace the "Not yet" block with warmer/colder hints:

```bash
if [ "$tries_left" -gt 0 ]; then
    if [ "$guess" -lt "$secret_number" ]; then
        echo "Too low. Warmer if you go higher."
    else
        echo "Too high. Warmer if you go lower."
    fi
    echo "Tries left: $tries_left"
fi
```

To give the player 5 tries, change `tries_left=3` near the top to `tries_left=5`, and update the printed line so it says `You have 5 tries to unlock the case.`
