# Mission 11 — Solutions

## Challenge 1 — Decode All Three Messages

```bash
cat ~/mac-cli-for-kids/playground/mission_11/classified/message_alpha.enc | base64 -d
cat ~/mac-cli-for-kids/playground/mission_11/classified/message_beta.enc | base64 -d
cat ~/mac-cli-for-kids/playground/mission_11/classified/message_gamma.enc | base64 -d
```

Decoded messages:

```text
The suspect was spotted at Pier 7 at midnight.
The stolen data is hidden in a blue folder.
Agent codename: STORMCLOUD. Status: compromised.
```

If your Mac prefers file input instead of a pipe, this also works:

```bash
base64 -d -i ~/mac-cli-for-kids/playground/mission_11/classified/message_alpha.enc
```

---

## Challenge 2 — Fix the Permissions Puzzle

```bash
cd ~/mac-cli-for-kids/playground/mission_11/permissions_puzzle
ls -l
```

Make `locked_file.txt` readable:

```bash
chmod 644 locked_file.txt
cat locked_file.txt
```

Make `readable.txt` unreadable, test it, then restore it:

```bash
chmod 000 readable.txt
cat readable.txt
chmod 644 readable.txt
cat readable.txt
```

Check `owner_only.txt`:

```bash
ls -l owner_only.txt
chmod 600 owner_only.txt
ls -l owner_only.txt
```

`600` means:

- owner: read and write
- group: no access
- others: no access

Restore sensible permissions:

```bash
chmod 644 locked_file.txt readable.txt
chmod 600 owner_only.txt
```

---

## Challenge 3 — Lock Down Your Diary

```bash
chmod 600 ~/diary/journal.txt
ls -l ~/diary/journal.txt
```

Expected permission pattern:

```text
-rw-------
```

Create an encrypted backup:

```bash
openssl enc -aes-256-cbc -pbkdf2 -in ~/diary/journal.txt -out ~/diary/journal.enc
```

Verify by decrypting to a temporary file:

```bash
openssl enc -aes-256-cbc -pbkdf2 -d -in ~/diary/journal.enc -out /tmp/diary_check.txt
diff ~/diary/journal.txt /tmp/diary_check.txt
```

If `diff` prints nothing, the files match.

Clean up:

```bash
rm ~/diary/journal.enc /tmp/diary_check.txt
```

---

## Challenge 4 — Hidden Folder Security

```bash
mkdir ~/.private_case_files
echo "Sensitive case note." > ~/.private_case_files/notes.txt
chmod 700 ~/.private_case_files
```

Verify visibility:

```bash
ls ~
ls -a ~
```

Verify access by full path:

```bash
cat ~/.private_case_files/notes.txt
```

Clean up:

```bash
rm -r ~/.private_case_files
```

`700` means only the owner can read, write, and enter the folder.
