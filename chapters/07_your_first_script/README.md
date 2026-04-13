# CASE FILE #7 — The Automation Agent

**Terminal Detective Agency | Clearance Level: FIELD OPERATIVE**

---

## 🔍 MISSION BRIEFING

The Terminal Detective Agency has a crisis on its hands.

A dangerous suspect — known only as "The Phantom" — has gone underground, and intel suggests they're about to make a move. The Agency has 10 field agents scattered across the city, and every single one of them needs to receive a personalized warning letter. Today. Right now. The clock is ticking.

Here's the problem: doing it manually would take almost an hour. Open a template, type the agent's name, change the date, change the case number, save it, print it, repeat — ten times. Way too slow. The Phantom will be long gone by the time the last letter is sealed.

But YOU have a secret weapon: the shell script. A script is a program you write once that the computer runs automatically, over and over, as fast as lightning. While other agents are still typing the third letter by hand, your script will have already finished all ten — personalized, formatted, and saved.

Your mission today is to write a script that reads a list of agent names from `names.txt`, uses the Agency's letter template in `template.txt`, and automatically generates ten complete, personalized warning letters. One for each field agent. Done in seconds.

That's not just faster. That's a completely different kind of intelligence.

**Access your case files:**
```bash
cd playground/mission_07
```

---

## 📚 DETECTIVE TRAINING: Shell Scripts

### What Is a Script?

Every command you've typed so far — `ls`, `cd`, `grep`, `find`, `wc` — you've typed them one at a time, one by one, one after the other. Each time you need a result, you type a command. Each time you want something different, you type another one. That works great for exploring and investigating. But for *repeating* a task — doing the same thing over and over with different data — it's painfully slow.

A **script** changes everything.

A script is a text file that contains a whole sequence of commands, saved so you can run them all at once with a single word. It's a program. A real program — written by you, for your specific purpose.

When your Mac runs a script, it reads the file from top to bottom and executes every command in order. Variables remember values so you don't have to retype them. Logic makes different decisions based on different conditions. Loops repeat actions over and over without you having to do anything. The result is automation: the computer does in ten seconds what would take a human an hour.

Think of a script like a detective's case plan. A good detective doesn't re-invent their whole strategy for every single investigation from scratch — they develop a methodology, write it down as a procedure, and reuse it. When a new case comes in that fits the pattern, they follow the plan. That's exactly what a script does: you define the procedure once, and the computer follows it perfectly every time.

Scripts can be simple (5 lines that print today's date) or incredibly complex (thousands of lines that manage an entire computer system). But they all start the same way: with a shebang, some commands, and a file saved to disk.

---

### The Shebang Line — The First Line of Every Script

Every script must start with a special first line called the **shebang**:

```bash
#!/bin/zsh
```

This tells your Mac: "Use the program located at `/bin/zsh` to interpret and run this file." The `#!` combination is pronounced "hash-bang" — which then gets smooshed together into the nickname "shebang." It's always the very first line of the file, no exceptions, no blank lines before it.

Why do we need this? Your Mac needs to know *which programming language interpreter* to use for the script. There are many shell languages: `bash`, `zsh`, `fish`, `sh`, and others. There are also completely different languages like Python (`#!/usr/bin/python3`) and Ruby (`#!/usr/bin/ruby`). The shebang tells the OS which one to call.

On modern Macs, your default shell is `zsh`, so we'll use:
```bash
#!/bin/zsh
```

You might also see `#!/bin/bash` in older scripts and online tutorials — that uses the older bash shell and works fine for everything in this book. The starter script in your case files uses `#!/bin/zsh` because you're on a modern Mac.

**Pro tip:** You can find out where zsh lives with `which zsh`:
```bash
which zsh
```

Output: `/bin/zsh` — confirming that's the right path for the shebang.

---

### Variables — Your Evidence Storage

Variables are containers. They hold a value (a piece of information) and let you use that value again and again throughout your script without retyping it.

```bash
agent_name="Agent Rivera"
case_number="TDA-2026-007"
priority="HIGH"
```

**Three important rules:**
1. No spaces around the `=` sign — `name = "Rivera"` will FAIL with a confusing error
2. Variable names are CASE_SENSITIVE — `Agent_Name`, `agent_name`, and `AGENT_NAME` are three completely different variables
3. Use `$` to read the value out of a variable

```bash
echo "Briefing for: $agent_name"
echo "Case: $case_number"
echo "Priority: $priority"
```

Output:
```
Briefing for: Agent Rivera
Case: TDA-2026-007
Priority: HIGH
```

**Double quotes vs. single quotes — this matters:**

```bash
agent="Rivera"
echo "Hello, $agent"     # → Hello, Rivera    (variable EXPANDS inside double quotes)
echo 'Hello, $agent'     # → Hello, $agent    (NO expansion — single quotes are literal)
```

Double quotes let variables expand — they're replaced with their values. Single quotes treat everything as completely literal text, dollar signs and all. This distinction becomes very important when writing scripts. As a general rule: use double quotes when you want variables to work, use single quotes only when you specifically want literal text.

**Curly braces around variable names:**

Sometimes you need to be explicit about where a variable name ends:

```bash
agent="Rivera"
echo "Agent${agent}Files"    # → AgentRiveraFiles (braces make boundary clear)
echo "Agent$agentFiles"      # → Agent (ERROR: looks for variable named "agentFiles")
```

Using `${variable}` with curly braces is always safe and often clearer.

---

### Command Substitution — Capturing Command Output

Here's one of the most powerful ideas in shell scripting: you can run a command and store its output in a variable.

```bash
today=$(date +"%B %d, %Y")
file_count=$(ls | wc -l)
current_dir=$(pwd)

echo "Today's date: $today"
echo "Files here: $file_count"
echo "Working in: $current_dir"
```

The `$(...)` syntax — dollar sign, opening parenthesis, a command, closing parenthesis — runs the command inside and captures whatever it would have printed to the screen. That captured output becomes the variable's value.

This is incredibly useful. Nearly any command's output can become a variable:

```bash
agent_count=$(wc -l < playground/mission_07/names.txt)
template_lines=$(wc -l < playground/mission_07/template.txt)

echo "Processing $agent_count agents"
echo "Template is $template_lines lines long"
```

---

### Arithmetic — The `$(( ))` Syntax

Shell scripts can do math using double parentheses:

```bash
x=5
y=3
result=$((x + y))
echo "$x + $y = $result"     # → 5 + 3 = 8
```

Supported operators:
- `+` addition
- `-` subtraction
- `*` multiplication
- `/` division (integer division — `$((7 / 2))` = 3, not 3.5)
- `%` modulo (remainder — `$((7 % 2))` = 1)
- `**` exponentiation — `$((2 ** 10))` = 1024

You can also increment a counter:
```bash
count=0
count=$((count + 1))     # count is now 1
count=$((count + 1))     # count is now 2
echo "Count: $count"     # → Count: 2
```

---

### Making a Script Executable

Scripts are just text files. Before your Mac will run a text file as a program, you need to give it **execute permission** — explicitly telling the system "yes, this file is meant to be run as a program."

That's done with `chmod`:

```bash
chmod +x yourscript.sh
```

`chmod` = **ch**ange **mod**e (file permissions). `+x` = add e**x**ecute permission. You only need to do this once per script file — it's a one-time setup step.

After granting execute permission, you can run the script two ways:

```bash
bash yourscript.sh         # Run it by explicitly calling bash
./yourscript.sh            # Run it as a program (requires chmod +x first)
```

The `./` means "look in the current directory." Your Mac doesn't automatically check the current folder for programs (that would be a security risk), so `./` tells it exactly where to look.

**Check a file's permissions:**
```bash
ls -l playground/mission_07/starter_script.sh
```

Output before `chmod +x`:
```
-rw-r--r--  1 user  staff  542 Apr 13 10:00 starter_script.sh
```

After `chmod +x`:
```
-rwxr-xr-x  1 user  staff  542 Apr 13 10:00 starter_script.sh
```

See the `x` characters that appeared? Those indicate execute permission. We'll explore permissions in much more depth in Mission 11. For now, just remember: `chmod +x yourscript.sh` unlocks the script.

---

### The `nano` Text Editor — Writing Scripts in the Terminal

`nano` is the friendliest text editor that runs entirely inside Terminal. There's no graphical interface, no mouse — just text. But it's powerful enough for writing scripts, and it's available everywhere, even on remote servers.

Open any file with nano:
```bash
nano ~/hello.sh
```

You'll see the file contents (or a blank screen for a new file) with a menu at the bottom showing available commands:

```
^G = Get Help     ^O = Write Out (save)    ^W = Where Is (search)
^X = Exit         ^K = Cut Text            ^U = Paste Text
^A = Start of line   ^E = End of line
```

The `^` symbol means `Ctrl`. So:
- `Ctrl+O` then Enter = save the file ("Write Out")
- `Ctrl+X` = exit nano
- `Ctrl+W` = search for text
- `Ctrl+K` = cut the current line
- `Ctrl+U` = paste the cut line

The nano editing workflow:
1. `nano script.sh` — open the file
2. Type or edit your commands
3. `Ctrl+O` then press Enter — save
4. `Ctrl+X` — exit back to the terminal

**Other editor options:**
- `vim` — extremely powerful but has a steep learning curve (type `i` to insert, `Esc :wq` to save and quit)
- `code filename` — opens in VS Code if you have it installed (visual, mouse-friendly)

Nano is recommended for this book because it works everywhere and doesn't require any installation.

---

### Comments — Leave Notes for Future-You

In a script, any line that starts with `#` is a **comment** — the computer completely ignores it when running the script. Comments exist entirely for humans reading the code.

```bash
#!/bin/zsh
# generate_letters.sh — Automated warning letter generator
# Terminal Detective Agency — Mission 7
# Written by Agent [Your Name], April 2026

# This variable holds the path to our template file
TEMPLATE="playground/mission_07/template.txt"

agent_name="Agent Rivera"     # Will be replaced by the loop
echo "Generating letter for $agent_name..."
```

Good comments serve a few purposes:
- **File header:** explain what the script does, who wrote it, when
- **Section dividers:** organize long scripts into readable blocks
- **Explain the why:** the code shows *what* it does; comments explain *why* you made a particular choice
- **Temporary disabling:** put `#` in front of a line to skip it without deleting it

Over-commented code can actually be harder to read than well-named code. Aim for comments that add information the code can't express on its own.

---

### The `read` Command — Asking Questions

A script can pause and ask the user to type something. The `read` command waits for input and stores it in a variable:

```bash
echo "What is your agent name?"
read agent_name
echo "Welcome, $agent_name. Your mission begins now."
```

When the script hits `read agent_name`, everything pauses. The cursor blinks, waiting. Whatever you type (followed by Enter) gets stored in `agent_name`. Then the script continues from where it left off.

The `-p` flag lets you show the prompt on the same line as the cursor:
```bash
read -p "Enter agent name: " agent_name
echo "Briefing for $agent_name..."
```

The `-s` flag makes input silent (characters don't appear as you type — useful for passwords):
```bash
read -s -p "Enter access code: " code
echo ""     # Print a newline since read -s doesn't add one
echo "Code received."
```

---

### `sed` — The Find-and-Replace Expert

`sed` stands for **s**tream **ed**itor. It reads text, makes substitutions, and outputs the result. Think of it as Find & Replace from a word processor, but running in a pipeline from the command line.

The most common `sed` operation is the substitute command:

```bash
sed 's/OLD_TEXT/NEW_TEXT/g' filename
```

Breaking this down:
- `s` — substitute (replace)
- `/OLD_TEXT/` — the text to find
- `/NEW_TEXT/` — the text to replace it with
- `/g` — global flag: replace ALL occurrences on each line, not just the first
- `filename` — the file to process

Example — replace a placeholder with a real name:
```bash
sed 's/AGENT_NAME/Agent Rivera/g' playground/mission_07/template.txt
```

This reads `template.txt`, replaces every instance of `AGENT_NAME` with `Agent Rivera`, and prints the result to the screen. **The original file is unchanged** — sed sends its output to stdout (the screen) by default.

To save the result to a new file, redirect the output:
```bash
sed 's/AGENT_NAME/Agent Rivera/g' playground/mission_07/template.txt > /tmp/letter_rivera.txt
```

**Multiple substitutions in one command:**
```bash
sed 's/AGENT_NAME/Agent Rivera/g; s/CASE_NUMBER/TDA-2026-007/g; s/TODAY_DATE/April 13, 2026/g' playground/mission_07/template.txt
```

Separate multiple substitutions with semicolons inside the quotes. Each one runs in sequence on the same text.

**Using variables inside sed:**

This is critical for automation! When the agent name comes from a variable:
```bash
agent="Agent Yamamoto"
sed "s/AGENT_NAME/$agent/g" playground/mission_07/template.txt
```

Notice: you **must** use **double quotes** (not single quotes) around the sed expression when it contains variables. Single quotes prevent variable expansion — `$agent` would be treated as literal text, not replaced with `Yamamoto`.

---

### Loops — Do the Same Thing Many Times

Loops are how you process all 10 agents without writing the same code 10 times. You write the logic once, and the loop applies it to every item automatically.

**The `for` loop over a list:**
```bash
for name in "Agent Rivera" "Agent Yamamoto" "Agent Okafor"; do
    echo "Processing: $name"
done
```

Output:
```
Processing: Agent Rivera
Processing: Agent Yamamoto
Processing: Agent Okafor
```

The loop sets `name` to the first value, runs everything between `do` and `done`, then moves to the next value. When the list is exhausted, the loop stops.

**The `while` loop — reading a file line by line:**

For processing `names.txt` (one agent per line), a `while` loop is perfect:
```bash
while IFS= read -r line; do
    echo "Agent: $line"
done < playground/mission_07/names.txt
```

This reads `names.txt` one line at a time. Each line is stored in `$line`. When there are no more lines, the loop stops. `IFS=` and `-r` are safety flags: `IFS=` prevents stripping of leading/trailing spaces, `-r` prevents backslash characters from being treated as escape sequences.

**Arrays — lists stored in a variable:**
```bash
agents=("Agent Rivera" "Agent Yamamoto" "Agent Okafor" "Agent Singh")

# Loop over an array
for agent in "${agents[@]}"; do
    echo "Sending letter to: $agent"
done

# Access a specific element (zero-indexed)
echo "${agents[0]}"    # → Agent Rivera
echo "${agents[2]}"    # → Agent Okafor

# Count elements
echo "Total agents: ${#agents[@]}"    # → Total agents: 4
```

`${agents[@]}` means "all elements." `${#agents[@]}` counts them. Arrays are incredibly useful for storing and processing lists of data.

---

### `printf` — Formatted Output

`echo` is simple but limited. `printf` (print formatted) gives you precise control over how text appears:

```bash
printf "%-20s | %s\n" "Agent Rivera" "Letter #1"
printf "%-20s | %s\n" "Agent Yamamoto" "Letter #2"
printf "%-20s | %s\n" "Agent Okafor" "Letter #3"
```

Output:
```
Agent Rivera         | Letter #1
Agent Yamamoto       | Letter #2
Agent Okafor         | Letter #3
```

Format specifiers:
- `%s` — a string
- `%d` — a decimal integer
- `%-20s` — a string, left-aligned, padded to 20 characters wide
- `%03d` — an integer, padded with zeros to at least 3 digits wide: `001`, `002`, etc.
- `\n` — newline character

`printf` doesn't automatically add a newline (unlike `echo`), so you need to add `\n` yourself. This gives you precise control over spacing and formatting.

Creating zero-padded filenames:
```bash
for i in {1..10}; do
    filename=$(printf "letter_%03d.txt" $i)
    echo "$filename"
done
```

Output:
```
letter_001.txt
letter_002.txt
...
letter_010.txt
```

This keeps files sorted correctly — `letter_002.txt` comes before `letter_010.txt` alphabetically.

---

### `tr` — Translating Characters

`tr` translates (replaces) one set of characters with another. It's useful for cleaning up text:

```bash
echo "Agent Rivera" | tr ' ' '_'     # → Agent_Rivera (spaces to underscores)
echo "hello world" | tr 'a-z' 'A-Z' # → HELLO WORLD  (lowercase to uppercase)
echo "Agent Rivera" | tr -d ' '      # → AgentRivera  (delete spaces)
```

In the letter-generator script, `tr` converts agent names to safe filenames:
```bash
agent_name="Agent Rivera"
safe_name=$(echo "$agent_name" | tr ' ' '_')
echo "$safe_name"    # → Agent_Rivera
output_file="letters/letter_${safe_name}.txt"
# → letters/letter_Agent_Rivera.txt
```

---

### Pro Tips — Script Writing Best Practices

Before diving into the experiments, here are habits that separate good scripts from great ones:

**1. Always test with `echo` before doing destructive things.**

If your script moves, deletes, or overwrites files, comment out the actual command first and replace it with `echo` to preview what *would* happen:

```bash
# Instead of this (which actually renames files):
# mv "$file" "$new_path"

# Do this first to preview:
echo "Would rename: $file → $new_path"
```

Once you've confirmed the output looks right, swap back to the real command.

**2. Always use double quotes around variables in file paths.**

```bash
# WRONG — breaks if path has spaces:
cat $TEMPLATE

# RIGHT — handles spaces correctly:
cat "$TEMPLATE"
```

File paths on real computers often have spaces. Make this a habit from the start.

**3. Use `set -e` to stop on errors.**

Add this near the top of any script where errors would cause problems:
```bash
#!/bin/zsh
set -e    # Exit immediately if any command fails
```

Without `set -e`, if one command fails silently, the rest of the script keeps running and you end up with confusing, partial results.

**4. Print what you're doing.**

```bash
echo "Creating output directory: $OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"
echo "Processing $agent_count agents..."
```

Progress messages help you understand what's happening and debug problems when something goes wrong.

**5. Use descriptive variable names.**

```bash
# BAD — what is x? what does n mean?
x="TDA-2026-007"
n=10

# GOOD — self-documenting
case_number="TDA-2026-007"
agent_count=10
```

Code is read far more often than it's written. Make it readable.

---

## 🧪 FIELD WORK

Time to get hands-on with the actual case files. Work through every experiment — they build toward the mission project.

**First, read the case briefing:**
```bash
cat playground/mission_07/case_briefing.txt
```

**Examine the letter template carefully:**
```bash
cat playground/mission_07/template.txt
```

Note every placeholder in the template: `AGENT_NAME`, `CASE_NUMBER`, `TODAY_DATE`, and `PRIORITY_LEVEL`. Each one will be replaced by your script using `sed`.

**See the list of agents who need letters:**
```bash
cat playground/mission_07/names.txt
```

Count them to confirm there are exactly 10:
```bash
wc -l playground/mission_07/names.txt
```

**Look at the starter script:**
```bash
cat playground/mission_07/starter_script.sh
```

This script has the skeleton already built — shebang, some variables, some structure. Look for the `# TODO` comments that mark what you need to fill in.

**Make it executable right now:**
```bash
chmod +x playground/mission_07/starter_script.sh
```

**Run the starter script to see its current state:**
```bash
./playground/mission_07/starter_script.sh
```

---

**Experiment 1:** Test `sed` substitution on a single placeholder.

```bash
sed 's/AGENT_NAME/Agent Rivera/g' playground/mission_07/template.txt
```

You should see the template with `AGENT_NAME` replaced throughout. Now replace all four placeholders at once:

```bash
sed 's/AGENT_NAME/Agent Rivera/g; s/CASE_NUMBER/TDA-2026-007/g; s/TODAY_DATE/April 13, 2026/g; s/PRIORITY_LEVEL/HIGH/g' playground/mission_07/template.txt
```

That's a complete personalized letter for Agent Rivera! All four placeholders filled in, in a single command.

**Experiment 2:** Save the letter to a file.

```bash
sed 's/AGENT_NAME/Agent Rivera/g' playground/mission_07/template.txt > /tmp/test_letter.txt
cat /tmp/test_letter.txt
ls -la /tmp/test_letter.txt
```

The `>` redirects the output to a file instead of the screen.

**Experiment 3:** Use a variable with sed — and get the quoting right.

```bash
agent="Agent Yamamoto"
sed "s/AGENT_NAME/$agent/g" playground/mission_07/template.txt
```

Notice the double quotes around the sed expression. Now try it with single quotes and see what happens:
```bash
sed 's/AGENT_NAME/$agent/g' playground/mission_07/template.txt
```

With single quotes, `$agent` appears literally in the output instead of being replaced with `Yamamoto`. This is a very common mistake — remember: **double quotes for sed when using variables**.

**Experiment 4:** Loop over the names file.

```bash
while IFS= read -r name; do
    echo "Processing: $name"
done < playground/mission_07/names.txt
```

You should see all 10 agent names printed one by one. The loop processes the file automatically — no manual intervention needed.

**Experiment 5:** Generate one letter per agent (preview of the full mission).

```bash
while IFS= read -r agent_name; do
    safe_name=$(echo "$agent_name" | tr ' ' '_')
    echo "Would create: letters/letter_${safe_name}.txt"
done < playground/mission_07/names.txt
```

This shows what the full script will do — one output filename per agent.

**Experiment 6:** Test printf formatting.

```bash
counter=1
while IFS= read -r name; do
    printf "%02d. %-25s → letter_%02d.txt\n" $counter "$name" $counter
    counter=$((counter + 1))
done < playground/mission_07/names.txt
```

See how the output lines up in neat columns? That's `printf` doing the formatting work.

**Experiment 7:** Variable math and date formatting.

```bash
x=5
y=3
echo "$x + $y = $((x + y))"
echo "$x × $y = $((x * y))"
echo "$x ÷ $y = $((x / y))"

today=$(date +"%B %d, %Y")
echo "Today is: $today"
```

**Experiment 8:** Create a simple hello-world script from scratch with nano.

```bash
nano /tmp/hello_agent.sh
```

Type this exactly:
```bash
#!/bin/zsh
# A simple greeting script for Terminal Detectives

read -p "Enter your agent codename: " my_name
today=$(date +"%A, %B %d")
hour=$(date +"%H")

if [ "$hour" -lt 12 ]; then
    greeting="Good morning"
else
    greeting="Good day"
fi

echo ""
echo "$greeting, $my_name!"
echo "Today is $today."
echo "The Terminal Detective Agency awaits your brilliance."
echo ""
```

Save with `Ctrl+O` then Enter. Exit with `Ctrl+X`. Then:
```bash
chmod +x /tmp/hello_agent.sh
/tmp/hello_agent.sh
```

Type your agent codename when asked. Your first custom script!

**Experiment 9:** Build an array of fun facts.

```bash
facts=(
    "A group of flamingos is called a flamboyance."
    "Octopuses have three hearts and blue blood."
    "Crows can recognize human faces and hold grudges."
    "The unicorn is the national animal of Scotland."
    "Bananas are technically berries. Strawberries are not."
)

# Pick a random fact
index=$((RANDOM % ${#facts[@]}))
echo "Fun fact: ${facts[$index]}"
```

Run it multiple times. `$RANDOM` produces a different number each time (0 through 32767). The `%` operator limits it to the array size so you always get a valid index.

---

## 🎯 MISSION: Generate the Warning Letters

Complete `starter_script.sh` so it generates personalized warning letters for all 10 agents in `names.txt` and saves each letter to a `letters/` folder inside `playground/mission_07/`.

**What the completed script must do:**
1. Read each agent name from `names.txt` line by line
2. For each agent, use `sed` to replace ALL placeholders in `template.txt`
3. Create a safe filename from the agent name (spaces become underscores)
4. Save the personalized letter to `playground/mission_07/letters/letter_AgentName.txt`
5. Print a confirmation message for each letter created
6. Print a final summary showing the total number of letters generated

**Open the starter script:**
```bash
nano playground/mission_07/starter_script.sh
```

Find the `# TODO` sections. Fill them in. If you get stuck, the complete solution is below — but try it yourself first!

**Complete solution:**

```bash
#!/bin/zsh
# generate_letters.sh — Personalized warning letter generator
# Terminal Detective Agency — Mission 7
# Generates warning letters for all field agents in names.txt

# === SETTINGS ===
TEMPLATE="playground/mission_07/template.txt"
NAMES_FILE="playground/mission_07/names.txt"
OUTPUT_DIR="playground/mission_07/letters"
CASE_NUMBER="TDA-2026-007"
TODAY_DATE=$(date +"%B %d, %Y")
PRIORITY="HIGH"

# === CREATE OUTPUT FOLDER ===
# mkdir -p creates the folder and any needed parent folders
# The -p flag prevents errors if the folder already exists
mkdir -p "$OUTPUT_DIR"

echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║   TERMINAL DETECTIVE AGENCY                  ║"
echo "║   AUTOMATED WARNING LETTER GENERATOR         ║"
echo "╚══════════════════════════════════════════════╝"
echo ""
echo "  Template:    $TEMPLATE"
echo "  Agent list:  $NAMES_FILE"
echo "  Output:      $OUTPUT_DIR"
echo "  Date:        $TODAY_DATE"
echo "  Case:        $CASE_NUMBER"
echo ""
echo "──────────────────────────────────────────────"
echo ""

# === GENERATE ONE LETTER PER AGENT ===
letter_count=0

while IFS= read -r agent_name; do
    # Skip blank lines in the names file
    if [[ -z "$agent_name" ]]; then
        continue
    fi

    # Convert "Agent Rivera" → "Agent_Rivera" for the filename
    safe_name=$(echo "$agent_name" | tr ' ' '_')
    output_file="$OUTPUT_DIR/letter_${safe_name}.txt"

    # Use sed to replace ALL placeholders in the template
    # Double quotes required so $variables expand inside sed
    sed "s/AGENT_NAME/$agent_name/g; \
         s/CASE_NUMBER/$CASE_NUMBER/g; \
         s/TODAY_DATE/$TODAY_DATE/g; \
         s/PRIORITY_LEVEL/$PRIORITY/g" "$TEMPLATE" > "$output_file"

    # Print a status line
    printf "  Generated: letter_%s.txt\n" "$safe_name"

    # Increment the counter
    letter_count=$((letter_count + 1))

done < "$NAMES_FILE"

# === FINAL SUMMARY ===
echo ""
echo "──────────────────────────────────────────────"
echo ""
printf "  Letters generated: %d\n" "$letter_count"
printf "  All saved to:      %s/\n" "$OUTPUT_DIR"
echo ""
echo "  Mission status: COMPLETE"
echo "  The Phantom's agents have been warned."
echo ""
```

**Run it:**
```bash
chmod +x playground/mission_07/starter_script.sh
./playground/mission_07/starter_script.sh
```

**Verify the letters were created:**
```bash
ls playground/mission_07/letters/
```

**Count them:**
```bash
ls playground/mission_07/letters/ | wc -l
```

**Read one to check it looks correct:**
```bash
cat playground/mission_07/letters/letter_Agent_Rivera.txt
```

The letter should be fully filled in — no more `AGENT_NAME` placeholders. Agent Rivera's name appears exactly where it should.

**Spot-check another one:**
```bash
cat playground/mission_07/letters/letter_Agent_Yamamoto.txt
```

Every letter should be identical except for the agent's name. That's personalization at scale — the power of shell scripting.

---

## 🏆 BONUS MISSIONS

### Bonus Mission 1 — Add a Precise Timestamp

The current script uses just a date. Modify it to also include the exact time each letter was generated. Create a `TIMESTAMP` variable:

```bash
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
```

Add a `TIMESTAMP` placeholder to the template (open it with nano), then add `s/TIMESTAMP/$TIMESTAMP/g` to your `sed` command chain. Run the script again and check that each letter now shows exactly when it was created.

### Bonus Mission 2 — Unique Case Numbers Per Agent

Right now every letter gets the same case number. Make each agent receive their own unique case number using the loop counter:

```bash
letter_count=0
while IFS= read -r agent_name; do
    letter_count=$((letter_count + 1))
    unique_case=$(printf "TDA-2026-%03d" $letter_count)
    # Use $unique_case in your sed command instead of $CASE_NUMBER
    sed "s/CASE_NUMBER/$unique_case/g; ..." "$TEMPLATE" > "$output_file"
done < "$NAMES_FILE"
```

Each agent gets their own number: TDA-2026-001, TDA-2026-002, through TDA-2026-010. Open a few letters to confirm they're different.

### Bonus Mission 3 — Priority Based on Position

Field agents at the top of `names.txt` are highest priority. Modify the script so:
- Letters 1-3 (first three agents) get `PRIORITY_LEVEL=CRITICAL`
- Letters 4-7 get `PRIORITY_LEVEL=HIGH`
- Letters 8-10 get `PRIORITY_LEVEL=STANDARD`

Use an `if/elif/else` statement inside the loop:
```bash
if [ $letter_count -le 3 ]; then
    PRIORITY="CRITICAL"
elif [ $letter_count -le 7 ]; then
    PRIORITY="HIGH"
else
    PRIORITY="STANDARD"
fi
```

### Bonus Mission 4 — The Morning Briefing Script

Build a personal script that gives you a detective-style morning briefing every day. Create it at `~/morning.sh`:

```bash
#!/bin/zsh
# morning.sh — Daily morning briefing for a Terminal Detective

MY_NAME="Agent [Your Codename Here]"
MY_VOICE="Samantha"    # change to your favorite voice

DATE_FULL=$(date +"%A, %B %d, %Y")
DATE_DAY=$(date +"%A")
DATE_SHORT=$(date +"%B %d")
HOUR=$(date +"%H")

# Choose greeting based on time of day
if [ "$HOUR" -lt 12 ]; then
    GREETING="Good morning"
elif [ "$HOUR" -lt 17 ]; then
    GREETING="Good afternoon"
else
    GREETING="Good evening"
fi

# Array of fun facts — add your own!
FACTS=(
    "A group of flamingos is called a flamboyance."
    "Honey never expires — 3000-year-old honey was found in Egyptian tombs."
    "Octopuses have three hearts and blue blood."
    "A day on Venus is longer than a year on Venus."
    "Crows can recognize human faces and hold grudges for years."
    "The unicorn is the national animal of Scotland."
    "Bananas are technically berries. Strawberries are not."
    "There are more possible chess games than atoms in the observable universe."
    "Butterflies taste with their feet."
    "Wombat droppings are cube-shaped."
)

# Pick a random fact from the array
RANDOM_INDEX=$((RANDOM % ${#FACTS[@]}))
FUN_FACT="${FACTS[$RANDOM_INDEX]}"

# Print the briefing
echo ""
echo "╔════════════════════════════════════════════╗"
echo "║       TERMINAL DETECTIVE AGENCY            ║"
echo "║       MORNING BRIEFING                     ║"
echo "╚════════════════════════════════════════════╝"
echo ""
echo "  $GREETING, $MY_NAME!"
echo "  Today is $DATE_FULL"
echo ""
echo "  Daily Intelligence:"
echo "  $FUN_FACT"
echo ""
echo "──────────────────────────────────────────────"
echo ""

# Speak the briefing out loud
say -v "$MY_VOICE" "$GREETING $MY_NAME! Today is $DATE_DAY, $DATE_SHORT."
say -v "$MY_VOICE" "Daily intelligence: $FUN_FACT"
say -v "$MY_VOICE" "Have an exceptional day, Agent!"
```

Make it executable and run it:
```bash
chmod +x ~/morning.sh
~/morning.sh
```

Run it several times — you get a different fun fact every time! Customize the name, add more facts to the array, change the voice, add more sections. This is YOUR script.

### Bonus Mission 5 — Days Until Special Date

Add a countdown to your morning script. How many days until something you're excited about?

```bash
# Days until a target date (adjust the date!):
TODAY_SECONDS=$(date +%s)
TARGET_SECONDS=$(date -j -f "%Y-%m-%d" "2026-12-25" +%s 2>/dev/null)

if [ -n "$TARGET_SECONDS" ]; then
    DAYS_LEFT=$(( (TARGET_SECONDS - TODAY_SECONDS) / 86400 ))
    if [ $DAYS_LEFT -gt 0 ]; then
        echo "  Days until December 25th: $DAYS_LEFT"
    elif [ $DAYS_LEFT -eq 0 ]; then
        echo "  Today is December 25th!"
    fi
fi
```

`date +%s` gives the current time in "Unix time" — seconds since January 1, 1970. Subtracting two Unix timestamps gives elapsed seconds. Divide by 86400 (seconds in a day) and you get the number of days. Change `2026-12-25` to any date you want!

### Bonus Mission 6 — The Interactive Welcome Script

Create a new script `~/welcome.sh` that:
1. Asks for your name using `read`
2. Asks for your favorite color
3. Asks for your mission specialization (hacking, surveillance, analysis, etc.)
4. Prints a custom Agency ID card using all three answers
5. Makes your Mac say the ID card details out loud with `say`

```bash
#!/bin/zsh
echo ""
echo "=== TERMINAL DETECTIVE AGENCY ==="
echo "=== NEW OPERATIVE REGISTRATION ==="
echo ""

read -p "Agent name: " name
read -p "Favorite color: " color
read -p "Specialization: " specialty

echo ""
echo "╔═══════════════════════════════╗"
echo "║  AGENCY OPERATIVE ID CARD     ║"
echo "╠═══════════════════════════════╣"
printf "║  Name:  %-22s║\n" "$name"
printf "║  Color: %-22s║\n" "$color"
printf "║  Role:  %-22s║\n" "$specialty"
echo "╚═══════════════════════════════╝"
echo ""

say "Welcome to the Terminal Detective Agency, $name. Your specialization in $specialty will serve us well."
```

---

## 🔐 CODE PIECE UNLOCKED!

You automated what would have taken an hour. Ten personalized letters, perfectly generated in seconds. You read a file, processed every line, ran substitutions, created output files, and built a summary report. That's not just a script — that's real software.

The Phantom sent chaos. You answered with automation.

**Code Piece #7: CRACKING**

```bash
cat playground/mission_07/secret_code_piece.txt
```

Write it down carefully. The full secret code only reveals itself when all twelve pieces are assembled.

---

## ⚡ POWERS UNLOCKED

| Concept | How It Works |
|---------|-------------|
| `#!/bin/zsh` | Shebang — first line of every script, tells the OS which interpreter to use |
| `name="value"` | Create a variable (no spaces around `=`) |
| `$name` | Read a variable's value |
| `${name}` | Read a variable's value (explicit boundaries with curly braces) |
| `$(command)` | Command substitution — capture command output as a value |
| `$((expression))` | Arithmetic — `$((5 + 3))` = 8 |
| `read varname` | Read user input into a variable (waits for Enter) |
| `read -p "prompt: " var` | Read input with an inline prompt |
| `read -s varname` | Read input silently (characters hidden — good for passwords) |
| `chmod +x file` | Give a file execute permission (do this once per script) |
| `bash file.sh` | Run a script explicitly with bash |
| `./file.sh` | Run an executable script in the current folder |
| `# comment` | Line comment — ignored by the computer, read by humans |
| `nano file` | Open file in the nano text editor inside Terminal |
| `Ctrl+O` then Enter | Save the current file in nano ("Write Out") |
| `Ctrl+X` | Exit nano |
| `Ctrl+W` | Search for text in nano |
| `sed 's/OLD/NEW/g' file` | Replace ALL occurrences of OLD with NEW in a file |
| `sed 's/OLD/NEW/g; s/A/B/g' file` | Multiple substitutions chained with semicolons |
| `sed "s/OLD/$var/g" file` | Replace using a variable (requires double quotes, not single) |
| `command > file` | Redirect output to a file (overwrites if exists) |
| `command >> file` | Append output to a file (adds to end) |
| `while IFS= read -r line; do ... done < file` | Read a file line by line |
| `for item in list; do ... done` | Loop over a list of items |
| `printf "format" values` | Formatted output with precise control over alignment |
| `printf "%03d" $n` | Format number padded with zeros: 001, 002, etc. |
| `ARRAY=(a b c)` | Create an array (list) |
| `${ARRAY[@]}` | All elements of the array |
| `${ARRAY[0]}` | First element (zero-indexed) |
| `${#ARRAY[@]}` | Number of elements in the array |
| `$RANDOM` | A random integer between 0 and 32767 |
| `$((RANDOM % N))` | A random number between 0 and N-1 |
| `mkdir -p folder` | Create a folder (and any needed parent folders) |
| `tr ' ' '_'` | Translate (replace) spaces with underscores |
| `tr 'a-z' 'A-Z'` | Convert lowercase letters to uppercase |
| `tr -d ' '` | Delete all spaces |
| `echo "text" \| tr ...` | Pipe text into tr for transformation |
| `which command` | Show where a command is installed |

### Common Mistakes to Avoid

These are the most frequent errors beginners make when writing scripts. Learning to recognize them saves hours of frustration:

**Mistake 1: Spaces around the `=` in variable assignment**
```bash
name = "Rivera"    # WRONG — shell tries to run "name" as a command
name="Rivera"      # CORRECT
```

**Mistake 2: Forgetting `$` when reading a variable**
```bash
echo "Hello, name"     # WRONG — prints literal "name"
echo "Hello, $name"    # CORRECT — prints the value
```

**Mistake 3: Single quotes when you need variable expansion**
```bash
agent="Rivera"
sed 's/AGENT_NAME/$agent/g' file    # WRONG — "$agent" appears literally
sed "s/AGENT_NAME/$agent/g" file    # CORRECT — $agent expands to "Rivera"
```

**Mistake 4: Missing `done` at the end of a loop**
```bash
for file in *.txt; do
    echo "$file"
# Forgot done — will give a syntax error
done    # Required!
```

**Mistake 5: Not making a script executable**
```bash
./myscript.sh    # FAILS with "permission denied" if you forgot chmod +x
chmod +x myscript.sh    # Fix: run this first
```

**Mistake 6: Forgetting `fi` to close an `if` block**
```bash
if [ $x -gt 5 ]; then
    echo "big"
# Missing fi — syntax error when the script runs
fi    # Required!
```

Recognizing these patterns instantly is a skill that comes with practice. When a script gives a confusing error, check for these first.

---

### Detective Vocabulary

- **Script** — a text file containing commands to be run in sequence by an interpreter
- **Shebang** — `#!` followed by the interpreter path; must be the very first line of a script
- **Variable** — a named container holding a value; `name="Rivera"` stores `Rivera`
- **Execute permission** — the right to run a file as a program; granted with `chmod +x`
- **Command substitution** — `$(command)` runs a command and captures its output as a value
- **sed** — stream editor; reads text and makes substitutions; the `s/find/replace/g` syntax
- **Placeholder** — text in a template meant to be replaced during processing (like `AGENT_NAME`)
- **Array** — a variable that holds an ordered list of values
- **Redirect** — `>` sends output to a file instead of the screen
- **Automation** — having a computer perform repetitive tasks that would otherwise require a human
- **Dry run** — running a script in preview mode (with `echo` instead of real commands) to check what it would do before committing

---

*You wrote a real program. Not a single command — a complete program with variables, logic, loops, and file output. It reads data, processes it, and generates results automatically. That is exactly what software developers do for a living.*

*The Phantom thought sending 10 letters would slow the Agency down. Instead, it took you about 10 seconds.*

*Ready for Mission 8?*
