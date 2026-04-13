# CASE FILE #3 — The Messy Crime Scene
**Terminal Detective Agency | Clearance Level: Cadet**

---

## 🔍 MISSION BRIEFING

Agent, we have a situation.

While you were out on your last case, the suspect from Case #2 doubled back and ransacked our evidence room. Photos are mixed in with interview notes. Reports are duplicated three times with different names. There are copies of copies. Nobody can find anything.

The Agency cannot work like this. Before we can analyze the evidence, we need to organize it — and we need to do it fast. That means creating proper folders, moving files into the right places, and deleting the duplicates that are cluttering everything up.

Here's the critical part: **deleting from Terminal is permanent.** There is no Trash. No Recycle Bin. No Undo button. When you delete a file with Terminal, it is gone forever. You'll learn to be extremely careful about this — checking before you wreck is a core Agency protocol.

Your mission: navigate into the evidence room at `playground/mission_03/`, assess the chaos, create an organized structure inside the `evidence/` folder, and move everything to where it belongs. The secret code piece is hidden somewhere in the mess. Find it.

**Your tools:** `mkdir`, `touch`, `cp`, `mv`, `rm`, wildcards (`*`)
**Access your case files:** `cd playground/mission_03`

---

## 📚 DETECTIVE TRAINING: Creating Folders

### `mkdir` — Make Directory (Create a New Room)

Every well-organized evidence room needs clearly labeled storage areas. Let's build them:

```bash
mkdir evidence_room
```

Check that it was created:
```bash
ls
```

`evidence_room` is now there! Create several folders at once:

```bash
mkdir photos notes reports interviews
```

Create a folder *inside* another folder:

```bash
mkdir evidence_room/photos
mkdir evidence_room/notes
mkdir evidence_room/reports
```

Create an entire deep path at once using the `-p` flag:

```bash
mkdir -p cold_cases/year_2024/january/week1
```

Without `-p`, if `cold_cases` doesn't exist, `mkdir` would complain and refuse. With `-p`, it creates every folder in the path — as many levels as you need. Perfect for building deep filing systems quickly.

Check the result:
```bash
ls cold_cases/year_2024/january/
```

---

## 📚 DETECTIVE TRAINING: Creating Files

### `touch` — Create an Empty File (Reserve a Spot)

Sometimes you need to reserve a file slot before you have content to put in it. `touch` creates an empty file instantly:

```bash
touch case_notes.txt
ls -l case_notes.txt
```

Output:
```
-rw-r--r--  1 sophia  staff  0 Apr 13 11:00 case_notes.txt
```

The file exists and is 0 bytes (empty). It's a placeholder — a reserved spot in the filing system. `touch` was originally made to update a file's timestamp, but creating empty files is its most common use today.

Create multiple files at once:

```bash
touch evidence_a.txt evidence_b.txt evidence_c.txt
ls *.txt
```

The `*.txt` is a **wildcard** — the `*` matches any sequence of characters, so `*.txt` means "every file that ends in `.txt`." You'll use wildcards constantly for handling groups of files.

---

## 📚 DETECTIVE TRAINING: Copying Files

### `cp` — Copy (Duplicate the Evidence)

Detectives always keep a backup of original evidence before working with it:

```bash
cp case_notes.txt case_notes_backup.txt
ls *.txt
```

Output:
```
case_notes.txt  case_notes_backup.txt  evidence_a.txt  evidence_b.txt  evidence_c.txt
```

Both files exist now — the original is untouched. Copy a file to a different folder:

```bash
cp case_notes.txt evidence_room/case_notes.txt
```

Copy an entire folder (you need `-r` for "recursive" — it copies the folder AND everything inside it):

```bash
cp -r evidence_room evidence_room_backup
```

Without `-r`, `cp` refuses to copy folders. With `-r`, the entire structure is duplicated. Always back up before reorganizing a major case file.

---

## 📚 DETECTIVE TRAINING: Moving and Renaming

### `mv` — Move (and Rename)

`mv` is one of the most useful tools in the Agency's kit. It moves files to new locations — and if you point it at the same folder with a different name, it renames the file.

Move a file to a different folder:

```bash
mv evidence_a.txt evidence_room/
ls evidence_room/
```

The file is now in `evidence_room/`, gone from its original location. It wasn't copied — it was moved.

**Rename** a file (same command, different use):

```bash
mv case_notes.txt active_case_notes.txt
ls *.txt
```

`mv` is "move" — but if you move a file to the same folder with a different name, it just renames it. One command, two abilities.

Move and rename at the same time:

```bash
mv evidence_b.txt evidence_room/exhibit_B.txt
```

In one command: moved to the folder AND given a proper exhibit name.

---

## 📚 DETECTIVE TRAINING: Deleting Files — READ THIS CAREFULLY

### `rm` — Remove (Permanently Destroy)

```bash
rm case_notes_backup.txt
```

It's gone. No confirmation prompt. No Trash. No undo. That's it.

Verify:
```bash
ls *.txt
```

`case_notes_backup.txt` is no longer there. The Agency's most powerful deletion tool is also its most dangerous.

**Always look before you delete:**

```bash
ls evidence_room_backup/   # look at what's there first
rm -r evidence_room_backup  # then delete the whole folder
```

To delete a folder and everything inside it, you need `-r` (recursive).

**The `-i` flag asks for confirmation before each deletion:**

```bash
rm -i evidence_c.txt
```

Output:
```
remove evidence_c.txt? 
```

Type `y` and Enter to confirm, `n` to cancel. Use `-i` when you're not 100% certain about what you're deleting.

### What NOT to Do — Agency Safety Protocol

**Never type these commands:**
- `rm -rf /` — would delete your entire operating system
- `rm -rf ~` — would delete your entire home folder and everything in it

Modern macOS blocks the first one. But the second will destroy everything personal on your computer. So: **always know exactly what you're deleting before you delete it.** No exceptions. Even experienced agents double-check.

---

## 🧪 FIELD WORK

Navigate to the crime scene:

```bash
cd playground/mission_03
```

**Experiment 1:** Survey the chaos. How bad is it?

```bash
ls
```

What a mess! Photos, notes, reports, and duplicates everywhere. This is what the suspect left behind.

**Experiment 2:** Build a practice structure and demolish it.

```bash
mkdir practice_room
touch practice_room/file1.txt practice_room/file2.txt
ls practice_room/
rm -r practice_room
ls
```

Notice: the whole folder is completely gone.

**Experiment 3:** Try renaming a folder.

```bash
mkdir old_label
mv old_label new_label
ls
```

**Experiment 4:** Copy something and compare.

```bash
cp report_DRAFT.txt report_DRAFT_backup.txt
ls -l report_DRAFT*.txt
```

Both should have the same size. Both should be listed.

**Experiment 5:** The wildcard preview — see what wildcards match BEFORE deleting anything.

```bash
ls photos_0*.txt
```

This shows you every file starting with `photos_0` and ending in `.txt`. You can preview what a wildcard matches before using it in an `rm` command. Always do this first.

**Experiment 6:** Create multiple files and delete them with a wildcard.

```bash
touch junk1.txt junk2.txt junk3.txt
ls junk*.txt
rm junk*.txt
ls junk*.txt
```

`junk*.txt` matches any file starting with "junk" and ending with ".txt". Notice we used `ls` with the wildcard first to confirm what would be deleted — then we ran `rm`. That is Agency protocol.

---

## 💡 PRO TIP — Check Before You Wreck

Before any dangerous `rm` command, always run `ls` with the same pattern first:

```bash
# Before deleting, SEE what you'd be deleting:
ls junk*
# Output: junk1.txt  junk2.txt  junk3.txt  junkfood_recipes.txt

# Then delete — only if the list is exactly what you wanted:
rm junk*
```

If `junkfood_recipes.txt` showed up on that list and you didn't want to delete it — good thing you checked first. This habit has saved countless Agency case files from accidental destruction.

---

## 🎯 MISSION: Organize the Crime Scene

The evidence room at `playground/mission_03/` is a disaster. Your job is to bring order to the chaos. An `evidence/` folder is already waiting for you — build out the structure inside it and sort everything correctly.

**Step 1:** Navigate in and see what you're dealing with.

```bash
cd playground/mission_03
ls
```

You'll see photos, notes, reports, interview files, and duplicates — all mixed together. Somewhere in this mess is the secret code piece.

**Step 2:** Build organized subfolders inside `evidence/`.

```bash
mkdir evidence/photos evidence/notes evidence/reports evidence/interviews
```

**Step 3:** Move the photo files.

```bash
ls photos_*.txt
mv photos_*.txt evidence/photos/
```

Check it worked:
```bash
ls evidence/photos/
```

**Step 4:** Move the notes files.

```bash
ls notes_*.txt
mv notes_*.txt evidence/notes/
```

**Step 5:** Move the reports — but be selective. We only want the FINAL report, not the drafts:

```bash
ls report_*.txt
mv report_FINAL.txt evidence/reports/
```

What should you do with `report_DRAFT.txt` and `report_v2.txt`? Check if they're actually different first, then decide. For now, move `report_v2.txt` to the reports folder and delete the draft:

```bash
mv report_v2.txt evidence/reports/
ls report_DRAFT.txt   # confirm it's there before deleting
rm report_DRAFT.txt
```

**Step 6:** Handle the interview notes — one of them is a duplicate.

```bash
ls interview_*.txt
```

You'll see `interview_notes.txt` and `interview_notes_copy.txt`. Keep the original, delete the copy:

```bash
rm interview_notes_copy.txt
mv interview_notes.txt evidence/interviews/
```

**Step 7:** Handle the suspect and evidence photos.

```bash
mv suspect_photo.txt evidence/photos/
mv evidence_photo.txt evidence/photos/
```

**Step 8:** Verify your organized structure.

```bash
ls evidence/
ls evidence/photos/
ls evidence/notes/
ls evidence/reports/
ls evidence/interviews/
```

Clean! Every file has a proper home. The Agency can work with this.

---

## 🏆 BONUS MISSIONS

### Bonus Mission 1 — Build a Full Case File Structure

Create this exact folder structure from scratch:

```
~/my_case/
├── evidence/
├── suspect_profiles/
├── witness_statements/
└── case_summary.txt
```

**Hint:** Use `mkdir -p` for the folders and `touch` for the file.

### Bonus Mission 2 — The Evidence Backup

Copy your `~/my_case` folder to `~/my_case_backup`. Then verify both exist:

```bash
ls ~
```

**Hint:** You need `-r` to copy a folder and everything inside it.

### Bonus Mission 3 — Rename the Files

Inside `~/my_case/evidence/`, create three files: `exhibit1.txt`, `exhibit2.txt`, `exhibit3.txt`. Then rename them to `exhibit_A.txt`, `exhibit_B.txt`, `exhibit_C.txt` using `mv`.

**Hint:** You'll need one `mv` command per file.

### Bonus Mission 4 — Secure Cleanup

Delete `~/my_case_backup` completely. Then verify it's gone:

```bash
ls ~
```

**Hint:** Use `rm -r` to delete a folder and all its contents — and use `ls` first to confirm what you're about to delete.

---

## Solutions

Solutions are in the [solutions folder](solutions/README.md).

---

## 🔐 CODE PIECE UNLOCKED!

You organized the crime scene. Every file is in its place. Excellent detective work.

**Code Piece #3: NOW**

The code piece was hiding in the mess the whole time. Check if you found it during your cleanup — or look for it now:

```bash
cat playground/mission_03/secret_code_piece.txt
```

Add it to your collection alongside Code Pieces #1 and #2. The secret message is starting to form...

---

## ⚡ POWERS UNLOCKED

| Command | What It Does |
|---------|-------------|
| `mkdir name` | Creates a new folder |
| `mkdir -p a/b/c` | Creates an entire path of folders at once |
| `touch file.txt` | Creates an empty file |
| `cp file copy` | Copies a file |
| `cp -r folder copy` | Copies a folder and all its contents |
| `mv file dest/` | Moves a file to a folder |
| `mv oldname newname` | Renames a file or folder |
| `rm file` | Deletes a file permanently (no undo!) |
| `rm -r folder` | Deletes a folder and everything in it |
| `rm -i file` | Asks for confirmation before deleting |

### Vocabulary

- **Wildcard** — `*` matches any sequence of characters in file names
- **Recursive** — the `-r` flag means "do this to everything inside, too"
- **Permanent delete** — `rm` skips the Trash completely; there is no undo
- **Flag** — an extra instruction added to a command, starting with `-`

---

*You can build and you can demolish. With great power comes great responsibility — especially with `rm`.*

*Report to Case File #4 when you're ready.*
