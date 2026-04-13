# Mission 7 — The Automation Agent

## Mission Briefing

*"We need 5 official case assignments sent out immediately," Director Chen says. "Each one personalized with the agent's codename, today's date, and a unique case number. You could type them one by one — or you could write a script and generate all 5 in seconds. Your choice."*

Everything you've been typing — all those commands — you've been typing them one at a time. But what if you could save a whole *sequence* of commands in a file and run them all at once with a single word?

That's a **script**. A script is a program. Today you write your first real one — and use it to automate the TDA's paperwork.

### What You'll Learn
- The shebang line (`#!/bin/bash`)
- Variables — storing values with names
- `chmod +x` — making a file executable
- Reading from a file with loops (preview of Mission 8!)
- The template files waiting in `playground/mission_07/`

---

## What Is a Script?

A script is just a text file containing commands — the same commands you type in Terminal, but saved so you can run them again and again.

The computer needs to know two things:
1. **Which program to run it** (the shebang)
2. **That it's allowed to run** (the execute permission)

---

## The Shebang Line

Every script starts with:

```bash
#!/bin/bash
```

This tells your Mac: "Use bash to run this file." The `#!` is read as "hash-bang" → shebang. It's always the very first line.

---

## Variables

Variables store values you can use and reuse:

```bash
name="Agent CIPHER"
date_today=$(date +"%B %d, %Y")
case_num="TDA-2026-0099"
```

**Rules:**
- No spaces around the `=`
- Use `$` to read the value

```bash
echo "Assignment for: $name"
echo "Date: $date_today"
echo "Case: $case_num"
```

**Quotes matter:**

```bash
name="CIPHER"
echo "Hello $name"     # → Hello CIPHER  (variable expanded)
echo 'Hello $name'     # → Hello $name   (no expansion in single quotes)
```

---

## Making a Script Executable

```bash
touch ~/my_script.sh
nano ~/my_script.sh
```

Type your script, then save (`Ctrl+O`, Enter) and exit (`Ctrl+X`).

Make it executable:

```bash
chmod +x ~/my_script.sh
```

Run it:

```bash
bash ~/my_script.sh
```

---

## Try It! — Quick Experiments

**Experiment 1:** Inspect the template:
```bash
cat playground/mission_07/template.txt
```

See the placeholders: `NAME`, `DATE`, `CASE_NUMBER`

**Experiment 2:** Read the name and case number files:
```bash
cat playground/mission_07/names.txt
cat playground/mission_07/case_numbers.txt
```

**Experiment 3:** Variable substitution by hand:
```bash
NAME="GHOST"
DATE=$(date +"%B %d, %Y")
CASE_NUMBER="TDA-2026-0099"
echo "Assignment for Agent $NAME on $DATE, case $CASE_NUMBER"
```

**Experiment 4:** `read` gets input from the user:
```bash
echo "What is your codename?"
read codename
echo "Hello, Agent $codename!"
```

---

## Pro Tip — Comments

Lines starting with `#` are **comments** — ignored by the computer, but helpful for humans:

```bash
#!/bin/bash
# This script generates case assignments
# Written by Agent ROOKIE

NAME="CIPHER"    # change this to each agent's name
```

Good comments explain *why*, not *what*.

---

## Your Mission — The Case Assignment Generator

Look at the template and build a script that generates personalized case assignments.

**Step 1:** Study the mission files:
```bash
cd playground/mission_07
cat template.txt
cat names.txt
cat case_numbers.txt
```

**Step 2:** Create the script:
```bash
nano ~/assignment_generator.sh
```

**Step 3:** Type this script:

```bash
#!/bin/bash
# assignment_generator.sh — generates TDA case assignments
# Usage: bash ~/assignment_generator.sh

TEMPLATE="playground/mission_07/template.txt"
TODAY=$(date +"%B %d, %Y")

echo "Generating TDA Case Assignments..."
echo "==================================="
echo ""

# Assignment for Agent GHOST
NAME="GHOST"
CASE="TDA-2026-0099"
sed -e "s/NAME/$NAME/g" -e "s/DATE/$TODAY/g" -e "s/CASE_NUMBER/$CASE/g" "$TEMPLATE"
echo ""
echo "---"
echo ""

# Assignment for Agent CIPHER
NAME="CIPHER"
CASE="TDA-2026-0100"
sed -e "s/NAME/$NAME/g" -e "s/DATE/$TODAY/g" -e "s/CASE_NUMBER/$CASE/g" "$TEMPLATE"
echo ""
echo "---"
echo ""

echo "Assignments generated! Total: 2"
```

(`sed` replaces text inside files — a tool we're borrowing here!)

**Step 4:** Make it executable and run it:
```bash
chmod +x ~/assignment_generator.sh
bash ~/assignment_generator.sh
```

**Step 5:** Find the hidden code:
```bash
ls -la playground/mission_07/
cat playground/mission_07/.secret_code.txt
```

---

## Challenges

### Challenge 1 — All Five Agents

Expand the script to generate assignments for all 5 agents in `names.txt` using all 5 case numbers. Each assignment should be separated by a `---` divider.

### Challenge 2 — Save to a File

Modify the script so the output is saved to `~/case_assignments.txt` using `>`. Then read it back with `cat`.

### Challenge 3 — The Welcome Script

Create a new script `~/detective_welcome.sh` that:
1. Asks for your codename using `read`
2. Asks for your specialty
3. Prints a personalized TDA welcome message
4. Makes your Mac say the message with `say`

### Challenge 4 — Custom Date Math

Add a line to your script that tells you how many days until December 25th:

```bash
TODAY_S=$(date +%s)
CHRISTMAS=$(date -j -f "%Y-%m-%d" "2026-12-25" +%s)
DAYS=$(( (CHRISTMAS - TODAY_S) / 86400 ))
echo "Days until Christmas: $DAYS"
```

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
| `# comment` | Line comment (ignored by computer) |

### Vocabulary

- **Script** — a file containing commands to be run in sequence
- **Shebang** — `#!` followed by the path to the interpreter
- **Variable** — a named container for a value
- **Execute permission** — the right to run a file as a program

---

*You wrote a real program. Not a command — a program. That's software.*

*Ready for Mission 8?*
