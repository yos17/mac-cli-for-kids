# Mission 9 — Solutions

## Challenge 1 — API Investigation

```bash
while IFS= read -r url; do
    echo "--- Contacting: $url ---"
    curl -s "$url" | head -3
    echo ""
done < ~/mac-cli-for-kids/playground/mission_09/urls.txt
```

What you see depends on the live services, but typical results:

- `https://api.ipify.org` returns your public IP address.
- `https://wttr.in/?format=3` returns a one-line weather summary.
- `https://icanhazip.com` returns your public IP address.
- `https://httpbin.org/get` returns JSON about your request.
- `https://api.github.com/zen` returns a short programming quote.

---

## Challenge 2 — The HTTP Codes Explorer

```bash
while IFS= read -r url; do
    code=$(curl -s -o /dev/null -w "%{http_code}" "$url")
    if [ "$code" = "200" ]; then
        echo "$url -> $code OK"
    else
        echo "$url -> $code check this"
    fi
done < ~/mac-cli-for-kids/playground/mission_09/urls.txt
```

Bonus:

```bash
curl -s -o /dev/null -w "%{http_code}\n" https://httpstat.us/404
curl -s -o /dev/null -w "%{http_code}\n" https://httpstat.us/500
```

Meanings:

- `404` means Not Found.
- `500` means Server Error.

---

## Challenge 3 — Network Log Deep Dive

```bash
cd ~/mac-cli-for-kids/playground/mission_09
```

Unique IP addresses:

```bash
grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' network_log.txt | sort -u | wc -l
```

Expected answer: `13`.

Most common IP address:

```bash
grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' network_log.txt | sort | uniq -c | sort -rn | head -3
```

Expected top IP: `10.0.0.99`.

Unusual hours, around 2 AM or 3 AM:

```bash
grep -E ' 0[23]:' network_log.txt
```

This shows the expected backup/time-sync lines and the suspicious `10.0.0.99` timeout at `02:33:29`.

---

## Challenge 4 — Download and Analyze

Download the Sherlock Holmes text:

```bash
curl -o mystery_novel.txt https://www.gutenberg.org/files/1661/1661-0.txt
```

Count words:

```bash
wc -w mystery_novel.txt
```

Find lines mentioning Holmes:

```bash
grep -ni "holmes" mystery_novel.txt | head
```

Clean up when done:

```bash
rm mystery_novel.txt
```
