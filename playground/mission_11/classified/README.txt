================================================================
         CLASSIFIED MESSAGES — DECRYPTION REQUIRED
         Clearance Level: DETECTIVE TRAINEE
================================================================

These three files contain intercepted messages.
They were encoded using Base64 before transmission.

Base64 is a way of converting text into a string of letters and
numbers that looks like gibberish but can be decoded easily.
It's not truly "secret" — it's more like a simple disguise.
Real encryption (like AES-256) is MUCH stronger. But Base64 is
great for learning the concept.

--- HOW TO DECODE ---

Use the `base64` command with the `-d` flag (on Mac):

  base64 -d message_alpha.enc

Or pipe the file's contents into base64:

  cat message_alpha.enc | base64 -d

(On Linux, the flag is `--decode` instead of `-d` — both work on Mac!)

--- DECODE ALL THREE ---

  base64 -d message_alpha.enc
  base64 -d message_beta.enc
  base64 -d message_gamma.enc

--- WHAT WILL YOU FIND? ---

Three intercepted messages from an ongoing investigation.
Each one reveals a piece of a bigger puzzle.

Once you've decoded them all, you'll know:
  1. Where a suspect was spotted
  2. Where stolen data is hidden
  3. The status of a deep cover agent

--- HOW TO ENCODE YOUR OWN MESSAGE ---

Want to encode something? Try:

  echo -n "Your secret message here" | base64

The `-n` flag means "no newline at the end" — important for
getting a clean encoding without an extra character.

Good luck, Decoder!

================================================================
