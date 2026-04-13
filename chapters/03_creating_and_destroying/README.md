# Mission 3 — Creating & Destroying

## Mission Briefing — Commander Chen Speaks

*Incoming transmission...*

> "Agent, knowing how to navigate a crime scene is only half the job. A great detective also keeps meticulous records — creating evidence folders, organizing case files, archiving documents, and sometimes shredding files that are no longer needed. Today you learn to build and destroy. You'll create folders, make new files, copy evidence, move it to the right place, and permanently delete what needs to go. One warning: deleting in Terminal is not like deleting in Finder. There is no Trash can. No Undo. When I say gone, I mean gone. Understood? Then let's proceed."

You know how to explore. Now you're going to *build*.

Every detective has a set of case folders on their computer. Keeping them organized is half the skill. Today you learn to create folders, create files, copy things, move things, and delete things — all from the command line.

The dangerous part: **deleting from Terminal is permanent**. There's no Trash. No Undo. Gone means gone. You'll learn how to be careful.

### What You'll Learn
- `mkdir` — make a new folder
- `touch` — create an empty file
- `cp` — copy a file or folder
- `mv` — move or rename
- `rm` — delete (carefully!)
- How to organize a case evidence folder

---

## Your Case Files

Commander Chen has given you a messy evidence pile to work with. Navigate there now:

```bash
cd ~/mac-cli-for-kids/playground/mission_03
ls
```

You should see a folder full of files:

```
case_briefing.txt   junk_file.txt   note_a.txt   note_b.txt   note_c.txt
note_d.txt          note_e.txt      old_backup.txt   photo_001.txt
photo_002.txt       photo_003.txt   photo_004.txt    photo_005.txt
photo_006.txt       photo_007.txt   photo_008.txt    photo_009.txt
photo_010.txt       report_01.txt   report_02.txt    temp.txt
```

That's a lot of unsorted files! A real evidence room needs proper organization. Your mission (in the Challenges section) is to sort this chaos into a proper filing system. But first, learn the tools.

---

## Creating Folders

### `mkdir` — Make Directory

```bash
mkdir my_cases
```

Check it:
```bash
ls
```

`my_cases` is now there! Make several at once:

```bash
mkdir photos notes reports
```

Make a folder *inside* another folder:

```bash
mkdir my_cases/active
mkdir my_cases/closed
mkdir my_cases/cold
```

Make the whole path at once (parent folders too), using `-p`:

```bash
mkdir -p evidence/photos/unprocessed
```

Without `-p`, if `evidence` doesn't exist, `mkdir` would complain. With `-p`, it creates everything in the path.

Check the result:
```bash
ls evidence/photos/
```

---

## Creating Files

### `touch` — Create an Empty File

```bash
touch case_notes.txt
ls -l case_notes.txt
```

Output:
```
-rw-r--r--  1 sophia  staff  0 Apr 13 11:00 case_notes.txt
```

The file exists and is 0 bytes (empty). `touch` was originally made to update a file's timestamp, but creating empty files is its most common use today.

Create multiple files at once:

```bash
touch suspect_a.txt suspect_b.txt suspect_c.txt
ls *.txt
```

The `*.txt` is a **wildcard** — it matches all files ending in `.txt`.

---

## Copying Files

### `cp` — Copy

```bash
cp case_notes.txt case_notes_backup.txt
ls *.txt
```

Output:
```
case_notes.txt  case_notes_backup.txt  suspect_a.txt  ...
```

Both exist now. Copy to a different folder:

```bash
cp case_notes.txt my_cases/case_notes.txt
```

Copy an entire folder (you need `-r` for "recursive" — copy everything inside too):

```bash
cp -r my_cases my_cases_backup
```

Without `-r`, `cp` refuses to copy folders. With `-r`, it copies the folder AND everything inside it.

---

## Moving and Renaming

### `mv` — Move (and Rename)

Move a file to a different folder:

```bash
mv suspect_a.txt my_cases/
ls my_cases/
```

The file is now in `my_cases/`, gone from its original location.

**Rename** a file (same command, different use):

```bash
mv suspect_b.txt primary_suspect.txt
ls *.txt
```

`mv` is "move" — but if you move a file to the same folder with a different name, it just renames it.

Move and rename at the same time:

```bash
mv suspect_c.txt my_cases/secondary_suspect.txt
```

---

## Deleting Files — Be Careful! ⚠️

### `rm` — Remove

```bash
rm case_notes_backup.txt
```

It's gone. No confirmation, no Trash, no undo. That's it.

Check:
```bash
ls *.txt
```

`case_notes_backup.txt` is no longer there.

**Always double-check before deleting:**

```bash
ls my_cases_backup/   # look first
rm -r my_cases_backup # then delete
```

Delete a folder and everything in it: you need `-r` (recursive).

**The `-i` flag asks before each deletion:**

```bash
rm -i primary_suspect.txt
```

Output:
```
remove primary_suspect.txt? 
```

Type `y` and Enter to confirm, `n` to cancel.

### What NOT to Do

**Never type these commands:**
- `rm -rf /` — deletes your entire operating system
- `rm -rf ~` — deletes your entire home folder

Good news: modern macOS has protections against the first one. But the second one will delete everything in your home folder. So: **be careful with `rm -r`, and always know what you're deleting.**

---

## Try It! — Quick Experiments

**Experiment 1:** Build a practice folder and then tear it down.

```bash
mkdir practice_folder
touch practice_folder/file1.txt practice_folder/file2.txt
ls practice_folder/
rm -r practice_folder
ls
```

Notice: gone completely.

**Experiment 2:** Rename a folder.

```bash
mkdir old_case_name
mv old_case_name new_case_name
ls
```

**Experiment 3:** Copy and then compare.

```bash
touch original_evidence.txt
cp original_evidence.txt copy_of_evidence.txt
ls -l *.txt
```

Both should have the same size (0 bytes). Both should be there.

**Experiment 4:** The wildcard deleter.

```bash
touch junk1.txt junk2.txt junk3.txt
ls *.txt
rm junk*.txt
ls *.txt
```

`junk*.txt` matches any file starting with "junk" and ending with ".txt". Wildcards are very powerful — and dangerous. Make sure you know what they'll match before using `rm` with them.

---

## Pro Tip — Check Before You Wreck

Before any dangerous `rm` command, first run `ls` with the same pattern:

```bash
# Before deleting, SEE what you'd be deleting:
ls junk*
# Output: junk1.txt  junk2.txt  junk3.txt  junkfood_recipes.txt

# Then delete (if you're sure):
rm junk*
```

If `junkfood_recipes.txt` was on that list and you didn't want to delete it — good thing you checked first! A careful detective never destroys evidence by accident.

---

## Your Mission — Organize the Evidence Room

Head to your playground folder. Commander Chen left a messy pile of case files and you need to sort them properly.

```bash
cd ~/mac-cli-for-kids/playground/mission_03
cat case_briefing.txt
ls
```

Read the briefing. Then create an organized filing system:

```bash
# Create organized subfolders
mkdir Photos
mkdir Notes
mkdir Reports
mkdir Archive

# Move photos into the Photos folder
mv photo_001.txt Photos/
mv photo_002.txt Photos/
mv photo_003.txt Photos/
# ... continue for photo_004 through photo_010

# Move notes into the Notes folder
mv note_a.txt Notes/
mv note_b.txt Notes/
# ... continue for note_c, note_d, note_e

# Move reports into the Reports folder
mv report_01.txt Reports/
mv report_02.txt Reports/

# Archive the old and temporary files
mv old_backup.txt Archive/
mv temp.txt Archive/

# Delete the junk file (check it first!)
cat junk_file.txt
rm junk_file.txt
```

Check the result:
```bash
ls
ls Photos/
ls Notes/
ls Reports/
ls Archive/
```

Clean! Now the evidence room is properly organized.

---

## 🔍 Secret Code Hunt

There's a hidden file in the `mission_03` playground folder. It contains your third secret code word.

```bash
cd ~/mac-cli-for-kids/playground/mission_03
ls -la
```

Spot the file that starts with a `.`? Read it:

```bash
cat .secret_code.txt
```

Write down word #3. You're a quarter of the way through the master code!

---

## Challenges

### Case #0301 — Build a Case Folder Structure

Create this exact folder structure inside your home folder:

```
~/my_detective_case/
├── evidence/
├── suspects/
├── timeline/
└── case_notes.txt
```

**Hint:** Use `mkdir -p` for folders and `touch` for the file. You can create multiple folders in one `mkdir` command.

### Case #0302 — The Evidence Backup

Copy your `~/my_detective_case` folder to `~/my_detective_case_backup`. Then verify both exist with `ls ~`.

**Hint:** You need `-r` to copy a folder and everything inside it.

### Case #0303 — Rename and Refile

Inside `~/my_detective_case/suspects/`, create three files: `person1.txt`, `person2.txt`, `person3.txt`. Then rename them to `suspect_alpha.txt`, `suspect_beta.txt`, `suspect_gamma.txt` using `mv`.

Then move all three into the `evidence/` folder and rename them at the same time — e.g. move `suspect_alpha.txt` into `evidence/` as `exhibit_a.txt`.

**Hint:** `mv suspects/suspect_alpha.txt evidence/exhibit_a.txt` moves AND renames in one step.

### Case #0304 — Cleanup Crew

Your case is closed. Delete `~/my_detective_case_backup` completely. Then verify it's gone with `ls ~`. Remember: `rm -r` deletes a folder and everything inside it. Check first with `ls` before you delete!

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

*You can now build and demolish. A detective who can organize evidence — and shred what's no longer needed — is a detective who stays on top of their caseload. With great power comes great responsibility — especially with `rm`.*

*Ready for Mission 4?*
