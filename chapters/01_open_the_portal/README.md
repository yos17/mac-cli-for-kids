# CASE FILE #1 — The Talking Computer
**Terminal Detective Agency | Clearance Level: Cadet**

---

## 🔍 MISSION BRIEFING

Welcome to the Terminal Detective Agency, Agent.

Your application has been accepted. You passed the written exam, survived the obstacle course, and impressed the review board. Now comes the hard part: learning to use our most powerful tool — the **Terminal**.

Every detective at the Agency uses it. It looks like a plain black screen full of text, but don't be fooled. The Terminal is how our agents communicate directly with their computers — no clicking, no icons, no menus. Just you, your keyboard, and a machine that does exactly what you tell it to. Once you master it, you'll be able to do things that are completely impossible with a mouse alone.

Your first mission: make contact with the Terminal. Learn to make it speak, tell the time, and reveal its secrets. The Agency needs to know you can handle it. We're counting on you, Agent.

**Your tools:** `whoami`, `date`, `echo`, `say`, `clear`
**Access your case files:** `cd playground/mission_01`

---

## 📚 DETECTIVE TRAINING: Opening the Terminal

### Finding the Terminal

**Step 1:** Press `Cmd + Space` on your keyboard (hold the Command key, then press Space). This opens Spotlight Search.

**Step 2:** Type `Terminal` and press Enter.

You'll see something like this:

```
Last login: Sun Apr 13 10:22:05 on ttys000
yourname@MacBook-Pro ~ %
```

That last line is called the **prompt**. It's the Terminal waiting for you to type a command. It's saying: *"I'm ready, Agent. What are your orders?"*

Here's what each part means:

```
yourname @ MacBook-Pro  ~  %
   |           |         |  |
  You      Your Mac    Where  Ready!
                       you are
```

The `~` means you're in your Home folder — the folder with your name on it. Think of it as your desk at Agency headquarters.

---

## 📚 DETECTIVE TRAINING: Your First Five Commands

### `whoami` — Confirm Your Identity

Every mission starts with a security check. Type this and press Enter:

```bash
whoami
```

Your Mac will print your username:

```
sophia
```

Simple — but powerful. You just gave your computer a direct order and it obeyed. That is exactly how all of this works. You type, it responds. Every time.

---

### `date` — Check the Mission Clock

```bash
date
```

Output:
```
Sun Apr 13 10:24:17 PDT 2026
```

The Agency's computer knows exactly what time it is, down to the second. You can ask it anytime — useful for timestamping reports and logging when evidence was found.

---

### `echo` — The Communication Device

`echo` repeats whatever message you send after it. Think of it as your Agency radio — you transmit, it broadcasts:

```bash
echo Hello there!
```

Output:
```
Hello there!
```

Try sending your own message:

```bash
echo Agent reporting for duty. All systems operational.
```

`echo` is more useful than it looks. Later you'll use it to write things into case files, print status messages from scripts, and broadcast reports. It's one of the Agency's most-used tools.

---

### `say` — The Voice Transmitter

This one is genuinely impressive. Your Mac has a built-in voice synthesizer, and you can control it directly from Terminal.

```bash
say "Hello, I am your computer"
```

Your Mac will speak those words out loud!

Try a few Agency transmissions:

```bash
say "Mission one is underway"
say "I am a very smart computer"
say -v Victoria "Hello, my name is Victoria"
say -v Fred "Hello, my name is Fred"
```

The `-v` flag lets you pick a voice. `-v` stands for "voice." A **flag** (also called an option) is a way to give a command extra instructions. Flags always start with a `-` dash.

See all available Agency voice profiles:

```bash
say -v '?' 2>&1 | head -20
```

Output (you'll see many more):
```
Agnes               en_US    # Hello, my name is Agnes.
Albert              en_US    # Hello, my name is Albert.
Alex                en_US    # Hello, my name is Alex.
Alice               it_IT    # Salve, mi chiamo Alice.
...
```

---

### `clear` — Wipe the Screen

After a long investigation session, your Terminal gets cluttered. Clean it up like a pro:

```bash
clear
```

Or use the keyboard shortcut: `Ctrl + L`

The screen goes blank. All your previous commands are still saved in history (press the Up arrow to scroll back through them), but now you have a clean workspace for your next operation.

---

## 🧪 FIELD WORK

Your playground folder for this mission is already set up with real Agency files. Let's investigate them.

**Navigate to your case files first:**

```bash
cd playground/mission_01
```

**Experiment 1:** Read the Agency's welcome letter.

```bash
cat welcome.txt
```

The `cat` command reads a file and prints its contents — like opening a document. You'll learn much more about `cat` in later missions, but try it now and read what it says.

**Experiment 2:** Check the agents roster — who else works at the Agency?

```bash
cat agents.txt
```

**Experiment 3:** What happens if you type `echo` with nothing after it?

```bash
echo
```

(It prints an empty line. `echo` always prints *something* — even if that something is nothing. Useful for adding blank space in reports.)

**Experiment 4:** What does your computer say when you ask it to transmit a message in a silly voice?

```bash
say -v Cellos "I am a robot"
say -v Trinoids "Greetings human"
say -v Zarvox "Take me to your leader"
```

**Experiment 5:** Make `echo` and `say` work together as a team:

```bash
echo "Message sent and recorded"
say "Message sent and recorded"
```

**Experiment 6:** Ask for the date in a custom Agency format:

```bash
date +"%A, %B %d, %Y"
```

Output: `Sunday, April 13, 2026`

The `+"%..."` part is a *format string* — you're telling `date` exactly how you want the output to look. `%A` = full day name, `%B` = full month name, `%d` = day number, `%Y` = 4-digit year. You're controlling the output format like a real programmer.

---

## 💡 PRO TIP — The Up Arrow is Your Best Friend

You don't have to retype commands. Press the **Up arrow** key to scroll back through your command history. Press it again to go further back. Press **Down** to come forward. Press **Enter** to run that command again.

Try it now: press Up a few times and watch your earlier commands reappear. Agency operatives never retype what they've already typed.

---

## 🎯 MISSION: Build the Agency Morning Briefing System

Every morning, Agency headquarters broadcasts a status update to all active agents. Your mission is to build that briefing system using the commands you've just learned.

Type each line and press Enter after each one:

```bash
echo "==========================="
echo " TERMINAL DETECTIVE AGENCY "
echo "==========================="
echo ""
echo "Good morning, Agent!"
echo ""
echo "Today's date:"
date +"%A, %B %d, %Y"
echo ""
echo "Mission status: ACTIVE"
echo "All systems: OPERATIONAL"
echo ""
say "Good morning Agent. Today is $(date +"%A, %B %d"). Stay sharp out there."
```

When you run the last line, your Mac will announce the actual day out loud. The `$(...)` part is called **command substitution** — it runs a command inside another command and plugs in the result. So `$(date +"%A, %B %d")` gets replaced with something like `Sunday, April 13`. The Agency uses this constantly to build dynamic messages.

### Save It as a Script (Preview!)

You don't have to type all of this every morning. In Mission 7, you'll learn how to save this entire briefing system as a file you can run with a single command. For now, just know that everything you're typing can be saved, named, and replayed on demand.

---

## 🏆 BONUS MISSIONS

### Bonus Mission 1 — Your Own Undercover Voice Message

Create a three-part voice transmission about yourself:
1. Your codename (make one up!)
2. Your current mission
3. Your favorite thing about being a detective

Use `say` for each one. Pick a different voice for each transmission!

**Hint:** `say -v [VoiceName] "your text here"`

### Bonus Mission 2 — The Custom Timestamp

Make `date` print *only* the current year. Then make it print only the current month name.

**Hint:** Look at the format codes from Field Work Experiment 6. Each `%letter` stands for something different. Try them one at a time.

### Bonus Mission 3 — Agency ASCII Art

Use `echo` to print a piece of art made of text characters. Here's a small example — make your own original design:

```bash
echo "  /\_/\  "
echo " ( o.o ) "
echo "  > ^ <  "
echo " (_____)  "
```

Try making a magnifying glass, a badge, a rocket, or your own detective symbol.

### Bonus Mission 4 — Find Your Favorite Voice

Try at least 5 different voices and find your favorite. Write down the name — you'll use it in later missions to give the Agency its official voice.

**Hint:** Run `say -v '?' 2>&1` to see all voices, then test them with `say -v VoiceName "test message"`.

---

## Solutions

Solutions are in the [solutions folder](solutions/README.md).

---

## 🔐 CODE PIECE UNLOCKED!

You made it through your first case, Agent. The Agency rewards those who complete their missions.

**Code Piece #1: YOU**

The first piece of the Agency's secret code is hidden in your case files. To reveal it:

```bash
cat playground/mission_01/secret_code_piece.txt
```

Write down what you find. You'll need all the pieces together at the end of your training.

---

## ⚡ POWERS UNLOCKED

| Command | What It Does |
|---------|-------------|
| `whoami` | Prints your username — confirms your identity |
| `date` | Prints the current date and time |
| `date +"%format"` | Prints the date in a custom format |
| `echo text` | Prints text to the screen |
| `say "text"` | Makes your Mac speak out loud |
| `say -v Name "text"` | Uses a specific voice |
| `clear` | Clears the screen |
| `$(command)` | Command substitution — runs a command and uses its output |
| `cat file.txt` | Reads and prints the contents of a file |

### Vocabulary

- **Terminal** — the app where you type commands directly to your computer
- **Command** — a word that tells your computer to do something
- **Prompt** — the `%` (or `$`) symbol that means "ready for your command"
- **Flag** — extra instructions added to a command, always starting with `-`
- **Command substitution** — `$(...)` runs a command inside another command and inserts the result

---

*You've opened the portal, Agent. The Terminal is no longer a mystery — it's a weapon in your detective toolkit.*

*Report to Case File #2 when you're ready.*
