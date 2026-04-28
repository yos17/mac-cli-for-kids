# Mission 11 — Secret Agent Tools

## Mission Briefing

_Briefing note_

> "Detective, this mission is classified.
>
> Every file on your computer has a set of rules that controls who can read it, who can change it, and who can run it. Set them correctly and your files are locked down tight. Set them wrong and anyone on the same computer can read your case notes, your diary, everything.
>
> In this mission you will learn those rules — file permissions. You will also learn how to create files that are invisible to casual observation, and how to encrypt messages that are completely unreadable without the correct password.
>
> We have intercepted three encoded messages from an unknown source. They are in your case files. Your job is to decode them.
>
> This is real security. Pay attention."

You have already used `chmod +x` to make scripts executable. That was just the beginning. Permissions control every file on your system, and understanding them is the difference between a secure machine and a vulnerable one.

### What You'll Learn
- File permissions — who can read, write, and execute every file
- `chmod` — change permissions with precision
- Hidden files (starting with `.`) — invisible in normal views
- `base64` — encoding and decoding (not encryption)
- `openssl` — real, strong encryption
- How to decode the three intercepted messages

---

## Your Case Files

Report to the secure evidence vault:

```bash
cd ~/mac-cli-for-kids/playground/mission_11
ls -la
```

You should see:

```
classified/         ← folder with 3 intercepted encoded messages + instructions
permissions_puzzle/ ← folder with files at various permission levels
.secret_code.txt    ← hidden! (find it at the end of the mission)
```

Look inside the classified folder:

```bash
ls -la classified/
cat classified/README.txt
```

That `README.txt` will tell you how the messages were encoded and what you need to decode them. Then look at the permissions puzzle:

```bash
ls -la permissions_puzzle/
```

You will see files with different permission settings. One of them — `locked_file.txt` — has permission `000`, which means nobody can read it. Not even you. You will fix that.

Let's learn the tools.

---

## File Permissions

When you run `ls -l`, you see something like this:

```
-rw-r--r--   1 sophia  staff  1024 Apr 13 10:00 diary.txt
drwxr-xr-x   4 sophia  staff   128 Apr 12 15:30 case_files/
```

That first column (`-rw-r--r--`) is the **permission string**. Let's decode it:

```
- rw- r-- r--
│ │   │   └── other (everyone else): what they can do
│ │   └── group (other users in your group): what they can do
│ └── owner (you): what you can do
└── type: - = file, d = directory
```

Each set of 3 characters represents three permissions: **r** (read), **w** (write), **x** (execute). A `-` means that permission is off.

So `-rw-r--r--` means:
- **File** (not a directory)
- **Owner** (you): can read and write, cannot execute
- **Group**: can only read
- **Others**: can only read

And `drwxr-xr-x` means:
- **Directory**
- **Owner**: can read, write, and enter (for directories, `x` means "enter")
- **Group**: can read and enter, but not write
- **Others**: same as group

---

## `chmod` — Change Mode

`chmod` modifies a file's permissions. You have already used `chmod +x` to add execute permission. Now let's learn the full system.

### Using Numbers (Octal Mode)

Each permission has a numeric value:
- **r** (read) = 4
- **w** (write) = 2
- **x** (execute) = 1
- **none** = 0

Add them together for each group (owner, group, others):
- `7` = 4+2+1 = `rwx` — full permissions
- `6` = 4+2+0 = `rw-` — read and write
- `5` = 4+0+1 = `r-x` — read and execute
- `4` = 4+0+0 = `r--` — read only
- `0` = 0+0+0 = `---` — no permissions at all

Three digits: owner, group, others.

Examples:

```bash
chmod 755 script.sh      # owner: all;     group + others: read + execute
chmod 644 document.txt   # owner: rw;      group + others: read only
chmod 600 secret.txt     # owner: rw;      group + others: nothing
chmod 700 private_dir/   # owner: all;     group + others: nothing
chmod 000 locked.txt     # everyone: nothing (not even you!)
chmod +x script.sh       # add execute for everyone
chmod -x script.sh       # remove execute for everyone
chmod o-r secret.txt     # remove read from "others" only
```

### Lock Down Your Diary

```bash
chmod 600 ~/diary/journal.txt
ls -l ~/diary/journal.txt
```

Output:
```
-rw-------  1 sophia  staff  2048 Apr 13 10:22 journal.txt
```

Now only you can read or write it. Nobody else on the same Mac can even look at it.

---

## Hidden Files

Files and folders starting with `.` are **hidden** — they do not appear in normal `ls` or Finder. That is why your config files like `.zshrc` are hidden by default.

Create a hidden file:

```bash
touch ~/.my_secret_note
ls ~              # it does not appear
ls -a ~           # -a shows all files including hidden ones
```

Create a hidden folder:

```bash
mkdir ~/.secret_vault
echo "classified information" > ~/.secret_vault/notes.txt
ls ~                          # vault is invisible
ls ~/.secret_vault/           # but you can access it if you know it is there
```

Important: hidden files are **not** encrypted. Anyone who runs `ls -a` can find them. They are good for keeping things out of sight in everyday use, but not for actually protecting sensitive data. For real protection, you need encryption.

---

## `base64` — Encoding (Not Encryption!)

`base64` is often confused with encryption. It is NOT encryption. It is **encoding** — it converts data into a different representation. Anyone can decode it instantly — no password needed.

```bash
echo "The suspect was seen at the dock." | base64
```

Output: `VGhlIHN1c3BlY3Qgd2FzIHNlZW4gYXQgdGhlIGRvY2suCg==`

Decode it:
```bash
echo "VGhlIHN1c3BlY3Qgd2FzIHNlZW4gYXQgdGhlIGRvY2suCg==" | base64 -d
```

Output: `The suspect was seen at the dock.`

The messages in `classified/` use base64 encoding. That means you have the tool right here to decode them. Go ahead and look at one:

```bash
cat ~/mac-cli-for-kids/playground/mission_11/classified/message_alpha.enc
```

See the scrambled-looking text ending in `==`? That is base64. Pipe it through `base64 -d` to decode it:

```bash
cat ~/mac-cli-for-kids/playground/mission_11/classified/message_alpha.enc | base64 -d
```

What does the decoded message say? Write it down. Now do the same for `message_beta.enc` and `message_gamma.enc`.

---

## `openssl` — Real Encryption

`openssl` performs actual encryption. When you encrypt a file, it becomes completely unreadable without the correct password — even with a powerful computer trying every possible key.

### Encrypt a File

```bash
echo "The rendezvous is at midnight." > secret.txt
openssl enc -aes-256-cbc -pbkdf2 -in secret.txt -out secret.enc
```

It will ask you to create a password. Enter one and remember it!

Look at the encrypted file:

```bash
cat secret.enc
```

It is complete nonsense — unreadable. That is the point. No one can extract the original message without the password.

### Decrypt a File

```bash
openssl enc -aes-256-cbc -pbkdf2 -d -in secret.enc -out decoded.txt
cat decoded.txt
```

Enter the same password and your message comes back perfectly.

### What Is AES-256?

AES-256 is one of the strongest encryption algorithms ever created. Governments, banks, and militaries use it. With a strong password, your file is effectively impossible to crack.

A strong password is:
- At least 12 characters
- Mix of uppercase, lowercase, numbers, and symbols
- Not a dictionary word or phrase

---

## Try It! — Quick Experiments

**Experiment 1:** Test the permissions puzzle in your case files.

```bash
cd ~/mac-cli-for-kids/playground/mission_11/permissions_puzzle

# Check current permissions on all files
ls -l

# Try to read the locked file
cat locked_file.txt    # this should fail with "Permission denied"

# Fix the permissions
chmod 644 locked_file.txt

# Now it should work
cat locked_file.txt

# Read the others too
cat readable.txt
cat owner_only.txt
```

**Experiment 2:** Create and explore a hidden folder.

```bash
mkdir ~/.detective_notes
echo "Note 1: Suspect left footprints heading north." > ~/.detective_notes/clue1.txt
ls ~                          # the folder is invisible
ls -a ~                       # now you see it
cat ~/.detective_notes/clue1.txt    # still accessible when you know the path
rm -r ~/.detective_notes      # clean up
```

**Experiment 3:** Encrypt and decrypt a message.

```bash
echo "The treasure is hidden in the clock tower." > clue.txt
openssl enc -aes-256-cbc -pbkdf2 -in clue.txt -out clue.enc
rm clue.txt                   # destroy the original
cat clue.enc                  # unreadable!
openssl enc -aes-256-cbc -pbkdf2 -d -in clue.enc -out clue_decoded.txt
cat clue_decoded.txt          # readable again
rm clue.enc clue_decoded.txt  # clean up
```

**Experiment 4:** Make a script temporarily unrunnable, then runnable again.

```bash
echo '#!/bin/bash' > test_agent.sh
echo 'echo "Agent active."' >> test_agent.sh
chmod +x test_agent.sh
bash test_agent.sh          # works
chmod -x test_agent.sh
./test_agent.sh             # permission denied! (but bash still works)
chmod +x test_agent.sh
./test_agent.sh             # works again
rm test_agent.sh
```

---

## Pro Tip — The Secret Message System

Here is a full workflow for sending encrypted messages that only the intended recipient can read. Create the send-and-receive script:

```bash
nano ~/secret_send.sh
```

```bash
#!/bin/bash
# secret_send.sh — Encrypt and decrypt secret messages
# Usage: bash secret_send.sh send | bash secret_send.sh read

VAULT_DIR="$HOME/.secret_vault"
INBOX="$VAULT_DIR/inbox"

# Create vault if it does not exist
mkdir -p "$INBOX"
chmod 700 "$VAULT_DIR"

MODE="${1:-help}"

case "$MODE" in
    send)
        echo ""
        echo "=== SEND A CLASSIFIED MESSAGE ==="
        echo "Your message (press Enter when done):"
        read message

        echo "Create a password to lock this message:"
        read -s password    # -s = silent (typing is hidden)

        TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
        FILENAME="$INBOX/msg_${TIMESTAMP}.enc"

        echo "$message" | openssl enc -aes-256-cbc -pbkdf2 -pass "pass:$password" -out "$FILENAME"

        echo ""
        echo "Message encrypted and saved!"
        echo "File: msg_${TIMESTAMP}.enc"
        echo "Do NOT forget your password — there is no recovery!"
        ;;

    read)
        echo ""
        echo "=== CLASSIFIED INBOX ==="

        msgs=("$INBOX"/*.enc)

        if [ ! -f "${msgs[0]}" ]; then
            echo "No messages in your inbox."
            exit 0
        fi

        echo "Messages:"
        i=1
        for msg in "${msgs[@]}"; do
            echo "  $i. $(basename "$msg")"
            i=$((i + 1))
        done

        echo ""
        echo "Which message number?"
        read choice

        selected="${msgs[$((choice - 1))]}"

        echo "Enter the password:"
        read -s password

        echo ""
        echo "=== MESSAGE ==="
        openssl enc -aes-256-cbc -pbkdf2 -d -pass "pass:$password" -in "$selected" 2>/dev/null

        if [ $? -ne 0 ]; then
            echo "Wrong password or corrupted message."
        fi
        echo "==============="
        ;;

    delete)
        echo "Delete which file? (list below)"
        ls "$INBOX/"
        read filename
        rm -i "$INBOX/$filename"
        ;;

    *)
        echo "Usage:"
        echo "  bash ~/secret_send.sh send    — encrypt and save a message"
        echo "  bash ~/secret_send.sh read    — read your encrypted messages"
        echo "  bash ~/secret_send.sh delete  — delete a message"
        ;;
esac
```

Save and make executable:

```bash
chmod +x ~/secret_send.sh
```

Test it:

```bash
bash ~/secret_send.sh send
bash ~/secret_send.sh read
```

Your messages are stored encrypted in `~/.secret_vault/inbox/`. Anyone who looks at those files sees only scrambled data. Only the correct password unlocks them.

---

## Challenges

### Case #1101 — Decode All Three Messages

Decode all three intercepted messages from `~/mac-cli-for-kids/playground/mission_11/classified/`:

```bash
cat ~/mac-cli-for-kids/playground/mission_11/classified/message_alpha.enc | base64 -d
cat ~/mac-cli-for-kids/playground/mission_11/classified/message_beta.enc | base64 -d
cat ~/mac-cli-for-kids/playground/mission_11/classified/message_gamma.enc | base64 -d
```

What do the three messages say? Do they form a larger message when read together? Check the `classified/README.txt` file for hints.

### Case #1102 — Fix the Permissions Puzzle

In `~/mac-cli-for-kids/playground/mission_11/permissions_puzzle/` there are three files with different permission levels:
- `locked_file.txt` — permission `000` (nobody can read it)
- `readable.txt` — probably `644` (you can read it)
- `owner_only.txt` — probably `600` (only owner can read/write)

Check the permissions with `ls -l`. Then:
1. Fix `locked_file.txt` so you can read it
2. Try to make `readable.txt` unreadable (`chmod 000`), confirm it fails with `cat`, then restore it
3. Verify the permissions on `owner_only.txt` — what does `600` mean exactly?

Restore everything to sensible permissions when you are done.

### Case #1103 — Lock Down Your Diary

If you have a diary file from earlier missions, apply proper security to it:

```bash
chmod 600 ~/diary/journal.txt
ls -l ~/diary/journal.txt
```

Confirm the permissions show `-rw-------`. Then create an encrypted backup:

```bash
openssl enc -aes-256-cbc -pbkdf2 -in ~/diary/journal.txt -out ~/diary/journal.enc
```

Verify you can decrypt the backup. Then delete the encrypted version to keep things clean.

### Case #1104 — Hidden Folder Security

Create a hidden private folder and demonstrate good security practice:

1. Create `~/.private_case_files/`
2. Add a text file with some "sensitive" content inside it
3. Set the folder permissions to `700` (only you can enter it)
4. Verify the folder is invisible in `ls ~` but visible in `ls -a ~`
5. Verify you can still access the file inside using the full path
6. Clean up with `rm -r ~/.private_case_files/`

---

## Secret Code Hunt

You know how to list hidden files with `ls -a` and how to read file contents. The `mission_11` playground has its own hidden file — a little harder to spot since there is already a lot of interesting content in this folder.

```bash
cd ~/mac-cli-for-kids/playground/mission_11
ls -a
```

Find the `.secret_code.txt` file and read it. That is your eleventh secret code word. Add it to your collection.

---

## Solutions

Solutions are in the [solutions folder](solutions/README.md).

---

## Powers Unlocked

| Command | What It Does |
|---------|-------------|
| `ls -l file` | Show file permissions |
| `ls -la` | Show all files (including hidden) with permissions |
| `chmod 600 file` | Set permissions with octal code |
| `chmod +x file` | Add execute permission (all) |
| `chmod -x file` | Remove execute permission (all) |
| `chmod o-r file` | Remove read permission for "others" only |
| `echo text \| base64` | Encode text to base64 |
| `echo encoded \| base64 -d` | Decode from base64 |
| `openssl enc -aes-256-cbc -pbkdf2 -in f -out f.enc` | Encrypt a file |
| `openssl enc -aes-256-cbc -pbkdf2 -d -in f.enc -out f` | Decrypt a file |

### Permission Number Quick Reference

| Number | Permissions | Meaning |
|--------|-------------|---------|
| `7` | `rwx` | Read, write, execute |
| `6` | `rw-` | Read and write |
| `5` | `r-x` | Read and execute |
| `4` | `r--` | Read only |
| `0` | `---` | No permissions at all |

Common combinations:
- `755` — scripts and programs (everyone can run, only you can edit)
- `644` — normal documents (everyone can read, only you can write)
- `600` — private files (only you can do anything)
- `700` — private directories (only you can enter)

### Vocabulary

- **Permissions** — rules controlling who can read, write, or execute a file
- **chmod** — "change mode" — the command that modifies permissions
- **Octal** — base-8 numbers (`0–7`) used to represent permission combinations
- **Encryption** — transforming data so it is unreadable without the correct key
- **AES-256** — Advanced Encryption Standard with 256-bit keys — military-grade security
- **Base64** — encoding (not encryption) that converts binary data to printable text
- **Hidden file** — any file whose name starts with `.` — invisible to normal `ls`

---

*Files can be locked. Files can be hidden. Messages can be encrypted so only the intended reader can decode them. You now have the tools of a real secret agent.*

*One mission left. The big one.*

*Ready for Mission 12?*
