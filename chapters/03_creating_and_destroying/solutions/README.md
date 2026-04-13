# Mission 3 — Solutions

## Challenge 1 — Build a Project Folder

```bash
mkdir -p ~/my_project/src
mkdir ~/my_project/docs
mkdir ~/my_project/tests
touch ~/my_project/notes.txt
ls ~/my_project/
```

Output:
```
docs/  notes.txt  src/  tests/
```

---

## Challenge 2 — The Backup

```bash
cp -r ~/my_project ~/my_project_backup
ls ~
```

You should see both `my_project` and `my_project_backup` in your home folder.

---

## Challenge 3 — Rename Your Files

```bash
cd ~/my_project/src

touch program1.txt program2.txt program3.txt
ls

mv program1.txt script1.sh
mv program2.txt script2.sh
mv program3.txt script3.sh

ls
```

Output:
```
script1.sh  script2.sh  script3.sh
```

**Bonus:** You could also create them with `.sh` extension from the start using `touch script1.sh script2.sh script3.sh` — but renaming is good practice!

---

## Challenge 4 — Cleanup

```bash
rm -r ~/my_project_backup
ls ~
```

`my_project_backup` should be gone. `my_project` should still be there (we only deleted the backup).
