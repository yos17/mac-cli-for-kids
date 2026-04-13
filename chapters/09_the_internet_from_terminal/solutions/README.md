# Mission 9 — Solutions

## Challenge 1 — Ping Race

```bash
ping -c 5 google.com
ping -c 5 amazon.com
ping -c 5 bbc.co.uk
ping -c 5 abc.net.au
ping -c 5 1.1.1.1
```

Look at the "avg" number in the last statistics line. For example:
```
round-trip min/avg/max/stddev = 10.2/12.4/15.1/1.8 ms
```

The `12.4` is the average ping time. Rankings will vary by your location, but 1.1.1.1 (Cloudflare) is typically very fast, and Australian servers tend to have high latency from North America.

---

## Challenge 2 — The HTTP Codes Explorer

```bash
curl -s -o /dev/null -w "%{http_code}\n" https://google.com
curl -s -o /dev/null -w "%{http_code}\n" https://google.com/this-page-does-not-exist
curl -s -o /dev/null -w "%{http_code}\n" https://httpstat.us/200
curl -s -o /dev/null -w "%{http_code}\n" https://httpstat.us/404
```

Expected results:
- `google.com` → `200` (OK) or `301` (redirects to www)
- `google.com/nonexistent` → `404` (Not Found)
- `httpstat.us/200` → `200`
- `httpstat.us/404` → `404`

---

## Challenge 3 — Open Your Diary in TextEdit

```bash
open -a TextEdit ~/diary/journal.txt
```

This opens your journal file in TextEdit! You can read it with a nice GUI while still being able to edit it from Terminal too.

The alias version (for Mission 10):
```bash
alias diary="open -a TextEdit ~/diary/journal.txt"
```

After adding this to `.zshrc`, you can just type `diary` and your journal opens!

---

## Challenge 4 — Download and Read

Download Pride and Prejudice:
```bash
curl -O https://www.gutenberg.org/files/1342/1342-0.txt
```

Count the words:
```bash
wc -w 1342-0.txt
```

It should be around 122,000 words! For comparison:
- Harry Potter Book 1: ~77,000 words
- Pride and Prejudice: ~122,000 words
- Average newspaper article: ~800 words

Clean up:
```bash
rm 1342-0.txt
```
