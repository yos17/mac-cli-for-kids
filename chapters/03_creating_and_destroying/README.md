# Mission 3 — The Messy Crime Scene

## Mission Briefing

*Director Chen's voice crackles over the radio: "Rookie, get to 42 Cipher Lane. The previous investigator left evidence files EVERYWHERE. Before any analysis can begin, you need to bring order to the chaos. Organize the crime scene. Now."*

You know how to explore. Now you're going to *build*.

Every detective has organized files. Keeping them organized is half the skill. Today you learn to create folders, move files, copy things, and delete things — all from the command line.

**The crime scene is in `playground/mission_03/`. It's a mess. Fix it.**

### What You'll Learn
- `mkdir` — make a new folder
- `touch` — create an empty file
- `cp` — copy a file or folder
- `mv` — move or rename
- `rm` — delete (carefully!)
- How to use wildcards to move many files at once

---

## Creating Folders

### `mkdir` — Make Directory

```bash
mkdir evidence
```

Make the whole path at once using `-p`:

```bash
mkdir -p evidence/photos
mkdir -p evidence/notes
mkdir -p evidence/reports
```

Without `-p`, if `evidence` doesn't exist, `mkdir` complains. With `-p`, it creates everything in the path.

---

## Creating Files

### `touch` — Create an Empty File

```bash
touch report.txt
ls -l report.txt
```

Create multiple files at once:

```bash
touch notes.txt ideas.txt todo.txt
ls *.txt
```

The `*.txt` is a **wildcard** — it matches all files ending in `.txt`.

---

## Copying Files

### `cp` — Copy

```bash
cp report.txt report_backup.txt
```

Copy an entire folder (you need `-r` for recursive):

```bash
cp -r evidence evidence_backup
```

---

## Moving and Renaming

### `mv` — Move (and Rename)

Move a file to a different folder:

```bash
mv report.txt evidence/
```

**Rename** a file:

```bash
mv old_name.txt new_name.txt
```

Move ALL matching files using wildcards:

```bash
mv photo_*.txt evidence/photos/
```

This is where `mv` becomes a superpower!

---

## Deleting Files — Be Careful! ⚠️

### `rm` — Remove

```bash
rm junk_file.txt
```

It's gone. No Trash. No undo. That's it.

Delete a folder and everything in it:

```bash
rm -r old_folder/
```

**Ask before each deletion:**

```bash
rm -i suspicious_file.txt
```

### What NOT to Do

**Never type these commands:**
- `rm -rf /` — deletes your entire operating system
- `rm -rf ~` — deletes your entire home folder

**Always double-check before deleting with wildcards:**

```bash
ls junk*.txt         # see what matches first
rm junk*.txt         # then delete
```

---

## Try It! — Quick Experiments

**Experiment 1:** Create a test folder and tear it down.

```bash
mkdir test_folder
touch test_folder/file1.txt test_folder/file2.txt
ls test_folder/
rm -r test_folder
ls
```

**Experiment 2:** Rename a folder.

```bash
mkdir old_name
mv old_name new_name
ls
```

**Experiment 3:** The wildcard power.

```bash
touch junk1.txt junk2.txt junk3.txt
ls *.txt
rm junk*.txt
ls *.txt
```

---

## Pro Tip — Check Before You Wreck

Before any dangerous `rm` command, run `ls` with the same pattern first:

```bash
ls photo_*         # see what you'd be deleting
rm photo_*         # then delete (only if you're sure!)
```

---

## Your Mission — Organize the Crime Scene at 42 Cipher Lane

**Step 1:** Navigate to the crime scene:
```bash
cd playground/mission_03
ls
```

You'll see 20+ files in total chaos.

**Step 2:** Read the briefing:
```bash
cat case_briefing.txt
```

**Step 3:** Create the evidence folder structure:
```bash
mkdir -p evidence/photos
mkdir -p evidence/notes
mkdir -p evidence/reports
```

**Step 4:** Move all the photos at once (wildcard power!):
```bash
mv photo_*.txt evidence/photos/
```

**Step 5:** Move the notes:
```bash
mv note_?.txt evidence/notes/
```

**Step 6:** Move the reports:
```bash
mv report_draft.txt evidence/reports/
mv report_final.txt evidence/reports/
```

**Step 7:** Check the organized crime scene:
```bash
ls evidence/photos/
ls evidence/notes/
ls evidence/reports/
```

**Step 8:** Find and read the hidden code:
```bash
ls -la
cat .secret_code.txt
```

---

## Challenges

### Challenge 1 — Build a Project Folder

Create this exact folder structure:

```
my_case/
├── evidence/
├── suspects/
├── notes/
└── summary.txt
```

**Hint:** Use `mkdir -p` for folders and `touch` for the file.

### Challenge 2 — The Backup

Make a complete copy of `playground/mission_03/evidence/` to `playground/mission_03/evidence_backup/`. Verify both exist.

**Hint:** `cp -r` to copy a folder.

### Challenge 3 — Rename Your Files

Inside `my_case/evidence/`, create three files: `clue_a.txt`, `clue_b.txt`, `clue_c.txt`. Rename them to `evidence_001.txt`, `evidence_002.txt`, `evidence_003.txt` using `mv`.

### Challenge 4 — Cleanup

Delete your `my_case/` folder completely. Verify it's gone.

**Hint:** `rm -r my_case/`

---

## Solutions

Solutions are in the [solutions folder](solutions/README.md).

---

## Powers Unlocked

| Command | What It Does |
|---------|-------------|
| `mkdir name` | Creates a new folder |
| `mkdir -p a/b/c` | Creates a whole path of folders at once |
| `touch file.txt` | Creates an empty file |
| `cp file copy` | Copies a file |
| `cp -r folder copy` | Copies a folder and all its contents |
| `mv file dest/` | Moves a file to a folder |
| `mv oldname newname` | Renames a file (or folder) |
| `rm file` | Deletes a file permanently |
| `rm -r folder` | Deletes a folder and everything in it |
| `rm -i file` | Asks for confirmation before deleting |

### Vocabulary

- **Wildcard** — `*` matches any sequence of characters in filenames
- **Recursive** — `-r` means "do this to everything inside, too"
- **Permanent delete** — `rm` skips the Trash; there is no undo

---

*You brought order to chaos. That's what detectives do.*

*Ready for Mission 4?*
