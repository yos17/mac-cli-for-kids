# Mission 9 — The Internet from Terminal

## Mission Briefing

You use the internet every day with a browser — clicking links, watching videos, loading pages. But the internet is actually made of text, and you can talk to it directly from Terminal.

Today you talk to websites without a browser. You'll check if the internet is working, find your IP address, download files, and build a tool that checks your network health.

### What You'll Learn
- `ping` — check if a server is reachable
- `curl` — talk to websites and APIs
- `open` — open things from Terminal
- `caffeinate` — keep your Mac awake
- How the internet works (the basic version)

---

## How the Internet Works (Quick Version)

Every website is just a computer somewhere in the world. When you type `www.google.com` in a browser, your Mac:

1. Looks up Google's **IP address** (like a phone number — e.g., `142.250.80.46`)
2. Connects to that computer
3. Asks for the page: `GET /`
4. Receives HTML text back
5. Renders it as the webpage you see

In Terminal, we can do steps 1-4 directly. No rendering needed.

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
64 bytes from 142.250.80.46: icmp_seq=2 ttl=115 time=12.1 ms
^C
--- google.com ping statistics ---
3 packets transmitted, 3 packets received, 0.0% packet loss
```

Press `Ctrl+C` to stop it.

What the numbers mean:
- `time=12.4 ms` — how long it took (milliseconds). Lower = faster.
- `0.0% packet loss` — all messages got through. Higher = worse connection.

Send exactly 4 pings:

```bash
ping -c 4 google.com
```

Ping a local device (your router is usually at `192.168.1.1`):

```bash
ping -c 3 192.168.1.1
```

If `ping` gets no reply, the server might be down, or you might have no internet.

---

## `curl` — Talk to Websites

`curl` (Client URL) sends web requests and shows you the response. This is how web browsers and apps talk to servers behind the scenes.

### Basic `curl`

```bash
curl http://example.com
```

You'll see raw HTML — that's what websites really look like under the hood!

### Get Just the Headers

```bash
curl -I https://www.apple.com
```

Output:
```
HTTP/2 200
server: Apache
content-type: text/html; charset=utf-8
date: Sun, 13 Apr 2026 10:30:00 GMT
```

`-I` sends only a HEAD request — asks for information about the page without downloading it.

The `200` means "OK". Other common codes:
- `200` — OK (success)
- `301` or `302` — Redirect (the page moved)
- `404` — Not Found (the page doesn't exist)
- `500` — Server Error (the website has a problem)

### Download a File

```bash
curl -O https://example.com/somefile.txt
```

The `-O` flag saves the file with its original name.

Or save with a custom name:

```bash
curl -o myfile.txt https://example.com/somefile.txt
```

### Get Your Public IP Address

There are services that just tell you your IP when you ask:

```bash
curl ifconfig.me
```

Output:
```
73.45.123.89
```

That's your public IP address — the address the internet sees when you go online.

---

## `open` — Open Things from Terminal

`open` is like double-clicking in Finder:

```bash
open ~/Documents          # Open Documents in Finder
open ~/diary/journal.txt  # Open your diary in TextEdit
open https://nasa.gov     # Open a website in Safari
open .                    # Open current folder in Finder
```

Open a specific app:

```bash
open -a "Safari" https://nasa.gov
open -a "Notes"
open -a "TextEdit" ~/diary/journal.txt
```

This is useful in scripts — you can open a file or website as the final step.

---

## `caffeinate` — Keep Your Mac Awake

Your Mac goes to sleep when idle. `caffeinate` stops that:

```bash
caffeinate
```

Your Mac won't sleep until you press `Ctrl+C`. Useful when running long scripts!

Keep awake for a specific time (seconds):

```bash
caffeinate -t 3600    # Stay awake for 1 hour (3600 seconds)
```

Keep awake while a command runs:

```bash
caffeinate -i curl -O https://big-file-download.com/file.zip
```

Stays awake only while the download runs, then lets Mac sleep normally.

---

## Try It! — Quick Experiments

**Experiment 1:** Compare ping times to different places.

```bash
ping -c 3 google.com
ping -c 3 apple.com
ping -c 3 bbc.co.uk    # UK
ping -c 3 abc.net.au   # Australia
```

Servers farther away have higher ping times (more milliseconds). Australia is about 200ms from the US.

**Experiment 2:** Get a fun quote from the internet.

```bash
curl -s https://api.quotable.io/random | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['content'], '-', d['author'])"
```

(This hits a real quotes API and formats the response. Try it a few times for different quotes!)

**Experiment 3:** See your network info.

```bash
ifconfig | grep "inet " | grep -v 127.0.0.1
```

This shows your local network IP address (like `192.168.1.x`).

**Experiment 4:** Check if a website is up.

```bash
curl -s -o /dev/null -w "%{http_code}" https://google.com
```

Output: `200` (or some other code). This is how you check a website's status without downloading anything.

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

---

## Your Mission — Internet Health Checker

Build a script that checks your internet connection from multiple angles:

```bash
nano ~/internet_check.sh
```

```bash
#!/bin/bash
# internet_check.sh — Network health checker

echo ""
echo "╔═══════════════════════════════════╗"
echo "║     INTERNET HEALTH CHECKER       ║"
echo "╚═══════════════════════════════════╝"
echo ""

# --- 1. CHECK LOCAL NETWORK ---
echo "1. Local Network..."
ROUTER_IP="192.168.1.1"   # Your router's IP (might be 192.168.0.1)

if ping -c 1 -W 2 "$ROUTER_IP" > /dev/null 2>&1; then
    echo "   ✓ Router is reachable ($ROUTER_IP)"
else
    echo "   ✗ Cannot reach router — check your WiFi!"
fi

# --- 2. CHECK INTERNET ACCESS ---
echo ""
echo "2. Internet Connection..."

if ping -c 1 -W 3 8.8.8.8 > /dev/null 2>&1; then
    echo "   ✓ Internet is working (reached Google's DNS)"
else
    echo "   ✗ Cannot reach the internet"
fi

# --- 3. CHECK DNS (name resolution) ---
echo ""
echo "3. DNS (domain names)..."

if ping -c 1 -W 3 google.com > /dev/null 2>&1; then
    echo "   ✓ DNS is working (google.com resolves)"
else
    echo "   ✗ DNS not working — can reach internet but not websites by name"
fi

# --- 4. GET YOUR IP ---
echo ""
echo "4. Your IP Addresses..."

LOCAL_IP=$(ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | head -1)
echo "   Local IP:  ${LOCAL_IP:-not found}"

PUBLIC_IP=$(curl -s --max-time 5 ifconfig.me 2>/dev/null)
if [ -n "$PUBLIC_IP" ]; then
    echo "   Public IP: $PUBLIC_IP"
else
    echo "   Public IP: (could not check)"
fi

# --- 5. PING SPEED ---
echo ""
echo "5. Connection Speed..."

PING_TIME=$(ping -c 4 google.com 2>/dev/null | tail -1 | awk -F'/' '{print $5}')
if [ -n "$PING_TIME" ]; then
    echo "   Avg ping to Google: ${PING_TIME}ms"
    
    if (( $(echo "$PING_TIME < 50" | bc -l) )); then
        echo "   Speed: Excellent!"
    elif (( $(echo "$PING_TIME < 100" | bc -l) )); then
        echo "   Speed: Good"
    else
        echo "   Speed: Slow (high latency)"
    fi
fi

echo ""
echo "═══════════════════════════════════"
echo "Check complete!"
```

Save, make executable, and run:

```bash
chmod +x ~/internet_check.sh
~/internet_check.sh
```

---

## Challenges

### Challenge 1 — Ping Race

Ping these 5 servers and time them. List them from fastest to slowest (by average ping time):
- `google.com`
- `amazon.com`
- `bbc.co.uk`
- `abc.net.au`
- `1.1.1.1` (Cloudflare's DNS)

Use `ping -c 5 hostname` for each.

### Challenge 2 — The HTTP Codes Explorer

Use `curl -s -o /dev/null -w "%{http_code}"` to check the status codes for:
1. `https://google.com`
2. `https://google.com/this-page-does-not-exist`
3. `https://httpstat.us/200`
4. `https://httpstat.us/404`

What code does each one return?

### Challenge 3 — Open Your Diary in TextEdit

Write a one-liner that opens your `~/diary/journal.txt` in TextEdit. Then add it as a command to your `~/.zshrc` (we'll learn about that in Mission 10):

```bash
alias diary="open -a TextEdit ~/diary/journal.txt"
```

(Just write this down for now — you'll use it in Mission 10!)

### Challenge 4 — Download and Read

Use `curl` to download any plain text file from the internet (a `.txt` file), save it to your home folder, and use `wc -w` to count how many words it has.

A good one to try: `curl -O https://www.gutenberg.org/files/1342/1342-0.txt` (Pride and Prejudice!)

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
| `curl -I url` | Show HTTP headers only |
| `curl -O url` | Download a file (keeps original name) |
| `curl -o name url` | Download a file (custom name) |
| `curl -s url` | Silent mode (no progress output) |
| `curl -w "%{http_code}" url` | Show only the HTTP status code |
| `open path` | Open file or folder in default app |
| `open url` | Open URL in default browser |
| `open -a "App" path` | Open with a specific app |
| `caffeinate` | Prevent Mac from sleeping |
| `caffeinate -t 60` | Prevent sleep for 60 seconds |
| `ifconfig.me` | Service that returns your public IP |

### Vocabulary

- **IP address** — a number that identifies a computer on the network
- **DNS** — Domain Name System — converts names like `google.com` to IP addresses
- **HTTP** — HyperText Transfer Protocol — the language browsers and servers use
- **Latency** — how long a request takes (milliseconds). Lower = faster.
- **API** — Application Programming Interface — a website designed to be used by programs, not browsers

---

*The internet is just computers talking to each other. And now you know how to join the conversation.*

*Ready for Mission 10?*
