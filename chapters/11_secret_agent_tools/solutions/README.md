# Mission 11 — Solutions

## Challenge 1 — Lock Your Diary

```bash
chmod 600 ~/diary/journal.txt
ls -l ~/diary/journal.txt
```

Output:
```
-rw-------  1 sophia  staff  2048 Apr 13 10:22 journal.txt
```

`600` = owner: rw- (6=4+2), group: --- (0), others: --- (0).

Only you can read or write it. Nobody else can even open it.

---

## Challenge 2 — The Permission Puzzle

```bash
touch file1.txt file2.txt file3.txt file4.txt

# 1. Only you can read (not write):
chmod 400 file1.txt
cat file1.txt   # works
echo "test" > file1.txt  # permission denied!

# 2. Everyone reads, only you write:
chmod 644 file2.txt
cat file2.txt   # works

# 3. Only you can do anything:
chmod 700 file3.txt   # but for a file, 600 is more typical:
chmod 600 file3.txt

# 4. Nobody can do anything:
chmod 000 file4.txt
cat file4.txt   # permission denied!

# Restore to be able to delete:
chmod 644 file1.txt file2.txt file3.txt
chmod 644 file4.txt
rm file1.txt file2.txt file3.txt file4.txt
```

---

## Challenge 3 — Encrypt Your Diary Backup

Encrypt:
```bash
openssl enc -aes-256-cbc -pbkdf2 -in ~/diary/journal.txt -out ~/diary/journal.enc
```

Verify (decrypt to a temp file):
```bash
openssl enc -aes-256-cbc -pbkdf2 -d -in ~/diary/journal.enc -out /tmp/diary_check.txt
diff ~/diary/journal.txt /tmp/diary_check.txt
```

`diff` shows differences between two files. If it prints nothing, the files are identical!

Clean up:
```bash
rm ~/diary/journal.enc /tmp/diary_check.txt
```

---

## Challenge 4 — Hidden Folder Security

```bash
mkdir ~/.private_stuff
echo "My very private notes." > ~/.private_stuff/notes.txt
chmod 700 ~/.private_stuff
ls ~            # .private_stuff not visible
ls -a ~         # .private_stuff IS visible
ls ~/.private_stuff/  # can access since you're the owner
```

The `700` permission means:
- You (owner): rwx — can read files, write files, and enter the directory
- Group: --- — cannot enter or see anything inside
- Others: --- — same

So only you can do anything with the folder or its contents.
