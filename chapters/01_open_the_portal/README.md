# Mission 1 — Open the Portal

## Mission Briefing

You know how in movies, hackers type really fast into a black screen and suddenly take over entire computer systems? That black screen is called a **terminal** (or command line, or shell — people use these words interchangeably).

Here's the truth: it's not magic. It's just a different way to talk to your computer. Instead of clicking on pictures (icons), you *type words*. And once you learn the words, you can do things that are completely impossible with clicking alone.

Your Mac has been hiding this from you. Today you find it.

### What You'll Learn
- How to open Terminal
- What the prompt means
- Your first 5 commands: `whoami`, `date`, `echo`, `say`, `clear`
- How to make your Mac talk out loud

---

## Opening the Portal

**Step 1:** Press `Cmd + Space` on your keyboard (hold the Command key, then press Space). This opens Spotlight Search.

**Step 2:** Type `Terminal` and press Enter.

You'll see something like this:

```
Last login: Sun Apr 13 10:22:05 on ttys000
yourname@MacBook-Pro ~ %
```

That last line is called the **prompt**. It's the terminal waiting for you to type something. It's saying: *"I'm ready. What do you want to do?"*

Let's look at what it means:

```
yourname @ MacBook-Pro  ~  %
   |           |         |  |
  You      Your Mac    Where  Ready!
                       you are
```

The `~` means you're in your Home folder — the folder with your name in Finder.

---

## Your First Commands

### `whoami` — Who Are You?

Type this and press Enter:

```bash
whoami
```

Your Mac will print your username:

```
sophia
```

Not very exciting — but you just gave your computer a command and it obeyed. That's how all of this works. You type, it responds.

---

### `date` — What Time Is It?

```bash
date
```

Output:
```
Sun Apr 13 10:24:17 PDT 2026
```

Your computer knows exactly what time it is, down to the second. You can ask it anytime.

---

### `echo` — The Parrot Command

`echo` repeats whatever you say after it:

```bash
echo Hello there!
```

Output:
```
Hello there!
```

Try it with your own name:

```bash
echo My name is Sophia and I am learning Terminal!
```

`echo` is more useful than it looks. Later you'll use it to write things into files, print messages from scripts, and much more.

---

### `say` — Make Your Mac Talk

This is the fun one. Your Mac has a built-in voice, and you can control it from Terminal.

```bash
say "Hello, I am your computer"
```

Your Mac will speak those words out loud. 🔊

Try some more:

```bash
say "Mission one is underway"
say "I am a very smart computer"
say -v Victoria "Hello, my name is Victoria"
say -v Fred "Hello, my name is Fred"
```

The `-v` flag lets you pick a voice. `-v` stands for "voice". A **flag** (also called an option) is a way to give a command extra instructions. Flags always start with a `-`.

See all the available voices:

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

### `clear` — Clean the Screen

After trying a bunch of commands, your terminal gets messy. Clean it up:

```bash
clear
```

Or use the keyboard shortcut: `Ctrl + L`

The screen goes blank. All your old commands are still in history (press the Up arrow to go back through them), but now you have a clean workspace.

---

## Try It! — Quick Experiments

**Experiment 1:** What happens if you type `echo` with nothing after it?
```bash
echo
```
(It prints an empty line. `echo` always prints *something* — even if that something is nothing.)

**Experiment 2:** What does your computer say when you ask it to say something in a silly voice?
```bash
say -v Cellos "I am a robot"
say -v Trinoids "Greetings human"
say -v Zarvox "Take me to your leader"
```

**Experiment 3:** Make `echo` and `say` work together:
```bash
echo "I can print AND speak"
say "I can print AND speak"
```

**Experiment 4:** Ask for the date in a different format:
```bash
date +"%A, %B %d, %Y"
```
Output: `Sunday, April 13, 2026`

The `+"%..."` part is a *format string* — you're telling `date` exactly how you want the output to look. `%A` = full day name, `%B` = full month name, `%d` = day number, `%Y` = 4-digit year.

---

## Pro Tip — The Up Arrow is Your Best Friend

You don't have to retype commands. Press the **Up arrow** key to go back through your command history. Press it again to go further back. Press **Down** to come forward. Press **Enter** to run that command again.

Try it: press Up a few times and you'll see your earlier commands come back.

---

## Your Mission — A Talking Mac Greeter

Now you're going to write your first real program. It will greet you every morning with your name, the date, and a spoken welcome message.

Type each line and press Enter after each one:

```bash
echo "==========================="
echo "   Good morning, Sophia!   "
echo "==========================="
echo ""
echo "Today is:"
date +"%A, %B %d, %Y"
echo ""
echo "Your computer is ready."
say "Good morning Sophia. Today is $(date +"%A, %B %d"). Have a great day!"
```

When you run the last line, your Mac will announce the actual day out loud. The `$(...)` part is called **command substitution** — it runs a command and puts the result right into your text. So `$(date +"%A, %B %d")` gets replaced with something like `Sunday, April 13`.

### Save It as a Script (Preview!)

You don't have to type all of this every time. In Mission 7, you'll learn how to save this as a file you can run with a single command. For now, just know that everything you're typing can be saved and replayed.

---

## Challenges

### Challenge 1 — Your Own Voice Message

Make your Mac say three things about you:
1. Your name
2. How old you are
3. Your favorite thing to do

Use `say` for each one. Pick a different voice for each!

**Hint:** `say -v [VoiceName] "your text here"`

### Challenge 2 — The Custom Date

Make `date` print *only* the current year. Then make it print only the current month name.

**Hint:** Look at the format codes from the Try It section. Each `%letter` stands for something different.

### Challenge 3 — Echo Art

Use `echo` to print a picture made of characters. Here's a small example — make your own:

```
echo "  /\_/\  "
echo " ( o.o ) "
echo "  > ^ <  "
echo " (_____)  "
```

Try making a rocket, a house, or anything you like.

### Challenge 4 — Explore Voices

Find a voice that you love. Try at least 5 different voices. Write down (or remember) the name of your favorite — you'll use it in later missions.

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
| `$(command)` | Runs a command and uses its output |

### Vocabulary

- **Terminal** — the app where you type commands
- **Command** — a word that tells your computer to do something
- **Prompt** — the `%` (or `$`) symbol that means "ready for your command"
- **Flag** — extra instructions to a command, starting with `-`
- **Command substitution** — `$(...)` runs a command inside another command

---

*You've opened the portal. The terminal is no longer a mystery — it's a tool. Your tool.*

*Ready for Mission 2?*
