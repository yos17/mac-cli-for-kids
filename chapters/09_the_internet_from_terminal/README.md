# CASE FILE #9 — The Digital Spy

**Terminal Detective Agency | Clearance Level: CYBER OPERATIVE**

---

## 🔍 MISSION BRIEFING

The Phantom has gone digital.

Agency intelligence has traced recent communications to the internet — encrypted contacts, suspicious endpoints, network traffic at unusual hours on unusual ports. The Phantom isn't just hiding offline anymore. They're coordinating with accomplices through web services, and they think the internet is their safe territory.

They've never met a detective who commands it from the terminal.

The `urls.txt` file in your case folder contains test endpoints to probe. The `api_endpoints.txt` file lists public APIs where you can practice your skills. And `network_log.txt`? That's fifty lines of captured network data. Somewhere in there is a suspicious IP address that keeps appearing — connecting to ports that no legitimate traffic uses. Your job is to find it, document it, and build the case.

Most people experience the internet through browsers — clicking, scrolling, waiting for pages to load. But the internet is fundamentally made of text: text requests, text responses, text data, text commands. Everything a browser does, you can do from Terminal. Faster, more precisely, and with complete visibility into what's actually happening.

Today you learn to talk to the internet directly. You'll probe servers, decode responses, analyze a network log for suspicious activity, and build an automated Internet Health Checker. You'll also fetch a random joke along the way — because even the best detectives need a laugh on a long case.

**Access your case files:**
```bash
cd playground/mission_09
```

---

## 📚 DETECTIVE TRAINING: The Internet from Terminal

### How the Internet Actually Works

Every website is just a computer somewhere in the world. A **server** — a computer specifically set up to respond to requests from other computers.

When you type `google.com` in a browser, here's the complete sequence of events:

1. **DNS Lookup** — Your Mac asks a Domain Name Server: "What's the IP address for `google.com`?" The DNS returns something like `142.250.80.46`. This is like looking up a phone number in a directory.

2. **TCP Connection** — Your Mac connects to that IP address on a specific **port** — port 443 for HTTPS (secure) or port 80 for HTTP (unencrypted). A port is like a door on a building; different services use different doors.

3. **HTTP Request** — Your Mac sends a text message to the server:
   ```
   GET / HTTP/1.1
   Host: google.com
   User-Agent: Mozilla/5.0 ...
   ```
   This says: "Please give me the homepage (`/`)."

4. **HTTP Response** — The server sends back a text response:
   ```
   HTTP/2 200 OK
   Content-Type: text/html
   ...
   <html>...</html>
   ```
   The `200` means success. The HTML follows.

5. **Browser Rendering** — The browser interprets the HTML and draws the visual page you see.

In Terminal, you do steps 1-4 directly. No browser. No rendering. Just the raw exchange of text — which is actually more useful for investigation purposes, because you see *everything*.

Understanding this sequence helps you understand why the tools in this mission work the way they do.

---

### `ping` — The Most Basic Network Test

`ping` sends a tiny test message (called an ICMP echo request) to a server and waits for a reply. The name comes from sonar — like a submarine sending a sound pulse and waiting for the echo back.

It answers two questions: "Is this server reachable?" and "How long does it take to get there?"

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

Press `Ctrl+C` to stop it. Without `-c`, ping runs forever.

**What each number means:**

- `142.250.80.46` — DNS resolved `google.com` to this IP address
- `icmp_seq=0` — this was the first ping (sequence number 0)
- `ttl=115` — Time To Live: how many network hops this packet can make before being discarded
- `time=12.4 ms` — **round-trip time** in milliseconds — the time for the message to go and come back
- `0.0% packet loss` — all messages got responses. High loss = bad or congested connection.

**Common `ping` flags:**

```bash
ping -c 4 google.com      # Send exactly 4 pings, then stop automatically
ping -c 3 192.168.1.1     # Ping your home router (check local network)
ping -c 1 -W 2 host       # Send 1 ping, wait max 2 seconds for response
```

**What ping times tell you:**

Physical distance matters. Light travels through fiber optic cables at about 2/3 the speed of light. You can actually estimate physical distances from ping times:

| Ping time | What it suggests |
|-----------|------------------|
| 1–10 ms | Same city or nearby data center |
| 10–50 ms | Same country |
| 50–100 ms | Same continent |
| 100–200 ms | Another continent |
| 200+ ms | Far side of the planet (e.g., US to Australia) |

This matters for detective work — if a suspect's server has very high latency, it might be hosted overseas to obscure jurisdiction.

**When ping gets no reply:**
- The server might be down
- You might have no internet connection
- The server's firewall blocks ping (many servers do this intentionally for security)
- The IP address doesn't exist

---

### `curl` — The Swiss Army Knife of Web Requests

`curl` stands for "**C**lient **URL**." It's a command that makes any kind of web request and shows you the raw response. This is how web browsers, mobile apps, and online services actually talk to servers — minus all the visual chrome.

`curl` is one of the most widely used commands in the world. Web developers use it constantly to test APIs. Security researchers use it to probe servers. System administrators use it in scripts. If you learn curl well, you have a skill that will be useful for the rest of your life.

---

#### Basic `curl` — Get a Page's Content

```bash
curl http://example.com
```

You'll see raw HTML — the actual source code that a browser interprets and renders into a visual page. This is the real internet, unfiltered. Browsers hide this from you; Terminal shows you everything.

Try a test service that returns information about your request:
```bash
curl https://httpbin.org/get
```

`httpbin.org` is a special testing service. When you send it a request, it responds with JSON describing exactly what you sent. It's like a mirror that shows you your own HTTP request. Perfect for learning.

---

#### `curl -I` — Headers Only (The Faster Way to Investigate)

Every HTTP response has two parts:
1. **Headers** — metadata about the response (status, type, size, date, server info)
2. **Body** — the actual content (HTML, JSON, image data, etc.)

`-I` sends a HEAD request — asking only for the headers, not the body:

```bash
curl -I https://example.com
```

Output:
```
HTTP/2 200
content-type: text/html; charset=UTF-8
date: Sun, 13 Apr 2026 12:00:00 GMT
server: EOS (las/AAC2)
content-length: 1256
```

The first line `HTTP/2 200` tells you the HTTP version and the **status code**. Getting headers without the body is fast — you're not downloading the whole page. Perfect for checking if a site is up, what server it runs, and whether it redirects.

---

#### HTTP Status Codes — The Response Language

Every HTTP response starts with a 3-digit **status code**. This is the server's summary of what happened with your request.

| Code | Name | What It Means |
|------|------|---------------|
| `200` | OK | Success — you got what you asked for |
| `201` | Created | A new resource was created |
| `204` | No Content | Success, but nothing to return |
| `301` | Moved Permanently | This URL has moved forever — follow the redirect |
| `302` | Found (Temporary Redirect) | Temporarily at another URL |
| `400` | Bad Request | Your request was malformed |
| `401` | Unauthorized | You need to authenticate first |
| `403` | Forbidden | Authenticated but not allowed |
| `404` | Not Found | Nothing at this URL |
| `429` | Too Many Requests | You're sending requests too fast |
| `500` | Internal Server Error | The server broke — not your fault |
| `502` | Bad Gateway | A gateway or proxy got a bad response |
| `503` | Service Unavailable | Server down for maintenance or overloaded |

**Test specific status codes with httpbin.org:**
```bash
curl -I https://httpbin.org/status/200    # Should return 200
curl -I https://httpbin.org/status/404    # Should return 404
curl -I https://httpbin.org/status/500    # Should return 500
curl -I https://httpbin.org/status/301    # Should return 301
```

`httpbin.org` will return exactly the status code you ask for — it's a testing sandbox.

The `2xx` codes are successes. `3xx` are redirects. `4xx` are client errors (your fault). `5xx` are server errors (their fault). That pattern helps you quickly understand any status code you encounter.

---

#### `curl -s` — Silent Mode

By default, curl shows a progress indicator mixed in with the response content. The `-s` (silent) flag suppresses that:

```bash
curl -s https://httpbin.org/get
```

Always use `-s` in scripts so the output is clean and only contains the actual response.

---

#### Getting Just the Status Code

This one-liner checks a website's status without downloading any content:

```bash
curl -s -o /dev/null -w "%{http_code}" https://google.com
```

Breaking it down:
- `-s` — silent, no progress bar
- `-o /dev/null` — discard the response body (`/dev/null` is a special "black hole" that throws away anything written to it)
- `-w "%{http_code}"` — write format: print only the HTTP status code

Output: `200`

This is how you check whether a website is up from a script — a single number tells you everything.

**Following redirects with `-L`:**
```bash
curl -sL -o /dev/null -w "%{http_code}" https://google.com
```

`-L` tells curl to follow redirects automatically. Without it, a `301` redirect would return `301` instead of `200`.

---

#### `curl -o` and `curl -O` — Saving Files

Download a file and save it with a custom name:
```bash
curl -o myfile.txt https://example.com/data.txt
```

Download and keep the original filename:
```bash
curl -O https://example.com/important_data.txt
```

`-o` (lowercase) = custom output name. `-O` (uppercase) = original name from URL.

Show a progress bar during large downloads:
```bash
curl -# -O https://example.com/bigfile.zip
```

Set a timeout so curl doesn't wait forever if a server is unresponsive:
```bash
curl --max-time 10 https://slow-site.example.com
```

---

#### APIs — Websites Designed for Programs

An **API** (Application Programming Interface) is a website built specifically to be used by programs and scripts, not by humans with browsers. Instead of returning HTML for browsers to render, APIs return structured data — usually **JSON**.

**JSON** (JavaScript Object Notation) looks like this:
```json
{
  "id": 42,
  "setup": "Why don't scientists trust atoms?",
  "punchline": "Because they make up everything!",
  "type": "general"
}
```

Key-value pairs, organized neatly. Easy for programs to parse. Easy enough for humans to read too.

APIs are everywhere. There are APIs for weather, jokes, cat facts, random numbers, public data, stock prices, astronomical events, and thousands of other things. Most public APIs are free.

**Fetch a random joke:**
```bash
curl "https://official-joke-api.appspot.com/random_joke"
```

**Fetch a cat fact:**
```bash
curl "https://catfact.ninja/fact"
```

**Fetch a random quote:**
```bash
curl "https://api.quotable.io/random"
```

**Check your own IP via an API:**
```bash
curl ifconfig.me
```

The APIs listed in your `api_endpoints.txt` case file are all free, public, and safe to use. They're your practice grounds.

---

#### Making JSON Readable with Python

API responses often come back as a single long line of JSON — technically correct but hard to read:
```
{"fact":"Cats sleep 12-16 hours per day.","length":33}
```

Pipe the output through Python's built-in JSON tool to make it pretty:
```bash
curl -s "https://catfact.ninja/fact" | python3 -m json.tool
```

Output:
```json
{
    "fact": "Cats sleep 12-16 hours per day.",
    "length": 33
}
```

The `|` (pipe) sends curl's output directly to python3 without saving to a file first. `-m json.tool` runs Python's json formatting module. This works for any JSON output from any source.

**Extract a specific field with Python:**
```bash
curl -s "https://catfact.ninja/fact" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['fact'])"
```

This prints just the fact text, not the whole JSON object. `json.load(sys.stdin)` reads the piped JSON, `d['fact']` extracts the specific field.

---

### `open` — Open Things from Terminal

`open` is Terminal's equivalent of double-clicking in Finder:

```bash
open ~/Documents              # Open folder in Finder
open ~/diary/journal.txt      # Open file in its default app
open https://nasa.gov         # Open URL in your default browser
open .                        # Open current directory in Finder
```

Open with a specific application:
```bash
open -a "Safari" https://nasa.gov           # Force Safari
open -a "TextEdit" ~/diary/journal.txt      # Force TextEdit
open -a "Notes"                             # Just open Notes app
```

`open` is useful at the end of scripts: you build or download something, then `open` it automatically. The user sees the result without having to navigate to it.

---

### `caffeinate` — Keep Your Mac Awake

Your Mac automatically goes to sleep when idle to save battery. `caffeinate` prevents that:

```bash
caffeinate
```

Your Mac won't sleep until you press `Ctrl+C`. Useful when:
- Running long download scripts
- Running tests that take a while
- Keeping the screen on during a presentation

**Stay awake for a specific duration:**
```bash
caffeinate -t 3600    # Stay awake for exactly 1 hour (3600 seconds)
caffeinate -t 1800    # Stay awake for 30 minutes
```

**Stay awake while a specific command runs:**
```bash
caffeinate -i curl -O https://big-download.com/huge-file.zip
```

The `-i` flag tells caffeinate "stay awake while this process runs." When curl finishes, caffeinate stops and Mac can sleep again. This is more elegant than guessing how long something takes.

---

### Your Public vs. Local IP Address

You actually have two IP addresses:

**Local IP** (`192.168.x.x` or `10.x.x.x`): Your address on your home network. Only visible to other devices on the same WiFi. Your router assigns this.

**Public IP**: Your address on the actual internet. The whole world can potentially reach this. Your ISP assigns this. Your router shares it with all devices in your home.

```bash
# Get your local IP
ifconfig | grep "inet " | grep -v 127.0.0.1

# Get your public IP
curl ifconfig.me
```

`127.0.0.1` is `localhost` — your computer talking to itself. Not a real network address.

---

### `ifconfig` — All Your Network Information

`ifconfig` shows detailed information about all your network interfaces:

```bash
ifconfig
```

This dumps a lot. To find just the useful part:
```bash
ifconfig | grep "inet " | grep -v 127.0.0.1
```

You'll see one or more IP addresses. The one starting with `192.168.` or `10.` is your local WiFi address. This tells you what network you're on.

---

### `grep` on Network Logs — The Investigation Skill

Network logs record connections: timestamp, source IP, destination IP, port, protocol. To a detective, they're evidence.

Your `network_log.txt` file contains 50 lines of captured network data. One IP address appears suspicious — `10.0.0.99` — showing up repeatedly on unusual ports.

```bash
# See the first 20 lines of the log
head -20 playground/mission_09/network_log.txt

# Search for ALL lines mentioning the suspicious IP
grep "10.0.0.99" playground/mission_09/network_log.txt

# Count how many times it appears
grep "10.0.0.99" playground/mission_09/network_log.txt | wc -l

# Look at the specific context around each match
grep -n "10.0.0.99" playground/mission_09/network_log.txt     # -n shows line numbers
```

**What to look for in a network log:**
- Unusual port numbers (common suspicious ports: 4444, 8888, 31337, 1337)
- Repeated connections at unusual hours
- High frequency connections from a single source
- Connections to IP ranges known to be problematic

**Find all unique IPs in a log:**
```bash
grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' playground/mission_09/network_log.txt | sort | uniq -c | sort -rn
```

Breaking this down:
- `grep -oE 'pattern'` — `-o` prints only the matching part, `-E` enables extended regex
- `[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+` — regex matching an IP address pattern
- `sort` — sort alphabetically (groups identical IPs together)
- `uniq -c` — count consecutive identical lines
- `sort -rn` — sort numerically in reverse (most frequent first)

This finds and counts every IP address in the log. The most frequent ones deserve attention.

---

### `tee` — Write to Both Screen and File

When running scripts, you sometimes want to see output AND save it to a file simultaneously. That's `tee`:

```bash
./internet_health_checker.sh | tee health_report.txt
```

Everything printed by the script appears on screen AND gets saved to `health_report.txt`. The name comes from a T-shaped pipe fitting that splits flow in two directions.

Perfect for generating reports you want to both review immediately and keep for records.

---

### Pro Tips — curl and Network Investigation

**1. Always add `--max-time` in scripts.**

Without a timeout, curl will wait forever if a server is slow or unreachable. In scripts, always limit the wait:
```bash
curl --max-time 10 https://example.com      # Give up after 10 seconds
curl -s --max-time 5 ifconfig.me            # Public IP, 5-second timeout
```

**2. Use `-s` (silent) in scripts but not during interactive exploration.**

`-s` removes the progress indicator and error messages — great for clean script output, but when you're exploring, leave it off so you see what's happening.

**3. Redirect errors separately from output.**

Some curl errors print to stderr (the error stream) rather than stdout (the normal output stream). Redirect errors to `/dev/null` to suppress them cleanly:
```bash
PUBLIC_IP=$(curl -s --max-time 5 ifconfig.me 2>/dev/null)
```

`2>/dev/null` redirects file descriptor 2 (stderr) to the black hole. Normal output (file descriptor 1, stdout) still comes through.

**4. Test APIs manually before scripting them.**

Before putting an API call in a script, test it manually in Terminal first:
```bash
curl -s "https://catfact.ninja/fact"
```

See the raw output. Understand the JSON structure. Know what fields exist. THEN write the script that parses it. Trying to debug an untested API call inside a script is much harder.

**5. `ping` might fail even when a site is up.**

Many servers block ICMP ping requests for security reasons. If `ping google.com` fails, that doesn't necessarily mean Google is down — try `curl -I https://google.com` to confirm. `curl` uses HTTP, which servers almost always respond to; ping uses ICMP, which many firewalls block.

**6. Check `curl`'s exit code in scripts.**

When curl fails (no network, server down, timeout), it exits with a non-zero code. You can check it:
```bash
if curl -s --max-time 5 https://example.com > /dev/null 2>&1; then
    echo "Site is UP"
else
    echo "Site is DOWN or unreachable"
fi
```

`> /dev/null 2>&1` silences both stdout and stderr. The `if` statement checks whether curl succeeded.

---

## 🧪 FIELD WORK

Time to start the digital investigation. Work through every experiment.

**Read the case briefing:**
```bash
cat playground/mission_09/case_briefing.txt
```

**Review the target URLs:**
```bash
cat playground/mission_09/urls.txt
```

**See the available API endpoints:**
```bash
cat playground/mission_09/api_endpoints.txt
```

**Preview the network log:**
```bash
head -20 playground/mission_09/network_log.txt
```

---

**Experiment 1:** Fetch a URL with curl.

```bash
curl https://httpbin.org/get
```

Read the JSON response. Notice it shows your IP address, the request headers your Mac automatically sent, and what URL you asked for. That's your Mac's HTTP fingerprint.

**Experiment 2:** Get headers only — fast site investigation.

```bash
curl -I https://example.com
curl -I https://httpbin.org/get
```

What status code do you see? What server software is running? What content type does it serve?

**Experiment 3:** Test HTTP status codes deliberately.

```bash
curl -I https://httpbin.org/status/200
curl -I https://httpbin.org/status/301
curl -I https://httpbin.org/status/404
curl -I https://httpbin.org/status/500
```

Watch the first line of each response — the status code changes exactly as requested. Now you've seen what each major category looks like.

**Experiment 4:** Check status code only (no content).

```bash
curl -s -o /dev/null -w "%{http_code}" https://google.com
curl -s -o /dev/null -w "%{http_code}" https://google.com/this-page-doesnt-exist
echo ""   # Add a newline after the code
```

The second URL should return `404`. That's how you tell if a specific page exists.

**Experiment 5:** Fetch a joke.

```bash
curl "https://official-joke-api.appspot.com/random_joke"
```

Now make it readable:
```bash
curl -s "https://official-joke-api.appspot.com/random_joke" | python3 -m json.tool
```

Can you find the `setup` and `punchline` fields? Run it 3 times — you should get different jokes.

**Experiment 6:** Fetch a cat fact and extract just the text.

```bash
# The whole JSON response
curl -s "https://catfact.ninja/fact"

# Just the fact text
curl -s "https://catfact.ninja/fact" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['fact'])"
```

**Experiment 7:** Get a random quote.

```bash
curl -s https://api.quotable.io/random | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['content'], '-', d['author'])"
```

**Experiment 8:** Check your public IP.

```bash
curl ifconfig.me
echo ""   # Add a newline after the IP
```

Write down what it returns — that's your current public IP address.

**Experiment 9:** See your local IP and compare.

```bash
ifconfig | grep "inet " | grep -v 127.0.0.1
```

The local IP looks like `192.168.x.x`. Your public IP from Experiment 8 will be completely different. Your router translates between them — this is called NAT (Network Address Translation).

**Experiment 10:** Compare ping times to different servers.

```bash
ping -c 3 google.com
echo "---"
ping -c 3 example.com
echo "---"
ping -c 3 1.1.1.1      # Cloudflare's DNS server
```

Which is fastest? Does the geographic distance make sense?

**Experiment 11:** Read and analyze the network log.

```bash
# Read the whole log
cat playground/mission_09/network_log.txt

# Count total lines
wc -l playground/mission_09/network_log.txt

# Find the suspicious IP
grep "10.0.0.99" playground/mission_09/network_log.txt

# Count its appearances
grep "10.0.0.99" playground/mission_09/network_log.txt | wc -l

# Look at port numbers associated with it
grep "10.0.0.99" playground/mission_09/network_log.txt
```

What patterns do you see? What ports is `10.0.0.99` connecting to? Are any of them unusual (4444, 8888)?

**Experiment 12:** Save curl output to a file and examine it.

```bash
curl -s "https://catfact.ninja/fact" -o playground/mission_09/cat_fact_response.txt
cat playground/mission_09/cat_fact_response.txt
```

You've captured a live API response to a local file. Good for archiving evidence.

**Experiment 13:** Check multiple URLs in a loop.

```bash
while IFS= read -r url; do
    # Skip comment lines and blank lines
    [[ $url == \#* ]] && continue
    [[ -z "$url" ]] && continue

    code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 5 "$url" 2>/dev/null)
    printf "%-40s → %s\n" "$url" "$code"
done < playground/mission_09/urls.txt
```

This loops through every URL in your case files and checks their status codes — automated recon!

---

## 🎯 MISSION: Build the Internet Health Checker

Write a script that does a complete network health check AND analyzes the suspicious network log.

Create the script:
```bash
nano playground/mission_09/internet_health_checker.sh
```

**Complete solution:**

```bash
#!/bin/zsh
# internet_health_checker.sh — Full network investigation tool
# Terminal Detective Agency — Mission 9

NETWORK_LOG="playground/mission_09/network_log.txt"
SUSPICIOUS_IP="10.0.0.99"

echo ""
echo "╔════════════════════════════════════════════╗"
echo "║   TERMINAL DETECTIVE AGENCY                ║"
echo "║   INTERNET HEALTH CHECKER v1.0             ║"
echo "╚════════════════════════════════════════════╝"
echo ""
echo "  Started: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

# ═══════════════════════════════════════════════
# PART 1: LOCAL NETWORK CHECK
# ═══════════════════════════════════════════════

echo "1. LOCAL NETWORK"
echo "   ─────────────────────────────────────────"

ROUTER_IP="192.168.1.1"
if ping -c 1 -W 2 "$ROUTER_IP" > /dev/null 2>&1; then
    echo "   [OK] Router reachable at $ROUTER_IP"
else
    echo "   [!!] Cannot reach router — check WiFi connection"
fi

# ═══════════════════════════════════════════════
# PART 2: INTERNET ACCESS
# ═══════════════════════════════════════════════

echo ""
echo "2. INTERNET ACCESS"
echo "   ─────────────────────────────────────────"

# 8.8.8.8 is Google's public DNS — good for testing basic connectivity
if ping -c 1 -W 3 8.8.8.8 > /dev/null 2>&1; then
    echo "   [OK] Internet working (reached 8.8.8.8)"
else
    echo "   [!!] Cannot reach internet"
fi

# Test DNS resolution — can we resolve names?
if ping -c 1 -W 3 google.com > /dev/null 2>&1; then
    echo "   [OK] DNS working (google.com resolves correctly)"
else
    echo "   [!!] DNS broken — can't translate domain names to IPs"
fi

# ═══════════════════════════════════════════════
# PART 3: IP ADDRESSES
# ═══════════════════════════════════════════════

echo ""
echo "3. YOUR IP ADDRESSES"
echo "   ─────────────────────────────────────────"

LOCAL_IP=$(ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | head -1)
echo "   Local IP:  ${LOCAL_IP:-not found}"

PUBLIC_IP=$(curl -s --max-time 5 ifconfig.me 2>/dev/null)
if [ -n "$PUBLIC_IP" ]; then
    echo "   Public IP: $PUBLIC_IP"
else
    echo "   Public IP: (unavailable — check internet)"
fi

# ═══════════════════════════════════════════════
# PART 4: PING SPEED TEST
# ═══════════════════════════════════════════════

echo ""
echo "4. CONNECTION LATENCY"
echo "   ─────────────────────────────────────────"

PING_RESULT=$(ping -c 4 google.com 2>/dev/null | tail -1)
PING_TIME=$(echo "$PING_RESULT" | awk -F'/' '{print $5}')

if [ -n "$PING_TIME" ]; then
    printf "   Average ping to Google: %sms\n" "$PING_TIME"
    PING_INT=${PING_TIME%.*}     # Strip decimal part for integer comparison

    if [ "$PING_INT" -lt 30 ]; then
        echo "   Rating: EXCELLENT"
    elif [ "$PING_INT" -lt 80 ]; then
        echo "   Rating: GOOD"
    elif [ "$PING_INT" -lt 150 ]; then
        echo "   Rating: ACCEPTABLE"
    else
        echo "   Rating: SLOW (possible network issues)"
    fi
else
    echo "   Ping test failed"
fi

# ═══════════════════════════════════════════════
# PART 5: CHECK URLS FROM CASE FILES
# ═══════════════════════════════════════════════

echo ""
echo "5. URL STATUS CHECK"
echo "   ─────────────────────────────────────────"

URL_FILE="playground/mission_09/urls.txt"
if [ -f "$URL_FILE" ]; then
    while IFS= read -r url; do
        [[ $url == \#* ]] && continue
        [[ -z "$url" ]] && continue

        code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 8 "$url" 2>/dev/null)
        if [ "$code" = "200" ] || [ "$code" = "301" ] || [ "$code" = "302" ]; then
            printf "   [UP]   %-35s HTTP %s\n" "$url" "$code"
        else
            printf "   [DOWN] %-35s HTTP %s\n" "$url" "$code"
        fi
    done < "$URL_FILE"
else
    echo "   URL file not found: $URL_FILE"
fi

# ═══════════════════════════════════════════════
# PART 6: FETCH RANDOM JOKE (MORALE BOOST)
# ═══════════════════════════════════════════════

echo ""
echo "6. AGENCY MORALE BOOST"
echo "   ─────────────────────────────────────────"

JOKE=$(curl -s --max-time 5 "https://official-joke-api.appspot.com/random_joke" 2>/dev/null)
if [ -n "$JOKE" ]; then
    SETUP=$(echo "$JOKE" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('setup',''))" 2>/dev/null)
    PUNCHLINE=$(echo "$JOKE" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('punchline',''))" 2>/dev/null)
    if [ -n "$SETUP" ]; then
        echo "   Q: $SETUP"
        echo "   A: $PUNCHLINE"
    else
        echo "   (API responded but joke parsing failed — but you're still great)"
    fi
else
    echo "   (Could not reach joke API)"
fi

# ═══════════════════════════════════════════════
# PART 7: NETWORK LOG THREAT ANALYSIS
# ═══════════════════════════════════════════════

echo ""
echo "7. NETWORK LOG ANALYSIS — THREAT DETECTION"
echo "   ─────────────────────────────────────────"

if [ -f "$NETWORK_LOG" ]; then
    TOTAL=$(wc -l < "$NETWORK_LOG")
    printf "   Log entries: %d\n" "$TOTAL"
    echo ""

    SUSPICIOUS_COUNT=$(grep -c "$SUSPICIOUS_IP" "$NETWORK_LOG" 2>/dev/null || echo 0)

    if [ "$SUSPICIOUS_COUNT" -gt 0 ]; then
        echo "   *** ALERT: SUSPICIOUS ACTIVITY DETECTED ***"
        echo ""
        printf "   Suspicious IP: %s\n" "$SUSPICIOUS_IP"
        printf "   Appearances:   %d times in the log\n" "$SUSPICIOUS_COUNT"
        echo ""
        echo "   Suspicious connection details:"
        grep "$SUSPICIOUS_IP" "$NETWORK_LOG" | while IFS= read -r line; do
            echo "     $line"
        done
        echo ""
        echo "   THREAT LEVEL: HIGH — ACTIVE INTRUSION SUSPECTED"
    else
        echo "   Suspicious IP ($SUSPICIOUS_IP): NOT FOUND"
        echo "   THREAT LEVEL: NOMINAL"
    fi
else
    echo "   [!!] Log file not found: $NETWORK_LOG"
fi

# ═══════════════════════════════════════════════
# FINAL SUMMARY
# ═══════════════════════════════════════════════

echo ""
echo "════════════════════════════════════════════"
echo "Health check complete: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""
```

**Make it executable and run it:**
```bash
chmod +x playground/mission_09/internet_health_checker.sh
./playground/mission_09/internet_health_checker.sh
```

**Save the output to a report file using `tee`:**
```bash
./playground/mission_09/internet_health_checker.sh | tee playground/mission_09/health_report.txt
```

Everything prints to screen AND gets saved to the file simultaneously.

**Review the saved report:**
```bash
cat playground/mission_09/health_report.txt
```

The investigation is documented. The suspicious IP is identified. The Phantom's digital trail has been found.

---

## 🏆 BONUS MISSIONS

### Bonus Mission 1 — The Ping Race

Ping five servers and record their average times. Write a loop to do it automatically:

```bash
#!/bin/zsh
echo "=== PING RACE ==="
echo ""

servers=("google.com" "amazon.com" "bbc.co.uk" "abc.net.au" "1.1.1.1")

for host in "${servers[@]}"; do
    result=$(ping -c 5 "$host" 2>/dev/null | tail -1 | awk -F'/' '{print $5}')
    printf "%-20s avg: %s ms\n" "$host" "${result:-unreachable}"
done
```

Which server is fastest? Does the geographic distance match your expectations? Cloudflare's `1.1.1.1` is known for being among the fastest DNS servers globally — does your data confirm that?

### Bonus Mission 2 — HTTP Status Code Explorer

Build a reference sheet by actually testing each status code:

```bash
#!/bin/zsh
echo "HTTP Status Code Reference"
echo "$(date)"
echo "──────────────────────────────────────────"

codes=(200 201 204 301 302 400 401 403 404 429 500 503)

for code in "${codes[@]}"; do
    response=$(curl -s -o /dev/null -w "%{http_code}" "https://httpbin.org/status/$code")
    printf "Requested %s → Got: %s\n" "$code" "$response"
done
```

All the 2xx, 3xx, 4xx, and 5xx codes — seen in action!

### Bonus Mission 3 — Automated Site Monitor

Write a script that checks a list of websites every 30 seconds and prints a status update, marking if any site goes down or comes back up between checks:

```bash
#!/bin/zsh
SITES=("google.com" "apple.com" "example.com" "httpbin.org")
declare -A previous_status

echo "=== Site Monitor Started ==="
echo "Press Ctrl+C to stop"
echo ""

while true; do
    echo "--- $(date '+%H:%M:%S') ---"
    for site in "${SITES[@]}"; do
        code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 5 "https://$site" 2>/dev/null)
        status="UP"
        [ "$code" != "200" ] && [ "$code" != "301" ] && status="DOWN ($code)"

        # Check if status changed from last check
        if [ "${previous_status[$site]}" != "" ] && [ "${previous_status[$site]}" != "$status" ]; then
            echo "  *** STATUS CHANGE: $site — was ${previous_status[$site]}, now $status ***"
        else
            printf "  %-20s %s\n" "$site" "$status"
        fi
        previous_status[$site]="$status"
    done
    echo ""
    sleep 30
done
```

### Bonus Mission 4 — Download and Analyze a Classic Book

Use curl to download a famous novel and analyze it:

```bash
# Download Pride and Prejudice from Project Gutenberg (public domain)
curl -s -O https://www.gutenberg.org/files/1342/1342-0.txt

# Count total words
python3 -c "
with open('1342-0.txt') as f:
    text = f.read()
words = text.split()
print(f'Total words: {len(words):,}')
"

# Find how many times the name Elizabeth appears
grep -ci "elizabeth" 1342-0.txt

# Find the 20 most common words
python3 -c "
from collections import Counter
with open('1342-0.txt') as f:
    text = f.read().lower()
words = [w.strip('.,!?;:\"()') for w in text.split()]
words = [w for w in words if len(w) > 4]   # Skip short words
common = Counter(words).most_common(20)
for word, count in common:
    print(f'{count:4d}  {word}')
"
```

That's 150 years of literary history, analyzed in seconds.

### Bonus Mission 5 — Daily Intelligence Report

Build a complete daily briefing script that pulls live data from the internet:

```bash
#!/bin/zsh
# daily_intelligence.sh — Live data briefing

REPORT_DIR="$HOME/intelligence_reports"
mkdir -p "$REPORT_DIR"
REPORT_FILE="$REPORT_DIR/report_$(date +%Y%m%d_%H%M%S).txt"

{
    echo "=== TERMINAL DETECTIVE AGENCY ==="
    echo "=== DAILY INTELLIGENCE REPORT ==="
    echo "Date: $(date '+%A, %B %d, %Y at %H:%M')"
    echo ""

    echo "--- RANDOM QUOTE ---"
    curl -s https://api.quotable.io/random | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    print(f'\"{d[\"content\"]}\"')
    print(f'— {d[\"author\"]}')
except:
    print('(Quote unavailable)')"

    echo ""
    echo "--- CAT FACT OF THE DAY ---"
    curl -s "https://catfact.ninja/fact" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    print(d['fact'])
except:
    print('(Cat fact unavailable)')"

    echo ""
    echo "--- TODAY'S JOKE ---"
    curl -s "https://official-joke-api.appspot.com/random_joke" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    print(f'Q: {d[\"setup\"]}')
    print(f'A: {d[\"punchline\"]}')
except:
    print('(Joke unavailable)')"

    echo ""
    echo "=== END OF REPORT ==="

} | tee "$REPORT_FILE"

echo ""
echo "Report saved: $REPORT_FILE"
```

`chmod +x daily_intelligence.sh` and run it every morning!

---

## 🔐 CODE PIECE UNLOCKED!

You've spoken directly to the internet — no browser, no clicking, no waiting. You probed servers, decoded HTTP responses, worked with live APIs, analyzed network logs, and traced a suspicious IP through fifty lines of captured traffic.

The internet is no longer something that happens to you. It's something you can investigate, command, and interrogate.

**Code Piece #9: DETECTIVE**

```bash
cat playground/mission_09/secret_code_piece.txt
```

Write it down carefully. The full secret code is almost fully assembled.

---

## ⚡ POWERS UNLOCKED

| Command | What It Does |
|---------|-------------|
| `ping hostname` | Check if a server is reachable and measure round-trip time |
| `ping -c 4 host` | Send exactly 4 pings, then stop |
| `ping -c 1 -W 2 host` | Ping once, timeout after 2 seconds |
| `curl url` | Fetch a URL and print the raw response |
| `curl -I url` | Fetch headers only (HEAD request — fast) |
| `curl -s url` | Silent mode — no progress bar, just content |
| `curl -O url` | Download file, keep original filename |
| `curl -o name url` | Download file, save with custom name |
| `curl -# -O url` | Download with a visual progress bar |
| `curl --max-time 5 url` | Abort after 5 seconds if no response |
| `curl -L url` | Follow HTTP redirects automatically |
| `curl -s -o /dev/null -w "%{http_code}" url` | Get only the HTTP status code |
| `curl ifconfig.me` | Get your public IP address |
| `curl url \| python3 -m json.tool` | Pretty-print JSON response |
| `curl -s url \| python3 -c "..."` | Parse JSON with a Python one-liner |
| `open path` | Open file or folder in default app |
| `open url` | Open URL in default browser |
| `open -a "App" file` | Open with a specific application |
| `caffeinate` | Prevent Mac from sleeping |
| `caffeinate -t 3600` | Stay awake for 1 hour (3600 seconds) |
| `caffeinate -i command` | Stay awake while a command runs, then stop |
| `ifconfig` | Show all network interface information |
| `ifconfig \| grep "inet "` | Show IP addresses only |
| `grep "IP" logfile` | Find all lines containing an IP address |
| `grep -c "pattern" file` | Count matching lines |
| `grep -n "pattern" file` | Show line numbers with matches |
| `grep -oE 'pattern' file` | Print only the matching text (not whole line) |
| `command \| tee filename` | Write output to both screen and a file |
| `head -20 file` | Show first 20 lines of a file |
| `/dev/null` | The "black hole" — discard anything written here |
| `sort \| uniq -c \| sort -rn` | Count unique values, sort by frequency |

### HTTP Status Code Reference

| Range | Category | Examples |
|-------|----------|---------|
| `2xx` | Success | 200 OK, 201 Created, 204 No Content |
| `3xx` | Redirect | 301 Moved Permanently, 302 Temporary Redirect |
| `4xx` | Client Error | 400 Bad Request, 401 Unauthorized, 403 Forbidden, 404 Not Found |
| `5xx` | Server Error | 500 Internal Server Error, 503 Service Unavailable |

### Detective Vocabulary

- **IP address** — a number that uniquely identifies a computer on a network (like a street address for computers)
- **DNS** — Domain Name System — translates `google.com` into IP addresses; the internet's phone book
- **HTTP** — HyperText Transfer Protocol — the text language browsers and servers use to communicate
- **HTTPS** — HTTP Secure — HTTP with encryption, so eavesdroppers can't read the traffic
- **Port** — a numbered channel on a server; different services use different ports (HTTP=80, HTTPS=443)
- **Latency** — round-trip time in milliseconds; lower is faster; determined by physical distance and network quality
- **API** — Application Programming Interface — a service designed to be called by programs, returns structured data
- **JSON** — JavaScript Object Notation — a text format for structured data using key-value pairs
- **curl** — a command-line tool for making web requests (Client URL)
- **Status code** — a 3-digit HTTP response code: 2xx=success, 3xx=redirect, 4xx=client error, 5xx=server error
- **Header** — metadata in an HTTP request or response (not the content body)
- **Packet loss** — percentage of ping requests that got no response; 0% is ideal
- **NAT** — Network Address Translation — your router maps your local IP to your public IP
- **Localhost** — `127.0.0.1` — your computer talking to itself; not a real network address
- **tee** — command that writes to both stdout (screen) and a file simultaneously

---

*The internet is just computers talking to each other using a shared language called HTTP. And now you know how to speak that language directly — no browser required.*

*Network engineers, security researchers, web developers, and system administrators use these exact tools every day. You have them now.*

*Ready for Mission 10?*
