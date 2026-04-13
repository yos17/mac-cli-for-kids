# Mission 3 — Creating & Destroying

## Mission Briefing

You know how to explore. Now you're going to *build*. 

Every programmer has a set of projects on their computer. Keeping them organized is actually half the skill. Today you learn to create folders, create files, copy things, move things, and delete things — all from the command line.

The dangerous part: **deleting from Terminal is permanent**. There's no Trash. No Undo. Gone means gone. You'll learn how to be careful.

### What You'll Learn
- `mkdir` — make a new folder
- `touch` — create an empty file
- `cp` — copy a file or folder
- `mv` — move or rename
- `rm` — delete (carefully!)
- How to organize a messy Downloads folder

---

## Creating Folders

### `mkdir` — Make Directory

```bash
mkdir my_projects
```

Check it:
```bash
ls
```

`my_projects` is now there! Make several at once:

```bash
mkdir art code music writing
```

Make a folder *inside* another folder:

```bash
mkdir my_projects/games
mkdir my_projects/art
mkdir my_projects/school
```

Make the whole path at once (parent folders too), using `-p`:

```bash
mkdir -p secret_stuff/level1/level2/level3
```

Without `-p`, if `secret_stuff` doesn't exist, `mkdir` would complain. With `-p`, it creates everything in the path.

Check the result:
```bash
ls secret_stuff/level1/level2/
```

---

## Creating Files

### `touch` — Create an Empty File

```bash
touch diary.txt
ls -l diary.txt
```

Output:
```
-rw-r--r--  1 sophia  staff  0 Apr 13 11:00 diary.txt
```

The file exists and is 0 bytes (empty). `touch` was originally made to update a file's timestamp, but creating empty files is its most common use today.

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
cp diary.txt diary_backup.txt
ls *.txt
```

Output:
```
diary.txt  diary_backup.txt  ideas.txt  notes.txt  todo.txt
```

Both exist now. Copy to a different folder:

```bash
cp diary.txt my_projects/diary.txt
```

Copy an entire folder (you need `-r` for "recursive" — copy everything inside too):

```bash
cp -r my_projects my_projects_backup
```

Without `-r`, `cp` refuses to copy folders. With `-r`, it copies the folder AND everything inside it.

---

## Moving and Renaming

### `mv` — Move (and Rename)

Move a file to a different folder:

```bash
mv notes.txt my_projects/
ls my_projects/
```

The file is now in `my_projects/`, gone from its original location.

**Rename** a file (same command, different use):

```bash
mv todo.txt my_todo_list.txt
ls *.txt
```

`mv` is "move" — but if you move a file to the same folder with a different name, it just renames it.

Move and rename at the same time:

```bash
mv ideas.txt my_projects/brilliant_ideas.txt
```

---

## Deleting Files — Be Careful! ⚠️

### `rm` — Remove

```bash
rm diary_backup.txt
```

It's gone. No confirmation, no Trash, no undo. That's it.

Check:
```bash
ls *.txt
```

`diary_backup.txt` is no longer there.

**Always double-check before deleting:**

```bash
ls my_projects_backup/   # look first
rm -r my_projects_backup # then delete
```

Delete a folder and everything in it: you need `-r` (recursive).

**The `-i` flag asks before each deletion:**

```bash
rm -i my_todo_list.txt
```

Output:
```
remove my_todo_list.txt? 
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
mkdir old_name
mv old_name new_name
ls
```

**Experiment 3:** Copy and then compare.

```bash
touch original.txt
cp original.txt copy_of_original.txt
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

If `junkfood_recipes.txt` was on that list and you didn't want to delete it — good thing you checked first!

---

## Your Mission — Organize a Messy Downloads Folder

Downloads folders get messy. Let's pretend yours is a disaster and organize it.

First, create a fake messy Downloads area (we'll work in a test folder, not your real Downloads):

```bash
mkdir ~/test_downloads
cd ~/test_downloads

# Create fake messy files
touch photo_vacation.jpg
touch photo_birthday.png
touch photo_dog.jpg
touch essay_english.docx
touch essay_history.pdf
touch essay_science.docx
touch song_favorite.mp3
touch song_summer.mp3
touch video_funny.mp4
touch installer_game.dmg
touch installer_app.pkg
```

Check the mess:
```bash
ls
```

Output:
```
essay_english.docx  installer_app.pkg  photo_birthday.png  song_favorite.mp3  video_funny.mp4
essay_history.pdf   installer_game.dmg  photo_dog.jpg      song_summer.mp3
essay_science.docx  photo_vacation.jpg
```

Now organize it:

```bash
# Create organized subfolders
mkdir Photos
mkdir Documents
mkdir Music
mkdir Videos
mkdir Installers

# Move photos
mv photo_vacation.jpg Photos/
mv photo_birthday.png Photos/
mv photo_dog.jpg Photos/

# Move documents
mv essay_english.docx Documents/
mv essay_history.pdf Documents/
mv essay_science.docx Documents/

# Move music
mv song_favorite.mp3 Music/
mv song_summer.mp3 Music/

# Move videos
mv video_funny.mp4 Videos/

# Move installers
mv installer_game.dmg Installers/
mv installer_app.pkg Installers/
```

Check the result:
```bash
ls
ls Photos/
ls Documents/
ls Music/
```

Clean! Now let's clean up our test:

```bash
cd ~
rm -r test_downloads
```

---

## Challenges

### Challenge 1 — Build a Project Folder

Create this exact folder structure:

```
~/my_project/
├── src/
├── docs/
├── tests/
└── notes.txt
```

**Hint:** Use `mkdir -p` for the folders and `touch` for the file.

### Challenge 2 — The Backup

Copy your `~/my_project` folder to `~/my_project_backup`. Then verify both exist with `ls ~`.

**Hint:** You need `-r` to copy a folder.

### Challenge 3 — Rename Your Files

Inside `~/my_project/src/`, create three files: `program1.txt`, `program2.txt`, `program3.txt`. Then rename them to `script1.sh`, `script2.sh`, `script3.sh` using `mv`.

**Hint:** You'll need one `mv` command per file.

### Challenge 4 — Cleanup

Delete `~/my_project_backup` completely. Then verify it's gone with `ls ~`.

**Hint:** `rm -r` to delete a folder and its contents.

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

*You can now build and demolish. With great power comes great responsibility — especially with `rm`.*

*Ready for Mission 4?*
