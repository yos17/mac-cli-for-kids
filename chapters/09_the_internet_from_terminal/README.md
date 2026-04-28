# Mission 9 — The Internet from Terminal

## Mission Briefing

*Incoming transmission from Commander Chen...*

> "Detective, we have intercepted suspicious network traffic. Connections from unknown IP addresses, requests at odd hours, packets going places they should not go.
>
> To investigate, you need to understand the internet the way it actually works — not through a browser, but through the raw protocols underneath. Today you learn to talk to the internet directly from Terminal.
>
> You will check if servers are reachable, fetch data from web services, and analyze a network log for suspicious activity. When you are done, you will know things about the internet that most adults do not.
>
> The network does not lie. Neither do the logs."

You use the internet every day with a browser, but that browser is hiding a lot. The internet is actually made of text — structured messages sent back and forth between computers. Today you learn to see those messages directly.

### What You'll Learn
- `ping` — check if a server is reachable
- `curl` — talk to websites and APIs
- `open` — open things from Terminal
- `caffeinate` — keep your Mac awake during long operations
- How the internet actually works under the hood
- How to read a network log for suspicious activity

---

## Your Case Files

Report to the network investigation lab:

```bash
cd ~/mac-cli-for-kids/playground/mission_09
ls
```

You should see:

```
urls.txt           ← 5 safe API URLs to investigate
network_log.txt    ← 20-line network log with suspicious activity
.secret_code.txt   ← hidden! (find it at the end of the mission)
```

Look at the URLs you will be working with:

```bash
cat urls.txt
```

You should see:
```
api.ipify.org
wttr.in
icanhazip.com
httpbin.org/get
api.github.com/zen
```

These are all real, safe services that return useful information when you send them a request. You will use `curl` to talk to each one.

Now look at the network log:

```bash
cat network_log.txt
```

Twenty lines of network activity. Some of it looks normal. Some of it... does not. Your job later in this mission is to analyze it. First, learn the tools.

---

## How the Internet Works (Quick Version)

Every website is just a computer somewhere in the world. When you type `www.google.com` in a browser, your Mac:

1. Looks up Google's **IP address** (like a phone number — e.g., `142.250.80.46`)
2. Connects to that computer using the address
3. Sends a request: `GET /` (give me the main page)
4. Receives HTML text back
5. Renders that HTML as the webpage you see

In Terminal, you can do steps 1–4 directly. No rendering needed — you see the raw response.

---

## `ping` — Are You There?

`ping` sends a tiny message to a server and waits for a reply. Like knocking on a door.

```bash
ping google.com
```

Output:
```
PING google.com (142.250.80.46): 56 data bytes
64 bytes from 142.250.80.46: icmp_seq=0 ttl=115 time=12.4 ms
64 bytes from 142.250.80.46: icmp_seq=1 ttl=115 time=11.8 ms
^C
--- google.com ping statistics ---
2 packets transmitted, 2 packets received, 0.0% packet loss
```

Press `Ctrl+C` to stop it.

What the numbers mean:
- `time=12.4 ms` — how long the round trip took (milliseconds). Lower = faster.
- `0.0% packet loss` — all messages got through. Any % means a weak connection.

Send exactly 4 pings instead of running forever:

```bash
ping -c 4 google.com
```

Ping a local device (your router is usually at `192.168.1.1` or `192.168.0.1`):

```bash
ping -c 3 192.168.1.1
```

If `ping` gets no reply, either the server is down, the server blocks pings, or you have no internet connection.

---

## `curl` — Talk to Websites

`curl` (Client URL) sends web requests and shows you the response. This is exactly what browsers and apps do behind the scenes — they just do it invisibly.

### Basic `curl`

```bash
curl http://example.com
```

You will see raw HTML — that is what every website looks like before the browser renders it.

### Get Just the Headers

```bash
curl -I https://www.apple.com
```

Output:
```
HTTP/2 200
server: Apache
content-type: text/html; charset=utf-8
date: Mon, 13 Apr 2026 10:30:00 GMT
```

`-I` sends only a HEAD request — asks for information about the page without downloading the full content.

The number at the top is the **HTTP status code**:
- `200` — OK (success)
- `301` or `302` — Redirect (page has moved)
- `404` — Not Found (page does not exist)
- `500` — Server Error (something is broken on the website)

### Download a File

```bash
curl -O https://example.com/somefile.txt
```

The `-O` flag saves the file with its original name in your current folder.

Save with a custom name instead:

```bash
curl -o my_download.txt https://example.com/somefile.txt
```

### Get Your Public IP Address

```bash
curl icanhazip.com
```

Output:
```
73.45.123.89
```

That is your public IP address — the number the internet uses to identify your connection. Now try the other IP service from your case files:

```bash
curl api.ipify.org
```

Same result, different service. They both work because multiple services do the same thing.

---

## Talking to APIs

An **API** (Application Programming Interface) is a website designed to be used by programs, not humans. It returns structured data instead of a fancy webpage.

Try the GitHub API from your `urls.txt`:

```bash
curl https://api.github.com/zen
```

This returns a short piece of programming wisdom. Run it a few times — it gives a different quote each time.

Try the weather service:

```bash
curl "wttr.in/London?format=3"
```

That returns a one-line weather summary for London. Change the city to your own city!

Try httpbin — it echoes your own request back to you:

```bash
curl https://httpbin.org/get
```

This shows you exactly what your computer sent to the server: your IP address, your curl version, and other details.

---

## `open` — Open Things from Terminal

`open` is like double-clicking in Finder, but from the command line:

```bash
open ~/Documents           # Open Documents folder in Finder
open https://nasa.gov      # Open a website in your default browser
open .                     # Open current folder in Finder
```

Open with a specific app:

```bash
open -a "Safari" https://nasa.gov
open -a "TextEdit" ~/mac-cli-for-kids/playground/mission_09/network_log.txt
```

This is useful at the end of scripts — you can automatically open a report in TextEdit when your script finishes.

---

## `caffeinate` — Keep Your Mac Awake

Your Mac goes to sleep when idle. `caffeinate` prevents that:

```bash
caffeinate
```

Your Mac will not sleep until you press `Ctrl+C`. Useful when running long downloads or analysis scripts.

Keep awake for a specific time:

```bash
caffeinate -t 3600    # Stay awake for 1 hour (3600 seconds)
```

Keep awake only while a command is running:

```bash
caffeinate -i curl -O https://big-file.example.com/file.zip
```

Stays awake for the download, then lets Mac sleep normally.

---

## Try It! — Quick Experiments

**Experiment 1:** Compare ping times to different servers.

```bash
ping -c 3 google.com
ping -c 3 apple.com
ping -c 3 bbc.co.uk     # UK server
ping -c 3 abc.net.au    # Australia server
```

Servers farther away physically take longer to respond. Australia from the US is about 200ms. Your router should be under 5ms. What pattern do you see?

**Experiment 2:** Get your public IP two different ways.

```bash
curl icanhazip.com
curl api.ipify.org
```

Do they agree? They should — you have one public IP.

**Experiment 3:** See your local network IP.

```bash
ifconfig | grep "inet " | grep -v 127.0.0.1
```

This shows your local IP address (like `192.168.1.x`) — the address within your home network. It is different from your public IP.

**Experiment 4:** Check if a website is up without downloading anything.

```bash
curl -s -o /dev/null -w "%{http_code}" https://google.com
```

Output: `200` (or another code). `-s` = silent, `-o /dev/null` = throw away the response body, `-w "%{http_code}"` = print just the status code. This is a common trick for monitoring scripts.

---

## Pro Tip — `curl` with a Progress Bar

When downloading large files, add `-#` to show a progress bar:

```bash
curl -# -O https://example.com/largefile.zip
```

Output:
```
######################################################## 100.0%
```

Much better than silence and wondering if it is working.

---

## Your Mission — Network Log Investigator

Now use your new skills to analyze the suspicious network log. Build a script that reads `network_log.txt` and flags anything unusual.

```bash
nano ~/investigate_network.sh
```

```bash
#!/bin/bash
# investigate_network.sh — Analyze a network log for suspicious activity

LOG_FILE="$HOME/mac-cli-for-kids/playground/mission_09/network_log.txt"

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║     NETWORK LOG INVESTIGATOR             ║"
echo "╚══════════════════════════════════════════╝"
echo ""

if [ ! -f "$LOG_FILE" ]; then
    echo "ERROR: Log file not found at $LOG_FILE"
    exit 1
fi

echo "Log file: $LOG_FILE"
echo "Total entries: $(wc -l < "$LOG_FILE")"
echo ""

# --- STEP 1: SHOW THE FULL LOG ---
echo "=== FULL LOG ==="
cat -n "$LOG_FILE"
echo ""

# --- STEP 2: CHECK INTERNET CONNECTION ---
echo "=== LIVE INTERNET STATUS ==="

if ping -c 1 -W 2 8.8.8.8 > /dev/null 2>&1; then
    echo "  Internet: Connected"
else
    echo "  Internet: NO CONNECTION"
fi

PUBLIC_IP=$(curl -s --max-time 5 icanhazip.com 2>/dev/null)
if [ -n "$PUBLIC_IP" ]; then
    echo "  Your public IP: $PUBLIC_IP"
fi

PING_TIME=$(ping -c 3 google.com 2>/dev/null | tail -1 | awk -F'/' '{print $5}' | cut -d'.' -f1)
if [ -n "$PING_TIME" ]; then
    echo "  Ping to Google: ${PING_TIME}ms"
fi
echo ""

# --- STEP 3: SEARCH FOR SUSPICIOUS PATTERNS ---
echo "=== SUSPICIOUS ACTIVITY SCAN ==="

echo ""
echo "Connections to unusual ports (not 80 or 443):"
grep -v ":80\b" "$LOG_FILE" | grep -v ":443\b" | grep ":[0-9]" | head -10

echo ""
echo "Failed connection attempts:"
grep -i "fail\|denied\|refused\|error" "$LOG_FILE" | head -10

echo ""
echo "Non-standard IP ranges (not 192.168 or 10.0):"
grep -v "192\.168\." "$LOG_FILE" | grep -v "10\.0\." | grep "[0-9]\{1,3\}\.[0-9]\{1,3\}\." | head -10

echo ""
echo "=== INVESTIGATION COMPLETE ==="
```

Save, make executable, and run:

```bash
chmod +x ~/investigate_network.sh
bash ~/investigate_network.sh
```

Look at the output carefully. What looks suspicious? Report your findings to Commander Chen.

---

## Challenges

### Case #0901 — API Investigation

Use `curl` on every URL in `~/mac-cli-for-kids/playground/mission_09/urls.txt`. Write a `for` loop that reads the file line by line and curls each URL:

```bash
while IFS= read -r url; do
    echo "--- Contacting: $url ---"
    curl -s "$url" | head -3
    echo ""
done < ~/mac-cli-for-kids/playground/mission_09/urls.txt
```

Record what each one returns. Which one is most useful? Which one is most interesting?

### Case #0902 — The HTTP Codes Explorer

Use `curl -s -o /dev/null -w "%{http_code}"` to check the status code returned by each URL in `urls.txt`. Create a loop that checks all 5 and prints whether each one returned 200 (success) or something else.

**Bonus:** Check `https://httpstat.us/404` and `https://httpstat.us/500` — services that return specific error codes on purpose. What does each one mean?

### Case #0903 — Network Log Deep Dive

Open `network_log.txt` and answer these questions using `grep` commands:
1. How many unique IP addresses appear in the log? (`grep -o "[0-9.]*" | sort -u | wc -l`)
2. What is the most common IP address? (`grep -o "[0-9.]*" | sort | uniq -c | sort -rn | head -3`)
3. Are there any connections at unusual hours (e.g., 2 AM or 3 AM)?

Write each answer as a one-line command. You are being a real network investigator now.

### Case #0904 — Download and Analyze

Use `curl` to download a plain text file from the internet. The Project Gutenberg library has free public domain books:

```bash
curl -o mystery_novel.txt https://www.gutenberg.org/files/1661/1661-0.txt
```

(That is the Adventures of Sherlock Holmes — very fitting.) Then use commands from earlier missions to analyze it:
- How many words? (`wc -w`)
- How many times does "Holmes" appear? (`grep -c "Holmes"`)
- What are the 10 most common words? (Combine `tr`, `sort`, and `uniq -c`)

---

## Secret Code Hunt

You now know how to use `curl` to contact remote servers and how to read files in Terminal.

The `mission_09` playground has a hidden file too. Use what you have learned:

```bash
cd ~/mac-cli-for-kids/playground/mission_09
ls -a
```

Find the file starting with `.` and read it. That is your ninth secret code word. Write it down on your certificate sheet.

---

## Solutions

Solutions are in the [solutions folder](solutions/README.md).

---

## Powers Unlocked

| Command | What It Does |
|---------|-------------|
| `ping hostname` | Check if a server is reachable |
| `ping -c 4 host` | Send exactly 4 pings |
| `curl url` | Fetch a URL and show the response |
| `curl -I url` | Show HTTP headers only (no body) |
| `curl -O url` | Download a file (keep original name) |
| `curl -o name url` | Download a file (custom name) |
| `curl -s url` | Silent mode (no progress output) |
| `curl -w "%{http_code}" url` | Show only the HTTP status code |
| `open path` | Open file or folder in default app |
| `open url` | Open URL in default browser |
| `open -a "App" path` | Open with a specific app |
| `caffeinate` | Prevent Mac from sleeping |
| `caffeinate -t 60` | Prevent sleep for 60 seconds |
| `icanhazip.com` | Service that returns your public IP |

### Vocabulary

- **IP address** — a number identifying a computer on a network (like a phone number)
- **DNS** — Domain Name System — converts `google.com` to an IP address
- **HTTP** — HyperText Transfer Protocol — the language browsers and servers use
- **HTTP status code** — a number that says whether a request succeeded (`200`) or failed (`404`)
- **Latency** — how long a request takes in milliseconds. Lower = faster.
- **API** — Application Programming Interface — a website designed to answer questions from programs, not browsers
- **Public IP** — the address the internet sees when your network connects to the world

---

*The internet is just computers talking to each other. Now you know how to join that conversation — and how to spot when something in the conversation looks wrong.*

*Ready for Mission 10?*
