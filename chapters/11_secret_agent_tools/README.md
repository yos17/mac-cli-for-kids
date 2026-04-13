# Mission 11 — Secret Agent Tools

## Mission Briefing

Every file on your Mac has a set of rules controlling who can read it, who can change it, and who can run it. These are called **permissions**. If you set them right, files can be locked down so only you can see them.

You'll also learn about hidden files, encrypted messages, and a few tricks that make you feel like a real secret agent.

### What You'll Learn
- Permissions — who can do what with a file
- `chmod` — change permissions
- Hidden files (starting with `.`)
- `openssl` — encrypt and decrypt files
- How to build an encrypted message sender

---

## File Permissions

When you run `ls -l`, you see something like this:

```
-rw-r--r--   1 sophia  staff  1024 Apr 13 10:00 diary.txt
drwxr-xr-x   4 sophia  staff   128 Apr 12 15:30 my_project/
```

That first column (`-rw-r--r--`) is the **permission string**. Let's decode it:

```
- rw- r-- r--
│ │   │   └── other (everyone else) permissions
│ │   └── group permissions
│ └── owner (you) permissions
└── type: - = file, d = directory
```

Each set of 3 characters is: **r** (read) **w** (write) **x** (execute). A `-` means that permission is off.

So `-rw-r--r--` means:
- **File** (not directory)
- **Owner** (you): can read and write, cannot execute
- **Group**: can only read
- **Others**: can only read

And `drwxr-xr-x` means:
- **Directory**
- **Owner**: can read, write, and execute (for directories, "execute" means "enter the directory")
- **Group**: can read and enter, but not write
- **Others**: same as group

---

## `chmod` — Change Mode

`chmod` changes a file's permissions.

### Using Numbers (Octal Mode)

Each permission has a value:
- **r** (read) = 4
- **w** (write) = 2
- **x** (execute) = 1
- **none** = 0

Add them together for each group:
- `7` = 4+2+1 = rwx (full permissions)
- `6` = 4+2+0 = rw- (read and write)
- `5` = 4+0+1 = r-x (read and execute)
- `4` = 4+0+0 = r-- (read only)
- `0` = 0+0+0 = --- (no permissions at all)

Three digits: owner, group, others.

Examples:

```bash
chmod 755 script.sh      # owner: all; group and others: read+execute
chmod 644 document.txt   # owner: read+write; group and others: read only
chmod 600 secret.txt     # owner: read+write; nobody else can do anything
chmod 700 private_dir/   # owner: all; nobody else can enter
chmod +x script.sh       # add execute for everyone
chmod -x script.sh       # remove execute for everyone
chmod o-r secret.txt     # remove read from "others"
```

### Lock Down Your Diary!

```bash
chmod 600 ~/diary/journal.txt
ls -l ~/diary/journal.txt
```

Output:
```
-rw-------  1 sophia  staff  2048 Apr 13 10:22 journal.txt
```

Now only you can read or write it. No one else (not even other users on the same Mac) can access it.

---

## Hidden Files

Files and folders starting with `.` are **hidden** — they don't show up in normal `ls` or Finder. That's why your config files like `.zshrc` are hidden.

Create a hidden file:

```bash
touch ~/.my_secret_file
ls ~              # won't show it
ls -a ~           # shows it!
```

Create a hidden folder:

```bash
mkdir ~/.secret_vault
touch ~/.secret_vault/private_notes.txt
ls ~              # vault is invisible
ls ~/.secret_vault/  # but you can still access it if you know it's there
```

Hidden files aren't encrypted — anyone who knows to look with `ls -a` can find them. But they're great for keeping things out of sight in casual use.

---

## `openssl` — Encryption

`openssl` is a powerful tool for real encryption. When you encrypt a file, it becomes unreadable without the correct password.

### Encrypt a File

```bash
echo "This is my secret message." > secret.txt
openssl enc -aes-256-cbc -pbkdf2 -in secret.txt -out secret.enc
```

It will ask you to create a password. Enter one and remember it!

Look at the encrypted file:

```bash
cat secret.enc
```

It's complete gibberish — unreadable. That's the point!

### Decrypt a File

```bash
openssl enc -aes-256-cbc -pbkdf2 -d -in secret.enc -out decrypted.txt
cat decrypted.txt
```

Enter the same password and your message comes back.

### What Is AES-256?

AES-256 is one of the strongest encryption algorithms in the world. Governments and banks use it. If you choose a strong password, your file is essentially impossible to crack.

A strong password is:
- At least 12 characters
- Mix of letters, numbers, and symbols
- Not a dictionary word

---

## Try It! — Quick Experiments

**Experiment 1:** Test permissions.

```bash
touch perm_test.txt
ls -l perm_test.txt
chmod 000 perm_test.txt
cat perm_test.txt         # should fail!
chmod 644 perm_test.txt
cat perm_test.txt         # should work again
rm perm_test.txt
```

**Experiment 2:** Create a hidden config folder.

```bash
mkdir ~/.myconfig
echo "secret config data" > ~/.myconfig/settings.txt
ls ~                        # not visible
ls -a ~                     # visible!
cat ~/.myconfig/settings.txt  # works if you know it's there
```

**Experiment 3:** Encrypt and decrypt a message.

```bash
echo "Dad, the treasure is buried under the old oak tree." > message.txt
openssl enc -aes-256-cbc -pbkdf2 -in message.txt -out message.enc
rm message.txt              # delete the original
cat message.enc             # unreadable!
openssl enc -aes-256-cbc -pbkdf2 -d -in message.enc -out message_decoded.txt
cat message_decoded.txt     # readable again!
rm message.enc message_decoded.txt
```

**Experiment 4:** Make a script unrunnable (then runnable again).

```bash
echo '#!/bin/bash' > testscript.sh
echo 'echo "Hello!"' >> testscript.sh
chmod +x testscript.sh
bash testscript.sh          # works
chmod -x testscript.sh
bash testscript.sh          # still works with bash, but:
./testscript.sh             # permission denied!
chmod +x testscript.sh
./testscript.sh             # works again
```

---

## Pro Tip — `base64` Encoding (Not Encryption!)

`base64` is often confused with encryption. It's NOT. It just converts binary data to text and back. Anyone can decode it — there's no password.

```bash
echo "Hello, Sophia!" | base64
```

Output: `SGVsbG8sIFNvcGhpYSEK`

Decode it:
```bash
echo "SGVsbG8sIFNvcGhpYSEK" | base64 -d
```

Output: `Hello, Sophia!`

Use `base64` when you need to store binary data as text. Use `openssl` when you need actual security.

---

## Your Mission — Encrypted Secret Message Sender

Build a system to send yourself (or a friend) encrypted messages.

```bash
nano ~/secret_send.sh
```

```bash
#!/bin/bash
# secret_send.sh — Encrypt and decrypt secret messages
# Usage: bash secret_send.sh send | bash secret_send.sh read

VAULT_DIR="$HOME/.secret_vault"
INBOX="$VAULT_DIR/inbox"

# Create vault if it doesn't exist
mkdir -p "$INBOX"
chmod 700 "$VAULT_DIR"

MODE="${1:-help}"

case "$MODE" in
    send)
        echo ""
        echo "=== SEND A SECRET MESSAGE ==="
        echo "What's your message?"
        read message
        
        echo "Create a password to lock this message:"
        read -s password   # -s = silent (won't show what you type)
        
        TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
        FILENAME="$INBOX/msg_${TIMESTAMP}.enc"
        
        echo "$message" | openssl enc -aes-256-cbc -pbkdf2 -pass "pass:$password" -out "$FILENAME"
        
        echo ""
        echo "Message encrypted and saved!"
        echo "File: msg_${TIMESTAMP}.enc"
        echo "Don't forget your password!"
        ;;
    
    read)
        echo ""
        echo "=== YOUR SECRET INBOX ==="
        
        # List messages
        msgs=("$INBOX"/*.enc)
        
        if [ ! -f "${msgs[0]}" ]; then
            echo "No messages in your inbox."
            exit 0
        fi
        
        echo "Messages:"
        i=1
        for msg in "${msgs[@]}"; do
            echo "  $i. $(basename $msg)"
            i=$((i + 1))
        done
        
        echo ""
        echo "Which message? (enter number)"
        read choice
        
        selected="${msgs[$((choice - 1))]}"
        
        echo "Enter the password:"
        read -s password
        
        echo ""
        echo "=== MESSAGE ==="
        openssl enc -aes-256-cbc -pbkdf2 -d -pass "pass:$password" -in "$selected" 2>/dev/null
        
        if [ $? -ne 0 ]; then
            echo "Wrong password!"
        fi
        echo "==============="
        ;;
    
    delete)
        echo "Delete which message?"
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
# Send a message:
bash ~/secret_send.sh send

# Read it:
bash ~/secret_send.sh read
```

Your messages are stored encrypted in `~/.secret_vault/inbox/`. Even if someone looks at those files, they can't read them without the password!

---

## Challenges

### Challenge 1 — Lock Your Diary

Change the permissions on `~/diary/journal.txt` so that:
- You (the owner) can read and write
- Nobody else can do anything

Then verify with `ls -l ~/diary/journal.txt`.

**Hint:** Which octal number gives you read+write but nothing for group and others?

### Challenge 2 — The Permission Puzzle

Create 4 files and set these permissions:
1. A file only you can read (not even write)
2. A file everyone can read but only you can write
3. A file only you can do anything with
4. A file nobody can do anything with (not even you!)

After setting each, try to `cat` it to see what happens. Then restore permissions to something sensible before deleting them.

### Challenge 3 — Encrypt Your Diary Backup

Create an encrypted backup of your diary:

```bash
openssl enc -aes-256-cbc -pbkdf2 -in ~/diary/journal.txt -out ~/diary/journal.enc
```

Then verify you can decrypt it. Then delete the encrypted version to keep things clean.

### Challenge 4 — Hidden Folder Security

Create `~/.private_stuff/` and store a text file in it. Set permissions so that `~/.private_stuff/` is `700` (only you can enter it). Verify that the folder doesn't show up in normal `ls ~` but does appear in `ls -a ~`.

---

## Solutions

Solutions are in the [solutions folder](solutions/README.md).

---

## Powers Unlocked

| Command | What It Does |
|---------|-------------|
| `ls -l file` | Show file permissions |
| `chmod 600 file` | Set permissions with octal code |
| `chmod +x file` | Add execute permission |
| `chmod -x file` | Remove execute permission |
| `chmod o-r file` | Remove read permission for "others" |
| `openssl enc -aes-256-cbc -pbkdf2 -in f -out f.enc` | Encrypt a file |
| `openssl enc -aes-256-cbc -pbkdf2 -d -in f.enc -out f` | Decrypt a file |
| `echo text \| base64` | Encode to base64 (not encryption!) |
| `echo encoded \| base64 -d` | Decode from base64 |

### Permission Number Quick Reference

| Number | Permissions | Meaning |
|--------|-------------|---------|
| `7` | `rwx` | Read, write, execute |
| `6` | `rw-` | Read and write |
| `5` | `r-x` | Read and execute |
| `4` | `r--` | Read only |
| `0` | `---` | No permissions |

Common combinations:
- `755` — scripts and programs
- `644` — normal files
- `600` — private files (only you)
- `700` — private directories (only you)

### Vocabulary

- **Permissions** — rules for who can read, write, or execute a file
- **chmod** — "change mode" — modifies file permissions
- **Encryption** — transforming data so it's unreadable without a key
- **AES-256** — a strong encryption standard (military-grade)
- **Password** — the key needed to decrypt an encrypted file
- **Base64** — encoding (not encryption) — just converts binary to text

---

*Files can be locked. Files can be hidden. You can encrypt messages that only the intended reader can decode. Secret agent stuff.*

*One mission left. The big one.*

*Ready for Mission 12?*
