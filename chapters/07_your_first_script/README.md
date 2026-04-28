# Mission 7 — Your First Script

## Mission Briefing

_Briefing note_

> "Detective, you have been typing commands one at a time. That is fine for quick lookups. But real detectives don't repeat themselves. We write **procedures** — step-by-step instructions our equipment follows automatically.
>
> Today you will write your first **script**: a real program that runs a whole sequence of commands with a single word. By the time you finish, your computer will greet you by name, announce the date, share a random fact, and read the whole briefing out loud — all from one command.
>
> Build it once. Run it whenever you want."

A script is exactly what Commander Chen described: a text file full of commands, saved so you can run them again and again. You have been typing commands live; now you package them. That is how real software works.

By the end of this mission your morning briefing script will:
- Greet you by name
- Tell you today's date and day of the week
- Recite a random fun fact from your personal fact database
- Say everything out loud in your favorite voice

### What You'll Learn
- The shebang line (`#!/bin/bash`)
- Variables — storing values with names
- `chmod +x` — making a file executable
- Running your script two different ways
- How to make your script speak
- Arrays and random selection

---

## Your Case Files

Before writing anything new, let's check in at HQ. Your playground folder for this mission is already on your computer.

```bash
cd ~/mac-cli-for-kids/playground/mission_07
ls -la
```

You should see:

```
template.txt        ← a detective report template with {{PLACEHOLDER}} fields
names.txt           ← 10 detective names (suspects? partners? you decide)
case_numbers.txt    ← 10 case numbers in CASE-2026-XXXX format
shell_game_starter.sh ← a tiny number-lock game to customize
.secret_code.txt    ← hidden! (you'll find it at the end of the mission)
```

Take a look at the template:

```bash
cat template.txt
```

Notice those `{{PLACEHOLDER}}` fields? By the end of this mission you will know how to fill them in automatically using variables in a script. That is exactly what big software does when it generates a form or a report.

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

This tells your Mac: "Use the program at `/bin/bash` to run this file." The `#!` is read as "hash-bang" — shebang. It must be the very first line of every script.

On modern Macs you might also see:
```bash
#!/bin/zsh
```

Either works for this book. We'll use `#!/bin/bash` because it runs on any Unix-style system.

---

## Variables

Variables store values that you can use and reuse.

```bash
detective_name="Joanna"
badge_number=7
greeting="Good morning, Detective"
```

**Rules:**
- No spaces around the `=`
- Variable names are CASE_SENSITIVE
- Use `$` to read the value back

```bash
echo "My name is $detective_name"
echo "Badge: $badge_number"
echo "$greeting, $detective_name!"
```

Output:
```
My name is Joanna
Badge: 7
Good morning, Detective Joanna!
```

**Quotes matter:**

```bash
detective_name="Joanna"
echo "Hello $detective_name"    # → Hello Joanna  (variable expanded)
echo 'Hello $detective_name'    # → Hello $detective_name  (no expansion!)
```

Double quotes expand variables. Single quotes do not. Remember this — it catches everyone at first.

**Command substitution in variables:**

```bash
today=$(date +"%A")
file_count=$(ls ~ | wc -l)

echo "Today is $today"
echo "You have $file_count items in your home folder"
```

The `$(...)` syntax runs a command and saves its output into the variable. This is called **command substitution** and it is incredibly powerful.

---

## Making a Script Executable

Create a new script file:

```bash
touch ~/hello.sh
```

Open it with nano (a simple text editor that lives right inside Terminal):

```bash
nano ~/hello.sh
```

You'll see an empty editor. Type this:

```
#!/bin/bash

detective_name="Joanna"
echo "Detective $detective_name reporting for duty."
say "Hello Detective $detective_name, your terminal is ready"
```

Save: press `Ctrl+O`, then Enter.
Exit: press `Ctrl+X`.

Now make it executable:

```bash
chmod +x ~/hello.sh
```

Run it two ways:

```bash
bash ~/hello.sh    # run with bash directly
~/hello.sh         # run as an executable program
```

Your Mac greets you by name!

---

## Understanding `chmod +x`

`chmod` changes a file's **permissions** — who can read it, who can change it, and who can run it.

`+x` adds the "execute" permission. Without it, your file is just a text document. With it, your Mac treats it as a runnable program.

We'll go much deeper on permissions in Mission 11. For now: `chmod +x yourscript.sh` is the magic step you do once before running any new script.

---

## The `nano` Text Editor

`nano` is the friendliest text editor in Terminal. Shortcut commands appear at the bottom of the screen:

```
^G = Get Help     ^O = Write Out (save)    ^W = Where Is (search)
^X = Exit         ^K = Cut Text            ^U = Paste Text
```

The `^` means `Ctrl`. So `^O` = `Ctrl+O`.

You can also use `vim` (powerful but steep learning curve) or VS Code (`code filename`) if you have it installed. nano is perfect for starting out.

---

## Try It! — Quick Experiments

**Experiment 1:** Variable arithmetic.

```bash
suspects=5
arrested=2
still_loose=$((suspects - arrested))
echo "$suspects suspects. $arrested arrested. $still_loose still at large."
```

`$(( ))` does arithmetic. Try `+`, `-`, `*`, `/`.

**Experiment 2:** Ask the detective their name.

```bash
echo "What is your detective code name?"
read codename
echo "Welcome to HQ, Detective $codename."
```

`read` captures what you type into a variable. It pauses the script and waits.

**Experiment 3:** Variables from commands.

```bash
current_dir=$(pwd)
file_count=$(ls | wc -l)
echo "Investigating: $current_dir"
echo "Evidence items found: $file_count"
```

**Experiment 4:** Edit and re-run your hello script.

```bash
nano ~/hello.sh
```

Change `detective_name="Joanna"` to your actual name. Save, exit, run again. Your Mac greets the right detective.

---

## Pro Tip — Comments

In scripts, lines starting with `#` are **comments** — they are ignored by the computer but help humans understand the code. (The shebang `#!` on line 1 is the only exception — it IS read by the OS.)

```bash
#!/bin/bash
# detective_briefing.sh — Daily briefing script
# Written by Joanna Chen on April 13, 2026

detective_name="Joanna"    # change this to your name
echo "Briefing for Detective $detective_name"
```

Good comments explain *why*, not *what*. The code already shows *what*; the comment explains *why it is done this way*.

---

## Your Mission — Morning Briefing Script

This is the main assignment. Build a script that gives you a complete detective's morning briefing every day.

Open nano and create the script:

```bash
nano ~/morning.sh
```

Type this entire script (customize the name and voice!):

```bash
#!/bin/bash
# morning.sh — Daily detective briefing
# Personalized for Joanna by Commander Chen

# === SETTINGS (change these!) ===
MY_NAME="Joanna"
MY_VOICE="Samantha"      # your favorite voice from Mission 1

# === GATHER INTELLIGENCE ===
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

# === DETECTIVE FACTS (one is picked randomly) ===
FACTS=(
    "Fingerprints were first used as evidence in 1892."
    "The word detective comes from the Latin 'detegere' meaning to uncover."
    "Sherlock Holmes was inspired by a real doctor named Joseph Bell."
    "The FBI was founded in 1908 with just 34 agents."
    "A bloodhound can follow a scent trail that is over 300 hours old."
    "The unicorn is the national animal of Scotland."
    "Crows can recognize human faces and hold grudges for years."
    "Bananas are technically berries. Strawberries are not."
    "A day on Venus is longer than a year on Venus."
    "Honey never expires. Archaeologists found 3000-year-old honey in Egyptian tombs."
)
# Pick a random fact
RANDOM_INDEX=$((RANDOM % ${#FACTS[@]}))
FUN_FACT="${FACTS[$RANDOM_INDEX]}"

# === PRINT THE BRIEFING ===
echo ""
echo "╔══════════════════════════════════════════╗"
echo "║     DETECTIVE ACADEMY MORNING BRIEFING   ║"
echo "╚══════════════════════════════════════════╝"
echo ""
echo "  $GREETING, Detective $MY_NAME!"
echo "  Today is $DATE_FULL"
echo ""
echo "  Intelligence Report:"
echo "  $FUN_FACT"
echo ""
echo "──────────────────────────────────────────"
echo ""

# === SPEAK THE BRIEFING ===
say -v "$MY_VOICE" "$GREETING Detective $MY_NAME! Today is $DATE_DAY, $DATE_SHORT."
say -v "$MY_VOICE" "Intelligence report: $FUN_FACT"
say -v "$MY_VOICE" "Stay sharp out there."
```

Save (`Ctrl+O`, Enter) and exit (`Ctrl+X`).

Make it executable and run it:

```bash
chmod +x ~/morning.sh
~/morning.sh
```

Your Mac reads you a detective briefing! Add more facts to the list, change the voice, swap in your own case briefings — it is YOUR script.

---

## Using the Playground Files in Your Script

Now let's connect your new scripting skills to the case files in `mission_07/`. Try this exercise — use the `names.txt` file to pick a random detective name:

```bash
cd ~/mac-cli-for-kids/playground/mission_07

# Count how many names there are
name_count=$(wc -l < names.txt)
echo "There are $name_count detectives on file."

# Pick one at random
random_line=$((RANDOM % name_count + 1))
chosen_name=$(sed -n "${random_line}p" names.txt)
echo "Today's lead detective: $chosen_name"
```

And pick a random case number from `case_numbers.txt`:

```bash
case_count=$(wc -l < case_numbers.txt)
random_case=$((RANDOM % case_count + 1))
chosen_case=$(sed -n "${random_case}p" case_numbers.txt)
echo "Assigned case: $chosen_case"
```

Now look at `template.txt` again. Can you write a short script that fills in the `{{DETECTIVE_NAME}}` and `{{CASE_NUMBER}}` placeholders with the random values you just pulled? (Hint: look up the `sed` command from Mission 6 — `sed 's/{{PLACEHOLDER}}/value/'`.)

---

## Challenges

### Case #0701 — Personalize the Briefing Script

Add at least 3 more facts to the `FACTS` array in `morning.sh`. Make at least one of them about real detective history. Run the script 5+ times to see different facts appear. Because the selection is truly random (`$RANDOM`), you might see the same fact twice in a row — that is normal!

### Case #0702 — Report Generator

Write a new script called `~/make_report.sh` that:
1. Reads a detective name from `~/mac-cli-for-kids/playground/mission_07/names.txt` (random line)
2. Reads a case number from `~/mac-cli-for-kids/playground/mission_07/case_numbers.txt` (random line)
3. Fills those values into `template.txt` using `sed`
4. Saves the completed report to `~/completed_report.txt`
5. Prints "Report filed!" when done

Run it several times. Each run should produce a different detective/case combination.

### Case #0703 — Time Trivia

Add a section to your morning script that tells you how many days until a special date. Pick any upcoming date that matters to you — a holiday, a birthday, summer break:

```bash
# Days until December 25th:
TODAY=$(date +%s)
HOLIDAY=$(date -j -f "%Y-%m-%d" "2026-12-25" +%s)
DAYS_LEFT=$(( (HOLIDAY - TODAY) / 86400 ))
echo "  Days until Christmas: $DAYS_LEFT"
```

Add this after the fun fact section.

### Case #0704 — The Welcome Script

Create a new script called `~/welcome.sh` that:
1. Asks for your detective code name using `read`
2. Asks for your specialty (explosives? forensics? cyber?)
3. Prints a personalized welcome to the Detective Academy using both answers
4. Makes your Mac say the welcome message out loud

### Case #0705 — Customize the Number Lock Game

Run the starter game:

```bash
cd ~/mac-cli-for-kids/playground/mission_07
bash shell_game_starter.sh
```

Then copy it to your home folder and change it. Add warmer/colder hints, give the player 5 tries, or reveal a secret message when the case unlocks.

---

## Secret Code Hunt

You have been learning how scripts work — including how to read variables from files and how to find hidden files.

The `mission_07` playground folder contains a hidden file. Use the commands you just learned to find it and read what is inside:

```bash
cd ~/mac-cli-for-kids/playground/mission_07
ls -a
```

See a file starting with a `.`? That is your target. Read it using the command you know for displaying file contents. Write down the word you find — it is the seventh piece of your Detective Academy graduation certificate.

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
- **Command substitution** — using `$(...)` to capture the output of a command

---

*You wrote a real program. Not a command — a program. It has variables, logic, and it speaks. Commander Chen would approve.*

*Ready for Mission 8?*
