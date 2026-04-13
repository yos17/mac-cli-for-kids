# Mission 7 — Your First Script

## Mission Briefing

Everything you've been doing — all those commands — you've been typing them one at a time. But what if you could save a whole *sequence* of commands in a file and run them all at once with a single word?

That's a **script**. A script is a program. And today you write your first real one.

By the end of this mission, you'll have a morning briefing script that:
- Greets you by name
- Tells you today's date and day of the week
- Shows you the weather (sort of!)
- Tells you a random fun fact
- Says everything out loud in your favorite voice

### What You'll Learn
- The shebang line (`#!/bin/bash`)
- Variables — storing values with names
- `chmod +x` — making a file executable
- Running your script
- How to make your script speak

---

## What Is a Script?

A script is just a text file containing commands — the same commands you type in Terminal, but saved so you can run them again and again.

The computer needs to know two things about a script:
1. **Which program to use to run it** (the shebang)
2. **That it's allowed to be run** (the execute permission)

---

## The Shebang Line

Every script starts with a special first line called the **shebang**:

```bash
#!/bin/bash
```

This tells your Mac: "Use the program at `/bin/bash` to run this file." The `#!` is read as "hash-bang" → shebang. It's always the very first line.

On modern Macs, you might also see:
```bash
#!/bin/zsh
```

Either works for this book. We'll use `#!/bin/bash` because it's universal.

---

## Variables

Variables store values that you can use and reuse.

```bash
name="Sophia"
age=12
greeting="Hello there"
```

**Rules:**
- No spaces around the `=`
- Variable names are CASE_SENSITIVE
- Use `$` to read the value

```bash
echo "My name is $name"
echo "I am $age years old"
echo "$greeting, $name!"
```

Output:
```
My name is Sophia
I am 12 years old
Hello there, Sophia!
```

**Quotes matter:**

```bash
name="Sophia"
echo "Hello $name"     # → Hello Sophia  (variable expanded)
echo 'Hello $name'     # → Hello $name   (no expansion in single quotes)
```

Double quotes expand variables. Single quotes do not. Remember this!

**Command substitution in variables:**

```bash
today=$(date +"%A")
files=$(ls ~ | wc -l)

echo "Today is $today"
echo "You have $files items in your home folder"
```

The `$(...)` runs a command and saves its output into the variable.

---

## Making a Script Executable

Create a new script file:

```bash
touch ~/hello.sh
```

Open it with nano (a simple text editor in Terminal):

```bash
nano ~/hello.sh
```

You'll see an empty editor. Type this:

```
#!/bin/bash

name="Sophia"
echo "Hello, $name! Welcome to your terminal."
say "Hello $name, your terminal is ready"
```

Save: press `Ctrl+O`, then Enter.
Exit: press `Ctrl+X`.

Now make it executable:

```bash
chmod +x ~/hello.sh
```

Run it:

```bash
bash ~/hello.sh
```

Or, if you made it executable:

```bash
~/hello.sh
```

Your Mac greets you!

---

## Understanding `chmod +x`

`chmod` changes a file's **permissions** — who can read, write, or execute it.

`+x` adds the "execute" permission. Without it, your file is just text. With it, your Mac knows it's a runnable program.

We'll learn more about permissions in Mission 11. For now, just remember: `chmod +x yourscript.sh` is required once before running a script.

---

## The `nano` Text Editor

`nano` is the friendliest text editor in Terminal. Commands appear at the bottom:

```
^G = Get Help     ^O = Write Out (save)    ^W = Where Is (search)
^X = Exit         ^K = Cut Text            ^U = Paste Text
```

The `^` means `Ctrl`. So `^O` = `Ctrl+O`.

You can also use other editors: `vim` (powerful but tricky) or VS Code (`code filename`) if you have it installed. But `nano` is great for starting out.

---

## Try It! — Quick Experiments

**Experiment 1:** Variable math.

```bash
x=5
y=3
result=$((x + y))
echo "$x + $y = $result"
```

`$(( ))` does arithmetic. Try `-`, `*`, `/`.

**Experiment 2:** Ask the user a question.

```bash
echo "What is your name?"
read username
echo "Hello, $username!"
```

`read` captures what you type into a variable.

**Experiment 3:** Variables from commands.

```bash
my_location=$(pwd)
item_count=$(ls | wc -l)
echo "I am in: $my_location"
echo "There are $item_count things here"
```

**Experiment 4:** Edit and re-run your script.

```bash
nano ~/hello.sh
```

Change `name="Sophia"` to your actual name (if it wasn't already). Save, exit, run again.

---

## Pro Tip — Comments

In scripts, lines starting with `#` are **comments** — they're ignored by the computer but help humans understand the code.

```bash
#!/bin/bash
# This script greets the user
# Written by Sophia on April 13, 2026

name="Sophia"     # change this to your name
echo "Hello, $name!"
```

Good comments explain *why*, not *what*. The code already shows *what*; the comment explains *why it's done this way*.

---

## Your Mission — Morning Briefing Script

This is the big one. Build a script that gives you a complete morning briefing every day.

Open nano and create the script:

```bash
nano ~/morning.sh
```

Type this entire script (customizing the name and voice to yours!):

```bash
#!/bin/bash
# morning.sh — Daily morning briefing
# Personalized for Sophia by Dad

# === SETTINGS (change these!) ===
MY_NAME="Sophia"
MY_VOICE="Samantha"      # your favorite voice from Mission 1

# === GATHER INFORMATION ===
DATE_FULL=$(date +"%A, %B %d, %Y")
DATE_DAY=$(date +"%A")
DATE_SHORT=$(date +"%B %d")
HOUR=$(date +"%H")

# === FIGURE OUT GREETING ===
if [ "$HOUR" -lt 12 ]; then
    GREETING="Good morning"
elif [ "$HOUR" -lt 17 ]; then
    GREETING="Good afternoon"
else
    GREETING="Good evening"
fi

# === FUN FACTS (one is picked randomly) ===
FACTS=(
    "A group of flamingos is called a flamboyance."
    "Honey never expires. Archaeologists found 3000-year-old honey in Egyptian tombs."
    "Octopuses have three hearts and blue blood."
    "A day on Venus is longer than a year on Venus."
    "Bananas are technically berries. Strawberries are not."
    "The unicorn is the national animal of Scotland."
    "There are more possible chess games than atoms in the observable universe."
    "Crows can recognize human faces and hold grudges."
)
# Pick a random fact
RANDOM_INDEX=$((RANDOM % ${#FACTS[@]}))
FUN_FACT="${FACTS[$RANDOM_INDEX]}"

# === PRINT THE BRIEFING ===
echo ""
echo "╔══════════════════════════════════════════╗"
echo "║       MORNING BRIEFING FOR $MY_NAME          ║"
echo "╚══════════════════════════════════════════╝"
echo ""
echo "  $GREETING, $MY_NAME!"
echo "  Today is $DATE_FULL"
echo ""
echo "  Fun Fact:"
echo "  $FUN_FACT"
echo ""
echo "──────────────────────────────────────────"
echo ""

# === SPEAK THE BRIEFING ===
say -v "$MY_VOICE" "$GREETING $MY_NAME! Today is $DATE_DAY, $DATE_SHORT."
say -v "$MY_VOICE" "Fun fact: $FUN_FACT"
say -v "$MY_VOICE" "Have an amazing day!"
```

Save (`Ctrl+O`, Enter) and exit (`Ctrl+X`).

Make it executable and run it:

```bash
chmod +x ~/morning.sh
~/morning.sh
```

Your Mac reads you a morning briefing! Add more facts to the list, change the voice, customize the greeting — it's YOUR script.

---

## Challenges

### Challenge 1 — Personalize the Script

Add at least 3 more fun facts to the `FACTS` array. Make at least one of them funny or silly. Run the script 5+ times to see different facts appear randomly.

### Challenge 2 — Add Your Name to the Banner

Right now the banner says "MORNING BRIEFING FOR Sophia" with hardcoded alignment. Make it use the `$MY_NAME` variable AND keep it centered. (Hint: the `╔═══╗` box may need adjusting for different name lengths — just adjust the number of `═` characters.)

### Challenge 3 — Time Trivia

Add a section to the script that tells you how many days until a special date (like your birthday, a holiday, or summer break). You'll need:

```bash
# Days until December 25th:
TODAY=$(date +%s)
HOLIDAY=$(date -j -f "%Y-%m-%d" "2026-12-25" +%s)
DAYS_LEFT=$(( (HOLIDAY - TODAY) / 86400 ))
echo "Days until Christmas: $DAYS_LEFT"
```

Add this to your morning script!

### Challenge 4 — The Welcome Script

Create a *new* script called `~/welcome.sh` that:
1. Asks for your name using `read`
2. Asks for your favorite color
3. Prints a personalized message using both answers
4. Makes your Mac say the message out loud

---

## Solutions

Solutions are in the [solutions folder](solutions/README.md).

---

## Powers Unlocked

| Concept | How It Works |
|---------|-------------|
| `#!/bin/bash` | Shebang — tells the OS which interpreter to use |
| `name="value"` | Create a variable |
| `$name` | Read a variable's value |
| `$(command)` | Capture command output into a variable |
| `$((math))` | Do arithmetic |
| `read varname` | Read user input into a variable |
| `chmod +x file` | Give a file execute permission |
| `bash file.sh` | Run a script with bash |
| `./file.sh` | Run an executable script in current folder |
| `# comment` | Line comment (ignored by the computer) |
| `ARRAY=(a b c)` | Create an array |
| `${ARRAY[$i]}` | Access array element at index i |
| `${#ARRAY[@]}` | Number of elements in array |
| `$RANDOM` | A random number (0–32767) |

### Vocabulary

- **Script** — a file containing commands to be run in sequence
- **Shebang** — `#!` followed by the path to the interpreter
- **Variable** — a named container for a value
- **Execute permission** — the right to run a file as a program
- **Array** — a variable that holds a list of values

---

*You wrote a real program. Not a command — a program. It has variables, logic, and it speaks. That's a script. That's software.*

*Ready for Mission 8?*
