# Mission 2 — Solutions

## Challenge 1 — The Deep Dive

```bash
cd ~/mac-cli-for-kids/playground/mission_02
cd office/basement/vault/locked
pwd
cd ~/mac-cli-for-kids/playground/mission_02
pwd
```

The important thing is using the full relative path for the deep dive, then the full absolute path to jump back.

---

## Challenge 2 — The Speed Tour

```bash
cd ~/mac-cli-for-kids/playground/mission_02
ls office/
ls office/hallway/
ls office/hallway/room1/
ls office/basement/vault/locked/
```

You stayed in `mission_02` the whole time and peeked into each folder using its path. No `cd` needed.

---

## Challenge 3 — Count the Clues

```bash
ls ~/mac-cli-for-kids/playground/mission_02 | wc -l
ls ~/mac-cli-for-kids/playground/mission_02/office/basement/vault/locked | wc -l
```

The exact count depends on hidden files and how you run `ls`, but the command pattern is what matters.

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

---

## Challenge 5 — Finder Bridge

```bash
cd ~/mac-cli-for-kids/playground/mission_02/office/basement/vault/locked
pwd
open .
cat treasure_map.txt
```

Finder opens the same folder Terminal is standing in. `treasure_map.txt` is the same file in both places.
