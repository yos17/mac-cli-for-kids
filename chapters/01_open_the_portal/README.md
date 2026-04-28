# Mission 1 — Open the Portal

## Mission Briefing

_Briefing note_

> "Agent, welcome to Detective Academy. Today you open the Terminal for the first time and learn five commands you can actually use right away. Small commands first. Real control later."

The Terminal is the plain text window where you can talk to your Mac by typing commands. It is also called the command line or shell. Those words mean almost the same thing for now.

It is not magic. It is a different kind of remote control. Instead of clicking icons, you type words. Once you learn the words, you can do things that are slow or impossible with clicking alone.

Today is just the doorway.

### What You'll Learn
- How to open Terminal
- What the prompt means
- Your first 5 commands: `whoami`, `date`, `echo`, `say`, `clear`
- How to make your Mac talk out loud

### First Win

By the end of this mission, your Mac will print your words, speak out loud, and tell you exactly who and where you are.

### Finder Bridge

Terminal and Finder are looking at the same Mac. Finder shows folders with icons. Terminal shows folders with text.

In Mission 2, you will use `pwd` to see where Terminal is standing. For now, remember this bridge command:

```bash
open .
```

The dot means "this folder".

> **German keyboard?** The Terminal uses characters that are in different places on German keyboards — especially `|`, `~`, and `\`. Check the **Special Keys on Mac** table in the main README before you start, so you know where to find them when you need them.

---

## Your Case Files

Every detective needs case files to work with. Yours are waiting in the mission playground folder.

```bash
cd ~/mac-cli-for-kids/playground/mission_01
ls
```

You should see:

```
agents.txt    welcome.txt
```

Two files are visible — and one is hidden. (You'll find the hidden one during the Secret Code Hunt below.) These files contain messages from Commander Chen himself. You'll use them throughout this mission's challenges.

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

A detective always knows their own identity. You just confirmed yours. That's how all of this works — you type, your computer responds.

---

### `date` — What Time Is It?

```bash
date
```

Output:
```
Sun Apr 13 10:24:17 PDT 2026
```

Every good detective logs the time. Your computer knows exactly what time it is, down to the second. You can ask it anytime.

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
echo My name is Joanna and I am a detective in training!
```

`echo` is more useful than it looks. Later you'll use it to write things into files, print messages from scripts, and much more.

---

### `say` — Make Your Mac Talk

This is the fun one. Your Mac has a built-in voice, and you can control it from Terminal.

```bash
say "Hello, I am your computer"
```

Your Mac will speak those words out loud.

Try some detective-themed lines:

```bash
say "Mission one is underway"
say "The suspect has been identified"
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

Don't worry about the `2>&1 | head -20` part yet — you'll learn exactly what it means in Mission 6. For now just know: `2>&1` makes sure the voice list comes out where we can control it, and `| head -20` means "show me only the first 20 lines." Without those two pieces, the entire list of 60+ voices would flood your screen all at once.

---

### `clear` — Clean the Screen

After trying a bunch of commands, your terminal gets messy. Clean it up:

```bash
clear
```

Or use the keyboard shortcut: `Ctrl + L`

The screen goes blank. All your old commands are still in history (press the Up arrow to go back through them), but now you have a clean workspace. A tidy detective desk is a productive detective desk.

---

## Try It! — Quick Experiments

**Experiment 1:** What happens if you type `echo` with nothing after it?
```bash
echo
```
(It prints an empty line. `echo` always prints *something* — even if that something is nothing.)

**Experiment 2:** What does your computer say when you ask it to speak in a silly voice?
```bash
say -v Cellos "I am a robot detective"
say -v Trinoids "Greetings, suspect"
say -v Zarvox "Take me to your evidence locker"
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

Try it: press Up a few times and you'll see your earlier commands come back. Professional detectives use every shortcut available — so should you.

---

## Pro Tip — Listing Voices Without the Flood

You already used this command:

```bash
say -v '?' 2>&1 | head -20
```

That `2>&1 | head -20` is doing two things at once:

- **`2>&1`** — Mac's voice list is printed on a special channel called *stderr* (the "error" stream). The `2>&1` redirects it onto the normal stream so the next part of the command can see it.
- **`| head -20`** — shows only the first 20 lines instead of all 60+.

You'll learn exactly how both of these work in Mission 6 (Pipes & Superpowers). For now, just use the full command as a recipe — and if you want to see voices starting at a different point in the alphabet, try `| grep "^S"` to filter by first letter:

```bash
say -v '?' 2>&1 | grep "^S"    # voices whose names start with S
say -v '?' 2>&1 | grep "en_US" # English voices only
```

---

## Your Mission — A Talking Mac Greeter

Now you're going to write your first real program. It will greet you every morning with your name, the date, and a spoken welcome message — just like a detective getting a morning briefing.

Type each line and press Enter after each one:

```bash
echo "==========================="
echo "   Good morning, Agent!    "
echo "==========================="
echo ""
echo "Today is:"
date +"%A, %B %d, %Y"
echo ""
echo "Detective Academy is ready."
say "Good morning, Agent. Today is $(date +"%A, %B %d"). Stand by for your briefing."
```

When you run the last line, your Mac will announce the actual day out loud. The `$(...)` part is called **command substitution** — it runs a command and puts the result right into your text. So `$(date +"%A, %B %d")` gets replaced with something like `Sunday, April 13`.

### Save It as a Script (Preview!)

You don't have to type all of this every time. In Mission 7, you'll learn how to save this as a file you can run with a single command. For now, just know that everything you're typing can be saved and replayed.

---

## Secret Code Hunt

Every mission has a secret code word hidden somewhere in the playground folder. Find it and write it down — all 12 words across all 12 missions spell a secret message!

**Mission 1 hint:** The code is in a hidden file called `.secret_code.txt` inside your `mission_01` playground folder. Hidden files start with a `.` — they don't show up with a regular `ls`. Can you figure out which flag to add to `ls` to reveal hidden files?

Navigate there first:
```bash
cd ~/mac-cli-for-kids/playground/mission_01
```

Then try listing hidden files. Once you spot `.secret_code.txt`, use `cat` to read it:
```bash
cat .secret_code.txt
```

Write down the word you find. You'll need all 12 to crack the final code!

---

## Challenges

### Case #0101 — Your Own Voice Message

Make your Mac say three things about yourself:
1. Your name
2. How old you are
3. Your favorite thing to do

Use `say` for each one. Pick a different voice for each!

**Hint:** `say -v [VoiceName] "your text here"`

After each `say` command, also use `echo` so the text appears on screen too.

### Case #0102 — Read the Case Files

Navigate to your playground folder and read the case files that Commander Chen left for you:

```bash
cd ~/mac-cli-for-kids/playground/mission_01
cat welcome.txt
cat agents.txt
```

What does Commander Chen say in each file? Use `echo` to print a one-sentence summary of what you learned from each file.

**Bonus:** Can you make your Mac `say` the contents of the welcome message out loud?

### Case #0103 — Echo Art

Use `echo` to print a picture made of characters. Here's a small example — make your own:

```
echo "  /\_/\  "
echo " ( o.o ) "
echo "  > ^ <  "
echo " (_____)  "
```

Try making a magnifying glass, a detective badge, or anything you like. A real detective always leaves their mark.

### Case #0104 — Custom Date Formats

Make `date` print *only* the current year. Then make it print only the current month name. Then make it print the day of the week.

**Hint:** Look at the format codes from the Try It section. Each `%letter` stands for something different. Try `%Y`, `%B`, and `%A`.

Finally, find a voice you love. Try at least 5 different voices and use your favorite to announce the current date out loud.

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

*Portal open. The Terminal is no longer a mystery — it's your detective command center. Your tool.*

*Ready for Mission 2?*
