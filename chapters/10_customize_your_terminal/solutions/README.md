# Mission 10 — Solutions

## Challenge 1 — Design Your Perfect Prompt

An example prompt with name, time, folder, and emoji:

```bash
# In ~/.zshrc:
export PS1="⭐ Sophia [\[\e[36m\]\t\[\e[0m\]] \[\e[33m\]\W\[\e[0m\] % "
```

This shows: `⭐ Sophia [10:30:15] Documents %`

- `⭐` — emoji
- `Sophia` — hardcoded name
- `\t` in cyan — current time
- `\W` in yellow — current folder name

---

## Challenge 2 — Five Useful Aliases

```bash
alias week="cal"
alias myip="curl -s ifconfig.me && echo"
alias reload="source ~/.zshrc && echo 'Config reloaded!'"
alias scripts="ls ~/*.sh"
alias trash="rm -ri"
```

Add all five to `~/.zshrc`, then run `source ~/.zshrc` to apply them.

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
    
    echo "=== $(date +'%A, %B %d, %Y') ===" >> ~/diary/journal.txt
    echo "" >> ~/diary/journal.txt
    echo "$diary_entry" >> ~/diary/journal.txt
    echo "" >> ~/diary/journal.txt
    echo "---" >> ~/diary/journal.txt
    echo "Diary entry saved!"
}
```

Now:
- `log "I learned about aliases today!"` — saves immediately
- `log` — prompts you to type your entry

---

## Challenge 4 — Add Greeting Voice

In `~/.zshrc`, inside the welcome message section:

```bash
# --- WELCOME MESSAGE ---
echo ""
echo "Welcome back, $(whoami)! Today is $(date +'%A, %B %d')."
echo ""
say -v Samantha "Welcome back! Today is $(date +'%A, %B %d')" &
```

The `&` at the end runs the `say` command in the *background* — so Terminal is ready immediately without waiting for the voice to finish speaking. Remove `&` if you want Terminal to wait.
