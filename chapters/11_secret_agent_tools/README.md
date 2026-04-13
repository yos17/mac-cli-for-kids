# Mission 11 — Top Secret

## Mission Briefing

*"Three encrypted messages intercepted," Director Chen says. "Also: a locked file in the permissions puzzle folder. Before you can read any of it, you need to understand how file permissions work — and how to decode messages that aren't meant for casual eyes."*

Every file on your Mac has a set of rules controlling who can read it, who can change it, and who can run it. These are called **permissions**. If you set them right, files can be locked down so only you can see them.

**The classified files are in `playground/mission_11/`. Can you decode them?**

### What You'll Learn
- Permissions — who can do what with a file
- `chmod` — change permissions
- Hidden files (already know this — now go deeper)
- `base64` — encoding (not encryption!)
- `openssl` — real encryption and decryption

---

## File Permissions

When you run `ls -l`, you see something like:

```
-rw-r--r--   1 sophia  staff  1024 Apr 13 diary.txt
drwxr-xr-x   4 sophia  staff   128 Apr 12 cases/
```

That first column is the **permission string**:

```
- rw- r-- r--
│ │   │   └── other (everyone else)
│ │   └── group
│ └── owner (you)
└── type: - = file, d = directory
```

Each set of 3 characters: **r** (read) **w** (write) **x** (execute). A `-` means that permission is off.

---

## `chmod` — Change Mode

### Using Numbers (Octal Mode)

Each permission has a value:
- **r** (read) = 4
- **w** (write) = 2
- **x** (execute) = 1
- **none** = 0

Add them together for each group:
- `7` = 4+2+1 = rwx (full)
- `6` = 4+2 = rw-
- `4` = 4 = r--
- `0` = --- (no permissions!)

Three digits: owner, group, others.

```bash
chmod 755 script.sh      # owner: all; others: read+execute
chmod 644 document.txt   # owner: read+write; others: read only
chmod 600 secret.txt     # owner: read+write; NOBODY else can anything
chmod 000 locked.txt     # TOTAL lockdown — nobody can read it!
chmod +x script.sh       # add execute for everyone
```

---

## `base64` — Encoding (NOT Encryption!)

`base64` just converts data to text and back. Anyone can decode it — there's no password!

```bash
echo "Hello, Agent!" | base64
```

Output: `SGVsbG8sIEFnZW50IQo=`

Decode it:
```bash
echo "SGVsbG8sIEFnZW50IQo=" | base64 -d
```

Output: `Hello, Agent!`

---

## `openssl` — Real Encryption

`openssl` is used by governments and banks. When you encrypt with it, the file is genuinely unreadable without the correct password.

### Encrypt a File

```bash
echo "Top secret message." > message.txt
openssl enc -aes-256-cbc -pbkdf2 -in message.txt -out message.enc
```

It asks for a password. The output is unreadable gibberish.

### Decrypt a File

```bash
openssl enc -aes-256-cbc -pbkdf2 -d -in message.enc -out decoded.txt
cat decoded.txt
```

Enter the same password and your message comes back.

---

## Try It! — Quick Experiments

**Experiment 1:** Decode the classified messages:
```bash
cat playground/mission_11/classified/message_alpha.enc | base64 -d
cat playground/mission_11/classified/message_beta.enc | base64 -d
cat playground/mission_11/classified/message_gamma.enc | base64 -d
```

What do the three messages say?

**Experiment 2:** Set up the permissions puzzle:
```bash
# LOCK the file (to simulate what the agency did)
chmod 000 playground/mission_11/permissions_puzzle/locked_file.txt

# Try to read it:
cat playground/mission_11/permissions_puzzle/locked_file.txt
```

You should get: `Permission denied`

**Experiment 3:** Unlock it with chmod:
```bash
chmod 644 playground/mission_11/permissions_puzzle/locked_file.txt
cat playground/mission_11/permissions_puzzle/locked_file.txt
```

**Experiment 4:** Check permissions in action:
```bash
ls -l playground/mission_11/permissions_puzzle/locked_file.txt
```

---

## Pro Tip — base64 vs Encryption

| | base64 | openssl |
|---|---|---|
| Password needed? | No | Yes |
| Actually secret? | No | Yes |
| Decode with: | `base64 -d` | `openssl enc -d` |
| Use for: | Storing binary as text | Real secrets |

The classified `.enc` files in this mission use base64 — they're encoded, not truly encrypted. In a real agency, we'd use openssl!

---

## Your Mission — Decode the Classified Messages

**Step 1:** Navigate to the classified folder:
```bash
cd playground/mission_11/classified
ls
```

**Step 2:** Decode all three messages:
```bash
cat message_alpha.enc | base64 -d
cat message_beta.enc | base64 -d
cat message_gamma.enc | base64 -d
```

What is the three-message story? What meeting is planned?

**Step 3:** Run the permissions puzzle:
```bash
cd ../permissions_puzzle
ls -l locked_file.txt
```

**Step 4:** Lock the file:
```bash
chmod 000 locked_file.txt
cat locked_file.txt    # should fail!
ls -l locked_file.txt  # what does the permission string show?
```

**Step 5:** Unlock it:
```bash
chmod 644 locked_file.txt
cat locked_file.txt    # should work now!
```

**Step 6:** Practice locking your own diary:
```bash
chmod 600 ~/detective_diary.txt
ls -l ~/detective_diary.txt
```

Only you can read and write it. Nobody else can even look at it.

**Step 7:** Find the hidden code:
```bash
cd ~/playground/mission_11
ls -la
cat .secret_code.txt
```

---

## Challenges

### Challenge 1 — Lock Your Diary

Change permissions on `~/detective_diary.txt` so:
- You can read and write
- Nobody else can do anything

Verify with `ls -l ~/detective_diary.txt`.

**Hint:** Which octal number gives read+write but nothing for others? (`6__`)

### Challenge 2 — The Permission Puzzle

Create 4 files and set these permissions:
1. Only you can read (not even write): `chmod 400`
2. Everyone can read, only you can write: `chmod 644`
3. Only you can do anything: `chmod 700` (on a folder)
4. Nobody can do anything: `chmod 000`

After setting each, try to `cat` it. Then restore before deleting.

### Challenge 3 — Encrypt Your Case Notes

Encrypt a message file using openssl:

```bash
echo "The suspect is Marcus Volkov." > ~/case_note.txt
openssl enc -aes-256-cbc -pbkdf2 -in ~/case_note.txt -out ~/case_note.enc
rm ~/case_note.txt
cat ~/case_note.enc    # gibberish!
openssl enc -aes-256-cbc -pbkdf2 -d -in ~/case_note.enc -out ~/case_note_decoded.txt
cat ~/case_note_decoded.txt    # your message back!
```

### Challenge 4 — Create a Hidden Folder

Create `~/.tda_secret/` with permission `700` and store a text file inside it. Verify it doesn't show up in normal `ls ~` but does appear in `ls -a ~`.

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
| `echo text \| base64` | Encode to base64 (not encryption!) |
| `echo encoded \| base64 -d` | Decode from base64 |
| `openssl enc -aes-256-cbc -pbkdf2 -in f -out f.enc` | Encrypt a file |
| `openssl enc -aes-256-cbc -pbkdf2 -d -in f.enc -out f` | Decrypt a file |

### Permission Number Quick Reference

| Number | Permissions | Meaning |
|--------|-------------|---------|
| `7` | `rwx` | Read, write, execute |
| `6` | `rw-` | Read and write |
| `4` | `r--` | Read only |
| `0` | `---` | No permissions |

Common combinations:
- `755` — scripts and programs
- `644` — normal files
- `600` — private files (only you)
- `700` — private directories

### Vocabulary

- **Permissions** — rules for who can read, write, or execute a file
- **chmod** — "change mode" — modifies file permissions
- **Encryption** — transforming data so it's unreadable without a key
- **AES-256** — a strong encryption standard (used by governments)
- **base64** — encoding (not encryption) — converts binary to text

---

*Files can be locked. Files can be decoded. You know the difference between encoding and encryption. That's a real skill.*

*One mission left. The big one.*

*Ready for Mission 12?*
