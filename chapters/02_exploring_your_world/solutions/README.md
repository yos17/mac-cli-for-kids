# Mission 2 — Solutions

## Challenge 1 — The Deep Dive

```bash
cd ~/Documents
ls
cd [some-subfolder]   # whatever you found
cd [deeper-subfolder] # keep going if you can
pwd                   # shows where you ended up
cd ~                  # one command back home
pwd                   # confirms you're home: /Users/sophia
```

Everyone's answer will be different depending on what's in their Documents folder. The important thing is using `cd ~` to get home in one step.

---

## Challenge 2 — The Speed Tour

```bash
ls ~/Desktop
ls ~/Documents
ls ~/Downloads
ls ~/Pictures
```

You stayed in `~` the whole time and peeked into each folder using its path. No `cd` needed!

---

## Challenge 3 — Count the Files

Count Downloads:
```bash
ls ~/Downloads | wc -l
```

To compare all folders, check each one:
```bash
ls ~/Desktop | wc -l
ls ~/Documents | wc -l
ls ~/Downloads | wc -l
ls ~/Pictures | wc -l
ls ~/Music | wc -l
```

The folder with the highest number wins! For most people it's Downloads (where everything piles up).

---

## Challenge 4 — The Hidden World

```bash
ls -la ~ | grep "^\."
```

You'll see files like:
```
.zshrc          ← Your shell's settings file (we'll edit this in Mission 10!)
.zprofile       ← Runs when you log in
.DS_Store       ← macOS's hidden folder bookkeeping file
.CFUserTextEncoding  ← Text encoding setting
```

`.zshrc` is the configuration file for your shell (zsh). In Mission 10, you'll open it and customize your terminal — colors, shortcuts, your own commands!
