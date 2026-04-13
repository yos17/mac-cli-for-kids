# Mission 1 — The Talking Computer

## Mission Briefing

*A manila envelope slides under your door. Inside: a single card with three words — "Open the Terminal." This is your invitation to the Terminal Detective Agency.*

Every detective needs a home base. Yours is Terminal — a window where you type commands and your computer obeys. No clicking. No icons. Just you, a blinking cursor, and total control.

In the movies, hackers type really fast into black screens and take over entire systems. That black screen is Terminal. Here's the truth: it's not magic. It's just a different way to talk to your computer. And once you learn the language, you can do things that are completely impossible with clicking alone.

**Today you get your first 5 commands. The agency is watching.**

### What You'll Learn
- How to open Terminal
- What the prompt means
- Your first 5 commands: `whoami`, `date`, `echo`, `say`, `clear`
- How to find hidden files

---

## Opening the Portal

**Step 1:** Press `Cmd + Space` on your keyboard. This opens Spotlight Search.

**Step 2:** Type `Terminal` and press Enter.

You'll see something like this:

```
Last login: Sun Apr 13 10:22:05 on ttys000
yourname@MacBook-Pro ~ %
```

That last line is the **prompt** — Terminal waiting for your command. It's saying: *"I'm ready. What do you want?"*

```
yourname @ MacBook-Pro  ~  %
   |           |         |  |
  You      Your Mac    Where  Ready!
                       you are
```

The `~` means you're in your Home folder.

---

## Your First Commands

### `whoami` — Who Are You?

```bash
whoami
```

Output:
```
sophia
```

You just gave your computer a command and it obeyed. That's how all of this works.

---

### `date` — What Time Is It?

```bash
date
```

Output:
```
Sun Apr 13 10:24:17 PDT 2026
```

---

### `echo` — The Parrot Command

```bash
echo Hello there!
```

Output:
```
Hello there!
```

`echo` is more useful than it looks. Later you'll use it to write things into files, print messages from scripts, and much more.

---

### `say` — Make Your Mac Talk

```bash
say "Mission one is underway"
```

Your Mac speaks those words out loud.

```bash
say -v Victoria "Hello, my name is Victoria"
say -v Fred "Hello, my name is Fred"
```

The `-v` flag lets you pick a voice. A **flag** is extra instructions for a command, always starting with `-`.

See all voices:
```bash
say -v '?' 2>&1 | head -20
```

---

### `clear` — Clean the Screen

```bash
clear
```

Or use `Ctrl + L`. All your old commands are still in history (press Up arrow) — you just have a clean workspace.

---

## Try It! — Quick Experiments

**Experiment 1:** What happens with empty `echo`?
```bash
echo
```
(It prints an empty line — `echo` always prints *something*.)

**Experiment 2:** Silly voices:
```bash
say -v Cellos "I am a robot"
say -v Trinoids "Greetings human"
say -v Zarvox "Take me to your leader"
```

**Experiment 3:** Custom date format:
```bash
date +"%A, %B %d, %Y"
```
Output: `Sunday, April 13, 2026`

**Experiment 4:** Read your welcome letter from the agency!
```bash
cd playground/mission_01
cat welcome.txt
```

---

## Pro Tip — The Up Arrow is Your Best Friend

Press **Up arrow** to go back through your command history. Press **Down** to come forward. Press **Enter** to run that command again.

---

## Your Mission — Report to the Terminal Detective Agency

The agency left files for you in `playground/mission_01/`. Go investigate:

**Step 1:** Navigate to your mission folder:
```bash
cd playground/mission_01
```

**Step 2:** List what's there:
```bash
ls
```

You'll see: `welcome.txt` and `agents.txt`

**Step 3:** Read your welcome letter:
```bash
cat welcome.txt
```

**Step 4:** Read the agents roster:
```bash
cat agents.txt
```

**Step 5:** The welcome letter mentions a hidden file. Find it:
```bash
ls -la
```

See the file starting with `.`? Hidden files start with a dot. Read it:
```bash
cat .secret_code.txt
```

**Step 6:** Report your identity to the agency:
```bash
echo "==========================="
echo "   TERMINAL DETECTIVE AGENCY   "
echo "==========================="
echo ""
echo "Agent name: $(whoami)"
echo "Reporting for duty on: $(date +"%A, %B %d, %Y")"
say "Agent $(whoami) reporting for duty. Mission one complete."
```

Write down the **code word** from `.secret_code.txt` — you'll need it at the end!

---

## Challenges

### Challenge 1 — Your Agent Voice Message

Make your Mac introduce you as a detective using 3 `say` commands with different voices:
1. Your name
2. Your specialty (make one up!)
3. A catchphrase

**Hint:** `say -v [VoiceName] "your text here"`

### Challenge 2 — The Custom Date

Make `date` print only the current year. Then print only the current month name.

**Hint:** Look at the format codes: `%Y` = year, `%B` = month name, `%d` = day number.

### Challenge 3 — TDA ASCII Art

Use `echo` to draw the TDA logo using characters:

```
echo "  _____ ____    _    "
echo " |_   _|  _ \  / \   "
echo "   | | | | | |/ _ \  "
echo "   | | | |_| / ___ \ "
echo "   |_| |____/_/   \_\\"
```

Try making your own!

### Challenge 4 — Explore Voices

Find at least 5 different voices and write down your favorite. You'll use it in later missions.

**Hint:** Run `say -v '?' 2>&1` to see all voices.

---

## Solutions

Solutions are in the [solutions folder](solutions/README.md).

---

## Powers Unlocked

| Command | What It Does |
|---------|-------------|
| `whoami` | Prints your username |
| `date` | Prints the current date and time |
| `date +"%format"` | Prints the date in a custom format |
| `echo text` | Prints text to the screen |
| `say "text"` | Makes your Mac speak out loud |
| `say -v Name "text"` | Uses a specific voice |
| `clear` | Clears the screen |
| `ls -la` | Lists ALL files including hidden ones |
| `$(command)` | Runs a command and uses its output |

### Vocabulary

- **Terminal** — the app where you type commands
- **Command** — a word that tells your computer to do something
- **Prompt** — the `%` symbol that means "ready for your command"
- **Flag** — extra instructions to a command, starting with `-`
- **Hidden file** — a file starting with `.` — invisible to plain `ls`

---

*You've opened the portal. Go find that hidden file — the agency is watching.*

*Ready for Mission 2?*
