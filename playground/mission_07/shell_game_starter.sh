#!/bin/bash
# Mission 07 starter: a tiny shell script game.
#
# Run:
#   bash shell_game_starter.sh

set -u

secret_number=$((RANDOM % 10 + 1))
tries_left=3

echo "Number Lock"
echo "I picked a number from 1 to 10."
echo "You have 3 tries to unlock the case."
echo ""

while [ "$tries_left" -gt 0 ]; do
    printf "Guess: "
    read -r guess

    if [ "$guess" = "$secret_number" ]; then
        echo "Unlocked. Case file opened."
        exit 0
    fi

    tries_left=$((tries_left - 1))

    if [ "$tries_left" -gt 0 ]; then
        echo "Not yet. Tries left: $tries_left"
    fi
done

echo "Locked. The number was $secret_number."
echo ""
echo "TODO:"
echo "  Add warmer/colder hints, a score, or a secret message."
