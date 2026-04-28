# Mission 3 — Solutions

## Challenge 1 — Build a Case Folder Structure

```bash
mkdir -p ~/my_detective_case/evidence
mkdir -p ~/my_detective_case/suspects
mkdir -p ~/my_detective_case/timeline
touch ~/my_detective_case/case_notes.txt
ls ~/my_detective_case
```

Or in fewer commands:

```bash
mkdir -p ~/my_detective_case/{evidence,suspects,timeline}
touch ~/my_detective_case/case_notes.txt
```

Expected folders:

```text
case_notes.txt  evidence  suspects  timeline
```

---

## Challenge 2 — The Evidence Backup

```bash
cp -r ~/my_detective_case ~/my_detective_case_backup
ls ~
```

You should see both `my_detective_case` and `my_detective_case_backup`.

---

## Challenge 3 — Rename and Refile

Create and rename the suspect files:

```bash
cd ~/my_detective_case
touch suspects/person1.txt suspects/person2.txt suspects/person3.txt

mv suspects/person1.txt suspects/suspect_alpha.txt
mv suspects/person2.txt suspects/suspect_beta.txt
mv suspects/person3.txt suspects/suspect_gamma.txt
```

Move them into `evidence/` and rename them at the same time:

```bash
mv suspects/suspect_alpha.txt evidence/exhibit_a.txt
mv suspects/suspect_beta.txt evidence/exhibit_b.txt
mv suspects/suspect_gamma.txt evidence/exhibit_c.txt
ls evidence
```

Expected:

```text
exhibit_a.txt  exhibit_b.txt  exhibit_c.txt
```

---

## Challenge 4 — Cleanup Crew

Check before deleting:

```bash
ls ~/my_detective_case_backup
```

Delete the backup:

```bash
rm -r ~/my_detective_case_backup
ls ~
```

`my_detective_case_backup` should be gone. `my_detective_case` should still exist.
