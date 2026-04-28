# Mission 10 — Solutions

## Challenge 1 — Browse the Cool Aliases File

Open the alias list:

```bash
cat ~/mac-cli-for-kids/playground/mission_10/cool_aliases.txt
```

Pick five you would actually use. Example set:

```bash
alias week="cal"
alias reload="source ~/.zshrc && echo 'Config reloaded!'"
alias recent="ls -lt | head -10"
alias trash="rm -ri"
alias finder="open ."
```

Add them to `~/.zshrc`:

```bash
nano ~/.zshrc
source ~/.zshrc
```

Then test each alias by typing its name.

---

## Challenge 2 — Design Your Perfect Detective Prompt

An example prompt with a hardcoded name, current time, current folder, and colors:

```bash
# In ~/.zshrc:
export PS1="\[\e[35m\]Joanna\[\e[0m\] [\[\e[36m\]\t\[\e[0m\]] \[\e[33m\]\W\[\e[0m\] % "
```

This shows something like:

```text
Joanna [10:30:15] Documents %
```

- `Joanna` — hardcoded first name
- `\t` — current time
- `\W` — current folder name
- `\[\e[35m\]` and similar codes — colors

Test before saving:

```bash
export PS1="\[\e[35m\]Joanna\[\e[0m\] [\[\e[36m\]\t\[\e[0m\]] \[\e[33m\]\W\[\e[0m\] % "
```

If you like it, add it to `~/.zshrc`.

---

## Challenge 3 — Improve the `log` Function

```bash
log() {
    if [ -z "$1" ]; then
        echo "What happened today?"
        read diary_entry
    else
        diary_entry="$*"
    fi

    mkdir -p ~/diary
    echo "=== $(date +'%A, %B %d, %Y') ===" >> ~/diary/journal.txt
    echo "" >> ~/diary/journal.txt
    echo "$diary_entry" >> ~/diary/journal.txt
    echo "" >> ~/diary/journal.txt
    echo "---" >> ~/diary/journal.txt
    echo "Diary entry saved!"
}
```

Now both forms work:

```bash
log "I learned about aliases today."
log
```

---

## Challenge 4 — Add a Welcome Voice

In `~/.zshrc`, inside the welcome message section:

```bash
echo ""
echo "Welcome back, Joanna. Today is $(date +'%A')."
echo ""
say -v Samantha "Welcome back Joanna. Today is $(date +'%A')." &
```

The `&` at the end runs `say` in the background so Terminal is ready immediately. Remove `&` if you want Terminal to wait until the voice finishes.
