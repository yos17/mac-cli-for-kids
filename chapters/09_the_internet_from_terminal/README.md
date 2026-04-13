# Mission 9 — The Digital Spy

## Mission Briefing

*"The network log shows something suspicious," Agent NOVA says, pointing at `playground/mission_09/network_log.txt`. "An IP address made 847 requests in 60 seconds. I need you to learn how to check network health, identify IPs, and talk to web services directly — no browser required."*

You use the internet every day with a browser. But the internet is actually made of text, and you can talk to it directly from Terminal. Today you learn to ping servers, fetch web data, and build a network health checker.

**The network data files are in `playground/mission_09/`. Study them while you learn.**

### What You'll Learn
- `ping` — check if a server is reachable
- `curl` — talk to websites and APIs
- `open` — open things from Terminal
- `caffeinate` — keep your Mac awake
- How the internet works (the basic version)

---

## How the Internet Works (Quick Version)

Every website is just a computer somewhere in the world. When you type `google.com` in a browser, your Mac:

1. Looks up Google's **IP address** (like a phone number)
2. Connects to that computer
3. Asks for the page: `GET /`
4. Receives HTML text back
5. Renders it as the webpage you see

In Terminal, we can do steps 1-4 directly. No rendering needed.

---

## `ping` — Are You There?

`ping` sends a tiny message to a server and waits for a reply. Like knocking on a door:

```bash
ping -c 4 google.com
```

Output:
```
PING google.com (142.250.80.46): 56 data bytes
64 bytes from 142.250.80.46: icmp_seq=0 ttl=115 time=12.4 ms
...
--- google.com ping statistics ---
4 packets transmitted, 4 received, 0.0% packet loss
```

- `time=12.4 ms` — how long it took. Lower = faster.
- `0.0% packet loss` — all messages got through.

---

## `curl` — Talk to Websites

`curl` sends web requests and shows the response:

```bash
curl http://example.com
```

You'll see raw HTML!

### Get Just the Headers

```bash
curl -I https://www.apple.com
```

The `200` means success. Common codes:
- `200` — OK
- `301` or `302` — Redirect
- `404` — Not Found
- `403` — Forbidden
- `500` — Server Error

### Get a Fun Fact

```bash
curl -s https://catfact.ninja/fact
```

### Check Your IP Address

```bash
curl ifconfig.me
```

### Check a Website's Status

```bash
curl -s -o /dev/null -w "%{http_code}" https://google.com
```

Output: `200` — this checks status without downloading anything.

---

## `open` — Open Things from Terminal

```bash
open ~/Documents          # Open in Finder
open .                    # Open current folder in Finder
open https://nasa.gov     # Open in Safari
```

Open with a specific app:

```bash
open -a "TextEdit" playground/mission_09/network_log.txt
```

---

## `caffeinate` — Keep Your Mac Awake

```bash
caffeinate -t 3600    # Stay awake for 1 hour
```

Useful when running long scripts or downloads!

---

## Try It! — Quick Experiments

**Experiment 1:** Read the network log and find the suspicious IP:
```bash
cat playground/mission_09/network_log.txt
```

Which IP is flagged as suspicious? What did Agent NOVA recommend?

**Experiment 2:** Check the URLs list:
```bash
cat playground/mission_09/urls.txt
```

Try the cat fact URL:
```bash
curl -s https://catfact.ninja/fact
```

**Experiment 3:** Compare ping times to different places:
```bash
ping -c 3 google.com
ping -c 3 1.1.1.1
```

Which is faster?

**Experiment 4:** Check website status codes:
```bash
curl -s -o /dev/null -w "%{http_code}" http://httpbin.org/status/200
curl -s -o /dev/null -w "%{http_code}" http://httpbin.org/status/404
```

---

## Pro Tip — `curl` Progress Bar

When downloading large files, add `-#` to show a progress bar:

```bash
curl -# -O https://example.com/largefile.zip
```

Output:
```
######################################################## 100.0%
```

---

## Your Mission — Build an Internet Health Checker

**Step 1:** Study the network log:
```bash
cat playground/mission_09/network_log.txt
```

Identify:
- What network tests were run
- What was flagged as suspicious
- What the recommendation was

**Step 2:** Try the approved URLs:
```bash
curl -s https://catfact.ninja/fact
curl -s http://httpbin.org/ip
```

**Step 3:** Build your own network health checker script:
```bash
nano ~/network_check.sh
```

```bash
#!/bin/bash
# network_check.sh — TDA Network Health Checker

echo ""
echo "╔═══════════════════════════════════╗"
echo "║    TDA NETWORK HEALTH CHECKER     ║"
echo "╚═══════════════════════════════════╝"
echo ""

# Check internet access
echo "1. Checking internet connection..."
if ping -c 1 -W 3 8.8.8.8 > /dev/null 2>&1; then
    echo "   ✓ Internet: CONNECTED"
else
    echo "   ✗ Internet: NO CONNECTION"
    exit 1
fi

# Check DNS
echo ""
echo "2. Checking DNS..."
if ping -c 1 -W 3 google.com > /dev/null 2>&1; then
    echo "   ✓ DNS: Working"
else
    echo "   ✗ DNS: Not working"
fi

# Get your IP
echo ""
echo "3. Your public IP address..."
MY_IP=$(curl -s --max-time 5 ifconfig.me 2>/dev/null)
if [ -n "$MY_IP" ]; then
    echo "   Public IP: $MY_IP"
fi

# Ping speed test
echo ""
echo "4. Speed test (ping to Google)..."
PING=$(ping -c 4 google.com 2>/dev/null | tail -1 | awk -F'/' '{print $5}' | cut -d'.' -f1)
if [ -n "$PING" ]; then
    echo "   Average ping: ${PING}ms"
fi

echo ""
echo "Check complete!"
```

**Step 4:** Make it executable and run it:
```bash
chmod +x ~/network_check.sh
bash ~/network_check.sh
```

**Step 5:** Find the hidden code:
```bash
ls -la playground/mission_09/
cat playground/mission_09/.secret_code.txt
```

---

## Challenges

### Challenge 1 — Ping Race

Ping these 4 servers and report which is fastest:
- `google.com`
- `1.1.1.1`
- `8.8.8.8`
- `apple.com`

Use `ping -c 5 hostname` for each.

### Challenge 2 — The HTTP Codes Explorer

Use `curl -s -o /dev/null -w "%{http_code}"` to check:
1. `http://httpbin.org/status/200`
2. `http://httpbin.org/status/404`
3. `http://httpbin.org/status/403`
4. `http://httpbin.org/status/500`

What does each code mean?

### Challenge 3 — Download and Count

Use `curl` to get a random cat fact and count the characters:

```bash
curl -s https://catfact.ninja/fact | grep -o '"fact":"[^"]*"'
```

### Challenge 4 — Open Your Network Log

Write one command that opens `playground/mission_09/network_log.txt` in TextEdit using `open -a`.

---

## Solutions

Solutions are in the [solutions folder](solutions/README.md).

---

## Powers Unlocked

| Command | What It Does |
|---------|-------------|
| `ping -c 4 host` | Send exactly 4 pings |
| `curl url` | Fetch a URL and show the response |
| `curl -I url` | Show HTTP headers only |
| `curl -s url` | Silent mode (no progress output) |
| `curl -s -o /dev/null -w "%{http_code}" url` | Show only the HTTP status code |
| `open path` | Open file or folder in default app |
| `open url` | Open URL in default browser |
| `open -a "App" path` | Open with a specific app |
| `caffeinate -t 60` | Prevent sleep for 60 seconds |
| `ifconfig.me` | Service that returns your public IP |

### Vocabulary

- **IP address** — a number that identifies a computer on the network
- **DNS** — converts names like `google.com` to IP addresses
- **HTTP** — the language browsers and servers use
- **Latency** — how long a request takes (milliseconds). Lower = faster.
- **API** — a website designed to be used by programs, not browsers

---

*The internet is just computers talking to each other. Now you know how to join the conversation.*

*Ready for Mission 10?*
