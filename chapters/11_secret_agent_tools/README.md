# CASE FILE #11 — "Top Secret"
**Terminal Detective Agency | Clearance Level: CLASSIFIED**

---

## 🔍 MISSION BRIEFING

**INCOMING TRANSMISSION — DIRECTOR CHEN — EYES ONLY**

Agent,

Stop what you're doing. This transmission is encrypted for a reason.

This is our most sensitive mission. The kind that real intelligence agencies deal with every day. There are three separate problems waiting for you in your case folder, and together they'll teach you skills that most computer users never learn.

**Problem 1: Classified Communications**

A suspect has been passing messages using base64 encoding — a format that looks scrambled but is actually quite simple to decode if you know what to look for. We've intercepted five classified files. They're in your case folder right now, each one containing a base64-encoded message. Your job: decode all five and piece together the intelligence.

**Problem 2: Field Intercepts**

Our operatives in the field have sent plain-text reports. These weren't encoded, but they need to be read carefully. Five messages are waiting in your `secret_messages/` folder.

**Problem 3: The Permissions Puzzle**

Your most important job. Three evidence files have been locked down — permissions set to `000`, meaning nobody can read them, not even you. Your job is to understand the permissions system well enough to unlock each file in turn. But there's a twist: the next file's unlock code is hidden inside the previous one. You can't skip ahead. You have to earn each level.

This is real security work. File permissions protect medical records, government documents, banking systems, and private messages every single day. After this mission, you'll understand exactly how that protection works — and how to control it yourself.

**Access your case files:**
```bash
cd playground/mission_11
```

**Read your briefing first:**
```bash
cat playground/mission_11/case_briefing.txt
```

---

## 📚 DETECTIVE TRAINING: Permissions, Encoding, and Encryption

### Understanding File Permissions — The Access Control System

Every single file and folder on your Mac (and on every Unix/Linux/macOS system in the world) has a set of access rules built in. These rules answer three questions about every file:

1. Can it be **read**? Can you open it and see its contents?
2. Can it be **written**? Can you modify it, append to it, or delete it?
3. Can it be **executed**? Can you run it as a program?

And importantly, those three questions are answered separately for three different groups of users:

1. The **owner** — the person who created the file (usually you)
2. The **group** — other users who are in the same user group (on a shared Mac, other accounts)
3. **Others** — everyone else in the world who might access this system

This three-way split is the foundation of Unix security. It's been this way since Unix was invented in 1969, and it's still how file security works on every Mac, Linux server, and web server you'll ever encounter.

### Reading the Permission String

When you run `ls -l`, the first column shows the permission string:

```
-rw-r--r--   1 sophia  staff  1024 Apr 13 10:00 diary.txt
drwxr-xr-x   4 sophia  staff   128 Apr 12 15:30 cases/
```

Let's decode `-rw-r--r--` character by character:

```
Position 1:   -    = this is a file (d = directory, l = symbolic link)
Positions 2-4: rw-  = owner permissions: read=YES, write=YES, execute=NO
Positions 5-7: r--  = group permissions: read=YES, write=NO, execute=NO
Positions 8-10: r--  = other permissions: read=YES, write=NO, execute=NO
```

So `-rw-r--r--` means:
- It's a **file**
- **Owner** (you): can read and write it, cannot execute it
- **Group**: can only read it
- **Others**: can only read it

And `drwxr-xr-x` means:
- It's a **directory**
- **Owner**: can read it, write to it (create/delete files inside), and execute it (enter with `cd`)
- **Group**: can read and enter, but cannot modify the contents
- **Others**: same as group

Wait — what does "execute" mean for a directory? For regular files, execute means "run this as a program." For **directories**, execute means "you can enter this directory with `cd`." You need both read AND execute permission on a directory to list its contents AND enter it. Execute alone lets you enter if you know what's inside. Read alone lets you list files but not access them.

Here's the full layout:

```
d  r  w  x  |  r  w  x  |  r  w  x
│  │  │  │  │  │  │  │  │  │  │  └── others: execute
│  │  │  │  │  │  │  │  │  │  └───── others: write
│  │  │  │  │  │  │  │  │  └──────── others: read
│  │  │  │  │  │  │  │  └─────────── (separator)
│  │  │  │  │  │  │  └────────────── group: execute
│  │  │  │  │  │  └───────────────── group: write
│  │  │  │  │  └────────────────────  group: read
│  │  │  │  └───────────────────────  (separator)
│  │  │  └──────────────────────────  owner: execute
│  │  └─────────────────────────────  owner: write
│  └────────────────────────────────  owner: read
└───────────────────────────────────  file type
```

A `-` in any position means that permission is absent. Present = the letter. Absent = a dash.

### `chmod` — Change Mode

`chmod` is the command to change a file's permissions. It comes in two flavors: **octal** (numbers) and **symbolic** (letters). Both do the same thing — professional developers use both depending on what's clearest for the situation.

#### Octal Mode — Permission by Numbers

Each permission type has a value:
- **r** (read) = **4**
- **w** (write) = **2**
- **x** (execute) = **1**
- **(nothing)** = **0**

To get the digit for one group, add together the values for the permissions that group should have:

| Permissions Wanted | Calculation | Digit |
|-------------------|-------------|-------|
| rwx (all) | 4+2+1 | **7** |
| rw- (read and write) | 4+2+0 | **6** |
| r-x (read and execute) | 4+0+1 | **5** |
| r-- (read only) | 4+0+0 | **4** |
| -wx (write and execute, rare) | 0+2+1 | **3** |
| -w- (write only, rare) | 0+2+0 | **2** |
| --x (execute only) | 0+0+1 | **1** |
| --- (nothing) | 0+0+0 | **0** |

Then combine three digits: **owner**, **group**, **others** — in that order.

```bash
chmod 755 script.sh      # owner: 7=rwx; group: 5=r-x; others: 5=r-x
chmod 644 document.txt   # owner: 6=rw-; group: 4=r--; others: 4=r--
chmod 600 secret.txt     # owner: 6=rw-; group: 0=---; others: 0=---
chmod 700 private_dir/   # owner: 7=rwx; group: 0=---; others: 0=---
chmod 000 locked.txt     # owner: 0=---; group: 0=---; others: 0=--- (NOBODY)
chmod 400 readonly.txt   # owner: 4=r--; group: 0=---; others: 0=---
```

Here's how to memorize the most important ones:

- **755** — "I can do everything; others can run it but not change it." Use for scripts and programs.
- **644** — "I can read/write; others can only read." Use for normal documents.
- **600** — "I can read/write; nobody else can do anything." Use for private files.
- **700** — "I can do everything to this directory; nobody else can even enter." Use for private folders.
- **000** — Complete lockdown. Even you can't read it until you change the permissions back.

#### Symbolic Mode — Permission by Symbol

Symbolic mode lets you add or remove specific permissions without specifying everything all at once. This is great when you want to make one small change.

The format: `[who][operator][permission]`

**Who:**
| Symbol | Means |
|--------|-------|
| `u` | user (owner) |
| `g` | group |
| `o` | others |
| `a` | all (user + group + others) |

**Operator:**
| Symbol | Means |
|--------|-------|
| `+` | add this permission |
| `-` | remove this permission |
| `=` | set exactly these permissions (removes others) |

**Permission:** `r` (read), `w` (write), `x` (execute)

Examples:

```bash
chmod +x script.sh           # add execute for everyone
chmod -x script.sh           # remove execute for everyone
chmod u+x script.sh          # add execute for owner only
chmod go-w shared_file.txt   # remove write from group and others
chmod o-r private.txt        # remove read from others
chmod a+r public.txt         # add read for everyone
chmod u=rw,go=r notes.txt    # owner: rw, group and others: r (same as 644)
chmod u+x,o-r script.sh      # add execute for owner AND remove read from others
```

Symbolic mode shines when you want to make a targeted change. If a file is `644` and you just want to add execute for the owner, `chmod u+x file` is cleaner than `chmod 755 file` (which would also give execute to everyone else).

#### Which Mode Should You Use?

- Use **octal** when setting full permissions from scratch: `chmod 644 file`
- Use **symbolic** when making specific adjustments: `chmod +x file`, `chmod o-r file`

Professional developers switch between both constantly, choosing whichever communicates intent more clearly.

### Protecting Your Private Files

Now that you know permissions, protect your diary:

```bash
chmod 600 ~/diary/journal.txt
ls -l ~/diary/journal.txt
```

Output:
```
-rw-------  1 sophia  staff  2048 Apr 13 10:22 journal.txt
```

The permission string `rw-------` means: the owner (you) can read and write; group and others have zero permissions. Even if someone else had an account on your Mac, they could not read your diary.

For your diary folder itself:
```bash
chmod 700 ~/diary
ls -la ~ | grep diary
```

Output:
```
drwx------   3 sophia  staff   96 Apr 13 10:00 diary
```

`700` on a directory means only you can enter it. Other users can't even list what's inside.

### Hidden Files — The Invisible Layer

Files and folders whose names start with `.` are **hidden** in macOS and all Unix systems. They don't appear in `ls` or Finder by default. That's why configuration files like `.zshrc`, `.ssh`, and `.gitconfig` are all hidden — they're meant to be there but not constantly in your face.

```bash
ls ~              # No hidden files shown
ls -a ~           # -a means "all" — hidden files appear
ls -la ~          # Long format AND hidden files
```

Create your own hidden file and folder:

```bash
touch ~/.my_secret_file       # hidden file
mkdir ~/.secret_vault         # hidden folder
ls ~                          # neither appears
ls -a ~                       # both appear now
```

**Critical reminder:** Hidden files are NOT encrypted or protected by hiding alone. The dot just removes them from default listings. Anyone who runs `ls -a ~` can find them. The dot is "security through obscurity" — a weak form of protection.

For real privacy, combine hiding with permissions AND encryption:
- Hidden location (dot prefix) — reduces visibility
- Restricted permissions (`600` or `700`) — blocks access
- Encryption (openssl) — makes content unreadable even if someone copies the file

### Base64 — Encoding (Definitely Not Encryption!)

`base64` is one of the most misunderstood things in computing. Beginners often think it's a form of encryption. It's not. Understanding the difference is important.

**What base64 is:** A way to represent binary data using only printable ASCII characters. The alphabet is A–Z (26 letters), a–z (26 letters), 0–9 (10 digits), plus `+` and `/` — 64 characters total. Hence "base64."

**Why it exists:** Some old systems and protocols can only handle plain text — they choke on binary data or unusual characters. Email systems, URLs, databases, and configuration files sometimes have this limitation. If you need to store a JPEG image in a text file, or send binary data through a text-only channel, you encode it as base64 first. The receiver decodes it back to the original.

**What it is NOT:** Encryption. Security. Privacy. There is no password. Anyone who sees base64-encoded text can decode it instantly. It's like writing English words in a different script (say, Morse code) — the information is identical, just presented differently.

The way to tell base64 from real encrypted data: base64 always ends with `=` or `==` padding, and it uses a very specific character set. Trained eyes can recognize it immediately.

#### Using Base64

Encode text:
```bash
echo "Hello, Agent!" | base64
# Output: SGVsbG8sIEFnZW50IQo=
```

Decode it:
```bash
echo "SGVsbG8sIEFnZW50IQo=" | base64 -d
# Output: Hello, Agent!
```

Encode a whole file:
```bash
base64 playground/mission_11/classified/message_01.txt
```

Decode a file:
```bash
base64 -d playground/mission_11/classified/message_01.txt
```

Or save the decoded output to a new file:
```bash
base64 -d playground/mission_11/classified/message_01.txt > decoded_message_01.txt
cat decoded_message_01.txt
```

#### The Loop Approach — Decode Everything at Once

When you have multiple encoded files, decode them all with one loop:

```bash
for file in playground/mission_11/classified/*.txt; do
    echo "=== $(basename "$file") ==="
    base64 -d "$file"
    echo ""
done
```

`$(basename "$file")` extracts just the filename from the full path — so instead of printing `playground/mission_11/classified/message_01.txt`, it prints just `message_01.txt`.

This kind of automation is why learning the shell is so powerful: what would take ten manual steps takes one command.

### `openssl` — Real Encryption

`openssl` is a professional-grade cryptography toolkit. Unlike base64, encrypting with openssl produces data that is genuinely unreadable without the correct password — not just formatted differently, but mathematically transformed.

#### Encrypt a File

```bash
echo "The meeting location is the old lighthouse." > message.txt
openssl enc -aes-256-cbc -pbkdf2 -in message.txt -out message.enc
```

`openssl` will ask you to set a password. Choose a strong one. Confirm it. The encrypted file is created.

Look at the encrypted result:
```bash
cat message.enc
```

Complete gibberish. Unrecognizable. Not even remotely readable. The original content has been mathematically scrambled using your password as the key.

Let's break down the command flags:
- `enc` — we're doing encryption (vs. other openssl operations like hashing)
- `-aes-256-cbc` — AES encryption, 256-bit key, CBC mode (explained below)
- `-pbkdf2` — a modern key-derivation method (converts your password into a crypto key securely)
- `-in message.txt` — the input file to encrypt
- `-out message.enc` — where to save the encrypted output

#### Decrypt a File

```bash
openssl enc -aes-256-cbc -pbkdf2 -d -in message.enc -out message_decoded.txt
cat message_decoded.txt
```

Adding `-d` (for decrypt) reverses the process. Enter the same password and the original content comes back perfectly.

#### What is AES-256?

AES stands for Advanced Encryption Standard. The "256" refers to the key length — 256 bits. This matters because the security of encryption increases exponentially with key length. AES-256 would take longer than the age of the universe to brute-force, even with all the computing power on Earth combined.

AES-256 is used by:
- The US National Security Agency for classified communications
- Banks and financial institutions for transaction security
- Signal, WhatsApp, and other secure messaging apps
- Your Mac itself (FileVault uses AES to encrypt your hard drive)

It's not "pretty secure." It's "effectively unbreakable with any technology that currently exists."

The one vulnerability: your password. A weak password completely undermines strong encryption. `password123` is a terrible password even with AES-256 protection. A strong password — random, long, mixed character types — makes your encrypted files virtually invulnerable.

**What makes a strong password:**
- At least 12 characters (16+ is better)
- Mix of uppercase letters, lowercase letters, numbers, and symbols
- No dictionary words (in any language)
- Not personal information (birthdate, name, address)
- Not reused from another account

#### Base64 vs. openssl — The Critical Comparison

| | base64 | openssl AES-256 |
|--|--------|-----------------|
| What it is | Encoding — a format conversion | Encryption — mathematical scrambling |
| Password needed? | No | Yes |
| Can anyone decode it? | Yes, instantly | Only with the correct password |
| Output looks like | Printable ASCII characters | Binary data (often unreadable as text) |
| Security it provides | None | Military-grade |
| Use it for | Format compatibility, data transfer | Actual privacy and security |

If someone shows you base64-encoded data and says "I encrypted this," they're wrong. Encoding is not encryption. You can decode base64 in five seconds with zero knowledge of passwords or keys.

If someone shows you an AES-256 encrypted file without knowing the password, they have nothing. They'll never read it.

### Why Security Has Multiple Layers

Real-world security never relies on just one protection. A bank doesn't just lock the vault — it also has guards, cameras, alarm systems, and reinforced walls. If one layer fails, the others hold. This principle is called **defense in depth**, and it applies directly to how you protect digital files.

For a file you want to keep private, you can apply multiple layers simultaneously:

1. **Hidden location** — a file starting with `.` doesn't appear in casual `ls` or Finder browsing. It won't catch the eye of someone glancing at your screen.

2. **Restricted permissions** — `chmod 600` means only you (the owner) can read or write the file. Even if someone knows the file exists, permission denied stops them cold.

3. **Encryption** — `openssl enc -aes-256-cbc` mathematically scrambles the content using your password. Even if someone copies the file and bypasses permissions (e.g., boots your Mac from an external drive), the content is unreadable without the password.

Each layer independently blocks a different kind of attack. Using all three together gives you security that would take years of specialized effort to break through — and that's against a determined expert attacker with physical access to your hardware.

For everyday purposes, even one layer (proper permissions) is vastly better than no protection at all.

---

## 🧪 FIELD WORK

### Investigation 1 — Read the Case Briefing

```bash
cat playground/mission_11/case_briefing.txt
```

Read every word. Understand what you're dealing with before you start.

### Investigation 2 — Survey the Classified Files

```bash
# See what's in the classified folder
ls playground/mission_11/classified/

# Read the first message — look at what base64 text looks like
cat playground/mission_11/classified/message_01.txt
```

Notice: it looks like random characters. Mostly letters and numbers, possibly ending with `=`. That's the base64 signature. The message is in there — you just need to decode it.

### Investigation 3 — Decode the Classified Messages

Decode them one at a time first, then use the loop:

```bash
# Decode the first message manually:
base64 -d playground/mission_11/classified/message_01.txt

# Decode the second:
base64 -d playground/mission_11/classified/message_02.txt

# Now decode all five at once with a loop:
for file in playground/mission_11/classified/*.txt; do
    echo "=== Decoding: $(basename "$file") ==="
    base64 -d "$file"
    echo ""
done
```

What do the messages say? Are they connected? Is there a pattern? This is the intelligence analysis part of the job.

### Investigation 4 — Read the Field Intercepts

These messages weren't encoded — they're plain text reports from field operatives:

```bash
cat playground/mission_11/secret_messages/from_agent_z.txt
cat playground/mission_11/secret_messages/to_director.txt
cat playground/mission_11/secret_messages/field_report.txt
cat playground/mission_11/secret_messages/warning_note.txt
cat playground/mission_11/secret_messages/final_transmission.txt
```

Read all five. What picture do they paint together?

### Investigation 5 — The Permissions Puzzle

This puzzle teaches permissions by making the consequences real. You'll lock files completely, then unlock them using `chmod`.

```bash
# First, read the instructions
cat playground/mission_11/permissions_puzzle/README.txt

# Check current permissions on the puzzle files
ls -la playground/mission_11/permissions_puzzle/
```

Now follow the instructions: lock all three levels, then unlock them one by one:

```bash
# LOCK all three files completely (nobody can do anything):
chmod 000 playground/mission_11/permissions_puzzle/level1.txt
chmod 000 playground/mission_11/permissions_puzzle/level2.txt
chmod 000 playground/mission_11/permissions_puzzle/level3.txt

# Verify they're locked:
ls -la playground/mission_11/permissions_puzzle/
```

Now try to read a locked file:

```bash
cat playground/mission_11/permissions_puzzle/level1.txt
```

You should see: `Permission denied`

That error message is the permissions system working exactly as designed. The file is there. The content is there. But the rules say nobody can read it — not even you, the owner — until you change the rules.

Unlock level 1 and read it:

```bash
# Give owner read+write, group and others read-only (644 is the classic choice):
chmod 644 playground/mission_11/permissions_puzzle/level1.txt

# Now read it:
cat playground/mission_11/permissions_puzzle/level1.txt
```

The content should give you a hint about what permission to use for level 2. Use that hint:

```bash
# Unlock level 2 using the hint from level 1:
chmod [HINT FROM LEVEL 1] playground/mission_11/permissions_puzzle/level2.txt
cat playground/mission_11/permissions_puzzle/level2.txt
```

Unlock level 3 using the hint from level 2. What does it reveal?

### Investigation 6 — Test Permissions Systematically

Practice the full range of permissions on a test file:

```bash
# Create a test file
echo "This is a test." > perm_test.txt
ls -l perm_test.txt

# Lock it completely
chmod 000 perm_test.txt
cat perm_test.txt           # Permission denied!
ls -l perm_test.txt         # Still shows permissions

# Restore read-only for owner
chmod 400 perm_test.txt
cat perm_test.txt           # Works! Can read.
echo "change" >> perm_test.txt  # Fails! Can't write.

# Give owner read+write
chmod 600 perm_test.txt
echo "change" >> perm_test.txt  # Works now!
cat perm_test.txt

# Clean up
rm perm_test.txt
```

### Investigation 7 — Symbolic Mode Practice

```bash
touch sym_test.txt
ls -l sym_test.txt          # Shows default permissions

chmod +x sym_test.txt       # Add execute for everyone
ls -l sym_test.txt

chmod o-r sym_test.txt      # Remove read from others
ls -l sym_test.txt

chmod u+w,go= sym_test.txt  # Owner: add write; group and others: nothing
ls -l sym_test.txt

rm sym_test.txt
```

### Investigation 8 — Encrypt and Decrypt Your Own Message

```bash
# Write a secret message
echo "The rendezvous is at the old lighthouse at midnight." > secret_msg.txt

# Encrypt it
openssl enc -aes-256-cbc -pbkdf2 -in secret_msg.txt -out secret_msg.enc

# Delete the original
rm secret_msg.txt

# Look at the encrypted file (total gibberish):
cat secret_msg.enc

# Decrypt it back:
openssl enc -aes-256-cbc -pbkdf2 -d -in secret_msg.enc -out secret_msg_recovered.txt

# Read the recovered message:
cat secret_msg_recovered.txt

# Clean up:
rm secret_msg.enc secret_msg_recovered.txt
```

### Investigation 9 — Make a Script Executable

```bash
echo '#!/bin/bash' > agency_check.sh
echo 'echo "Terminal Detective Agency — systems operational."' >> agency_check.sh

# Try to run it — fails because no execute permission:
./agency_check.sh          # permission denied!

# Check what permissions it has:
ls -l agency_check.sh      # probably -rw-r--r--

# Add execute permission (owner only):
chmod u+x agency_check.sh
ls -l agency_check.sh      # now -rwxr--r--

# Run it:
./agency_check.sh          # works!

# Remove execute permission:
chmod -x agency_check.sh
./agency_check.sh          # permission denied again!

# Restore and clean up:
chmod +x agency_check.sh
rm agency_check.sh
```

---

## 🎯 MISSION: Build an Encrypted Message Sender

Build a complete system for sending and receiving encrypted messages. This is exactly the kind of tool real security professionals build.

```bash
nano ~/secret_send.sh
```

Type or study this script carefully. Every line matters:

```bash
#!/bin/bash
# secret_send.sh — Encrypted message system
# Usage:
#   bash ~/secret_send.sh send    — encrypt and save a new message
#   bash ~/secret_send.sh read    — read your encrypted messages
#   bash ~/secret_send.sh delete  — delete a message

# Configuration
VAULT_DIR="$HOME/.secret_vault"
INBOX="$VAULT_DIR/inbox"

# Create the vault structure if it doesn't exist yet
# chmod 700 makes the vault directory private — only you can enter
mkdir -p "$INBOX"
chmod 700 "$VAULT_DIR"
chmod 700 "$INBOX"

# Get the mode from the first argument, default to "help" if none given
MODE="${1:-help}"

case "$MODE" in

    send)
        echo ""
        echo "╔══════════════════════════════════╗"
        echo "║     SEND AN ENCRYPTED MESSAGE    ║"
        echo "╚══════════════════════════════════╝"
        echo ""
        echo "What's your message?"
        read message

        echo ""
        echo "Create a password to lock this message:"
        read -s password   # -s = silent mode (typing doesn't display)
        echo ""
        echo "Confirm password:"
        read -s password_confirm
        echo ""

        if [ "$password" != "$password_confirm" ]; then
            echo "Passwords don't match! Message not saved."
            exit 1
        fi

        # Create a timestamp-based filename so messages don't overwrite each other
        TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
        FILENAME="$INBOX/msg_${TIMESTAMP}.enc"

        # Encrypt using openssl, passing password via command (not interactive)
        echo "$message" | openssl enc -aes-256-cbc -pbkdf2 -pass "pass:$password" -out "$FILENAME"

        # Set strict permissions on the encrypted file
        chmod 600 "$FILENAME"

        echo "Message encrypted and saved!"
        echo "File: msg_${TIMESTAMP}.enc"
        echo "Remember your password — without it, the message is gone forever."
        ;;

    read)
        echo ""
        echo "╔══════════════════════════════════╗"
        echo "║          SECRET INBOX            ║"
        echo "╚══════════════════════════════════╝"
        echo ""

        # Get list of encrypted messages
        msgs=("$INBOX"/*.enc)

        # Check if there are any messages (if first element doesn't exist as a file)
        if [ ! -f "${msgs[0]}" ]; then
            echo "Your inbox is empty. Send a message first!"
            exit 0
        fi

        echo "Messages in your inbox:"
        i=1
        for msg in "${msgs[@]}"; do
            echo "  $i. $(basename "$msg")"
            i=$((i + 1))
        done

        echo ""
        echo "Which message would you like to read? (enter number)"
        read choice

        selected="${msgs[$((choice - 1))]}"

        if [ ! -f "$selected" ]; then
            echo "Invalid choice."
            exit 1
        fi

        echo ""
        echo "Enter the password for this message:"
        read -s password
        echo ""

        echo "══════════════ MESSAGE ══════════════"
        openssl enc -aes-256-cbc -pbkdf2 -d -pass "pass:$password" -in "$selected" 2>/dev/null

        # $? is the exit code of the last command — 0 = success, non-zero = failure
        if [ $? -ne 0 ]; then
            echo ""
            echo "Wrong password — message could not be decrypted."
        fi
        echo "══════════════════════════════════════"
        ;;

    delete)
        echo ""
        echo "Files in inbox:"
        ls "$INBOX/" 2>/dev/null || echo "  (empty)"
        echo ""
        echo "Which file to delete? (type the filename exactly)"
        read filename
        if [ -f "$INBOX/$filename" ]; then
            rm -i "$INBOX/$filename"
        else
            echo "File not found: $filename"
        fi
        ;;

    list)
        echo ""
        echo "Messages in inbox:"
        ls -la "$INBOX/" 2>/dev/null
        echo ""
        ;;

    *)
        echo ""
        echo "Usage:"
        echo "  bash ~/secret_send.sh send    — encrypt and save a message"
        echo "  bash ~/secret_send.sh read    — read your encrypted messages"
        echo "  bash ~/secret_send.sh list    — list all messages"
        echo "  bash ~/secret_send.sh delete  — delete a message"
        echo ""
        ;;
esac
```

Save and make it executable:

```bash
chmod +x ~/secret_send.sh
```

Test the complete workflow:

```bash
# Encrypt a new message:
bash ~/secret_send.sh send

# List all messages:
bash ~/secret_send.sh list

# Read it back:
bash ~/secret_send.sh read
```

Now try to read it with the wrong password — you should get the error message and no content.

Look at what was created:

```bash
ls -la ~/.secret_vault/
ls -la ~/.secret_vault/inbox/
```

Notice:
- The vault directory has `700` permissions — only you can enter it
- The inbox directory has `700` permissions — only you can access it
- Each encrypted message file has `600` permissions — only you can read it

And the file content itself is AES-256 encrypted — unreadable without your password.

That's three independent layers of protection: location (hidden), permissions (locked), and encryption (scrambled). Even if someone broke through one layer, the others remain.

This is called **defense in depth** — a real security principle used by governments, banks, and technology companies worldwide. Never rely on just one protection. Layer them.

---

## 🏆 BONUS MISSIONS

### Bonus Mission 1 — Lock Your Diary

Your diary is private. Give it proper protection:

```bash
# Lock the file to owner-only read+write
chmod 600 ~/diary/journal.txt
ls -l ~/diary/journal.txt   # Should show -rw-------

# Lock the directory to owner-only access
chmod 700 ~/diary
ls -la ~ | grep diary       # Should show drwx------
```

Verify: `cat ~/diary/journal.txt` still works (you're the owner). If you could log in as another user, they couldn't even access the `~/diary` folder, much less read the file.

### Bonus Mission 2 — The Permission Puzzle Challenge

Create four test files and set each one to a specific permission using ONLY octal mode:

1. Owner read-only, nobody else anything → `chmod ___`
2. Owner read+write, everyone else read-only → `chmod ___`
3. Owner everything, nobody else anything → `chmod ___`
4. Complete lockdown — nobody can do anything → `chmod ___`

Work out each octal code before running the command. Then verify with `ls -l` that the permission string matches what you expected. After verifying, restore to `644` and delete.

**Hint for #1:** Owner needs read only (4), group needs nothing (0), others need nothing (0). Answer: `chmod 400`.

### Bonus Mission 3 — Encrypt Your Diary Backup

Create an encrypted backup of your diary file:

```bash
openssl enc -aes-256-cbc -pbkdf2 -in ~/diary/journal.txt -out ~/diary/journal.enc
ls -l ~/diary/journal.enc
```

Verify you can decrypt it:

```bash
openssl enc -aes-256-cbc -pbkdf2 -d -in ~/diary/journal.enc -out ~/diary/test_restore.txt
diff ~/diary/journal.txt ~/diary/test_restore.txt   # Should show no differences
echo "Backup verified successfully!"
rm ~/diary/test_restore.txt ~/diary/journal.enc
```

`diff` compares two files and shows any differences. If the files are identical, it outputs nothing — which is exactly what you want.

### Bonus Mission 4 — Build a Hidden Private Vault

Create a properly secured private directory structure:

```bash
mkdir -p ~/.private_vault/evidence
chmod 700 ~/.private_vault
chmod 700 ~/.private_vault/evidence

echo "Case notes: suspect was spotted at location B." > ~/.private_vault/evidence/notes.txt
chmod 600 ~/.private_vault/evidence/notes.txt

# Verify it's hidden
ls ~                              # .private_vault should not appear
ls -a ~                           # Now it appears (you know it's there)
ls ~/.private_vault/evidence/     # You can access it directly
cat ~/.private_vault/evidence/notes.txt  # Readable by you
```

### Bonus Mission 5 — Pass Encoded Messages to a Friend

This one teaches you something by experiencing it from the other side.

Encode a short message with base64 and share just the encoded string:

```bash
echo "Meet me by the oak tree at noon." | base64
```

Give a friend (or family member) just the encoded output. Tell them the format is base64 and see if they can decode it. This demonstrates perfectly why base64 is NOT security — anyone can decode it in seconds with one command:

```bash
echo "TWVldCBtZSBieSB0aGUgb2FrIHRyZWUgYXQgbm9vbi4K" | base64 -d
```

When they successfully read your "secret" message in under a minute — or find an online decoder immediately — the lesson is complete. Base64 is a format conversion, not a security mechanism.

Now try the reverse: encrypt a message with openssl and hand them the `.enc` file. They CAN'T read it without the password. No online tool can help them. Even a powerful computer can't brute-force it in any reasonable timeframe. That's AES-256 encryption, and that's the real difference between encoding and encrypting.

---

## 🔐 CODE PIECE UNLOCKED!

**Code Piece #11: HACKING**

```bash
cat playground/mission_11/secret_code_piece.txt
```

Eleven pieces collected. One mission remains.

You've decoded encrypted communications, solved a three-level permissions puzzle, and built a real encryption system. Your clearance level just reached its maximum.

---

## ⚡ POWERS UNLOCKED

| Command | What It Does |
|---------|-------------|
| `ls -l file` | Show file with its full permission string |
| `ls -la` | Show all files including hidden, with permissions |
| `chmod 600 file` | Set permissions with octal: owner rw, others nothing |
| `chmod 644 file` | Owner rw, everyone else read-only |
| `chmod 755 file` | Owner rwx, everyone else rx |
| `chmod 700 dir/` | Owner full access, everyone else locked out |
| `chmod 000 file` | Nobody can do anything (complete lockdown) |
| `chmod +x file` | Add execute permission for all groups |
| `chmod -x file` | Remove execute permission from all groups |
| `chmod u+x file` | Add execute for owner only |
| `chmod go-r file` | Remove read from group and others |
| `chmod o-r file` | Remove read permission for "others" only |
| `echo text \| base64` | Encode text to base64 format |
| `echo encoded \| base64 -d` | Decode base64 back to original |
| `base64 -d file.txt` | Decode a base64-encoded file |
| `base64 file` | Encode a file to base64 |
| `openssl enc -aes-256-cbc -pbkdf2 -in f -out f.enc` | Encrypt a file with AES-256 |
| `openssl enc -aes-256-cbc -pbkdf2 -d -in f.enc -out f` | Decrypt an AES-256 encrypted file |
| `read -s variable` | Silent input — user types but nothing displays |

### Permission Number Quick Reference

| Number | Binary | Permissions | Meaning |
|--------|--------|-------------|---------|
| `7` | 111 | `rwx` | Read, write, AND execute |
| `6` | 110 | `rw-` | Read and write |
| `5` | 101 | `r-x` | Read and execute |
| `4` | 100 | `r--` | Read only |
| `3` | 011 | `-wx` | Write and execute (rare) |
| `2` | 010 | `-w-` | Write only (rare) |
| `1` | 001 | `--x` | Execute only (rare) |
| `0` | 000 | `---` | No permissions |

**The Binary Connection:** If you look at the Binary column, you can see each permission bit directly — 1 means the permission is ON, 0 means it's OFF. `rwx` = `111` = 4+2+1 = 7. `rw-` = `110` = 4+2+0 = 6. That's exactly how the numbers work.

### The Most Common Permission Sets

| Octal | String | Use Case |
|-------|--------|----------|
| `755` | `rwxr-xr-x` | Scripts, executable programs, public directories |
| `644` | `rw-r--r--` | Normal documents, public files |
| `600` | `rw-------` | Private files (diary, keys, sensitive data) |
| `700` | `rwx------` | Private directories |
| `400` | `r--------` | Read-only files (once written, never changed) |
| `000` | `---------` | Complete lockdown |

### Detective Vocabulary

- **Permissions** — rules controlling who can read, write, or execute a file
- **chmod** — "change mode" — the command that modifies file permissions
- **Owner / Group / Others** — the three permission groups for every file
- **r / w / x** — read, write, execute — the three permission types
- **Octal mode** — setting permissions with three-digit numbers (e.g., 644, 755)
- **Symbolic mode** — setting permissions with letters and operators (e.g., +x, go-r)
- **Hidden file** — any file whose name starts with `.` — invisible to default `ls`
- **Encoding** — converting data to a different format (base64: reversible, no key needed)
- **Encryption** — mathematically scrambling data so it requires a key to read
- **AES-256** — Advanced Encryption Standard, 256-bit key — military-grade encryption
- **Defense in depth** — layering multiple security measures so no single breach compromises everything
- **`read -s`** — silent input mode — keystrokes don't display on screen
- **`$?`** — the exit code of the last command — 0 means success, anything else means failure

---

*Files can be locked. Files can be hidden. Messages can be encoded so they look like random noise. And real encryption can make data permanently unreadable to anyone without the key.*

*You now have the tools to protect what matters to you.*

*One mission left. The grand finale. You've collected eleven code pieces. Learned over forty commands. Built real tools. The last mission puts it all together into something you'll actually keep.*

*Ready for Case File #12?*
