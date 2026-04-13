#!/bin/zsh
# Mission 7: Auto-letter generator
# TODO: Complete this script!

NAMES_FILE="names.txt"
TEMPLATE_FILE="template.txt"

# Create the output folder if it doesn't exist yet
mkdir -p letters

# Read each name and generate a letter
while IFS= read -r agent_name; do
    echo "Generating letter for: $agent_name"
    # TODO: Use sed to replace AGENT_NAME with $agent_name
    # TODO: Save to a file named after the agent
    #
    # HINT: To build a filename from the agent name, you can do:
    #   file_name=$(echo "$agent_name" | tr ' ' '_' | tr '[:upper:]' '[:lower:]')
    #   This turns "Agent Rivera" into "agent_rivera"
    #
    # HINT: Chain multiple sed commands like this:
    #   sed 's/THING1/replacement1/' file.txt | sed 's/THING2/replacement2/'
    #
    # HINT: Get today's date like this:
    #   TODAY=$(date +"%B %d, %Y")

done < "$NAMES_FILE"

echo "Done! Check the letters/ folder."
