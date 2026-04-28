# Mission 12 — Solutions

## Challenge 1 — Add a Quick Calculator

Add a function:

```bash
do_calculator() {
    echo ""
    echo "Enter a math expression (e.g. 5 * 7 or 100 / 4):"
    read expr
    result=$(echo "$((expr))" 2>/dev/null)

    if [ $? -eq 0 ]; then
        echo -e "  ${GREEN}Result: $result${NC}"
    else
        echo -e "  ${RED}Could not calculate that. Try something like: 5 + 3${NC}"
    fi
    echo ""
}
```

Add to the menu:

```bash
echo -e "  ${YELLOW}9.${NC} Quick Calculator"
```

Add to the main `case` block:

```bash
9) do_calculator ;;
```

If option `9` is already used in your version, use the next free number. The important part is that the menu number and the `case` number match.

---

## Challenge 2 — Weather Widget

Improve `get_weather` so it asks about the full forecast:

```bash
get_weather() {
    echo "Which city do you want the weather for?"
    read city
    echo ""

    echo -e "${CYAN}Weather for $city:${NC}"
    curl -s "wttr.in/${city}?format=3" 2>/dev/null || echo "  Could not fetch weather."
    echo ""

    echo "Show full 3-day forecast? (y/n)"
    read full
    if [ "$full" = "y" ] || [ "$full" = "Y" ]; then
        curl -s "wttr.in/${city}"
    fi

    echo ""
}
```

---

## Challenge 3 — Quote of the Day

Add a function using the GitHub Zen endpoint from Mission 9:

```bash
do_quote() {
    echo ""
    echo -e "  ${PURPLE}Quote of the day:${NC}"
    curl -s --max-time 5 https://api.github.com/zen 2>/dev/null || echo "  Could not fetch a quote."
    echo ""
}
```

Add to the menu:

```bash
echo -e "  ${YELLOW}10.${NC} Quote of the Day"
```

Add to the main `case` block:

```bash
10) do_quote ;;
```

Use a different number if `10` is already taken.

---

## Challenge 4 — Make It Yours

### Example: Random Dictionary Word

```bash
do_random_word() {
    WORD=$(grep "." /usr/share/dict/words | sort -R | head -1)
    echo ""
    echo -e "  ${CYAN}Random word: ${BOLD}$WORD${NC}"
    say -v "$MY_VOICE" "Your random word is $WORD" &
    echo ""
}
```

### Example: Simple To-Do List

```bash
TODO_FILE="$HOME/.mybot_todo.txt"

todo_menu() {
    echo ""
    echo -e "${PURPLE}=== TO-DO LIST ===${NC}"
    echo "  1. Add item"
    echo "  2. View all items"
    echo "  3. Clear list"
    echo "  b. Back"
    echo ""
    read todo_choice

    case "$todo_choice" in
        1)
            echo "What do you need to do?"
            read item
            echo "[ ] $item" >> "$TODO_FILE"
            echo -e "  ${GREEN}Added!${NC}"
            ;;
        2)
            if [ -f "$TODO_FILE" ]; then
                cat -n "$TODO_FILE"
            else
                echo "  No items yet!"
            fi
            ;;
        3)
            rm -f "$TODO_FILE"
            echo -e "  ${GREEN}To-do list cleared!${NC}"
            ;;
        b|B) return ;;
    esac
}
```

The best solution is whatever makes you open MyBot again.
