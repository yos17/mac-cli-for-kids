# Mission 12 — Solutions

## Challenge 1 — Add a Calculator

Add to `mybot.sh` inside the main `case` block:

```bash
8)
    echo ""
    echo "  Enter a math expression (e.g., 5 * 7 or 100 / 4):"
    read math_expr
    result=$(echo "$((math_expr))" 2>/dev/null)
    if [ $? -eq 0 ]; then
        echo -e "  ${GREEN}Result: $result${NC}"
    else
        echo -e "  ${RED}Could not calculate that. Try something like: 5 + 3${NC}"
    fi
    ;;
```

And add to the menu:
```bash
echo -e "  ${YELLOW}8.${NC} Quick Calculator"
```

---

## Challenge 2 — Weather Widget

In `modules/internet.sh`, add after `check_internet()`:

```bash
get_weather() {
    echo "Which city?"
    read city
    echo ""
    curl -s "wttr.in/${city}?format=3" 2>/dev/null || echo "  Could not get weather. Check your internet."
    echo ""
}
```

In `mybot.sh`, add to the menu:
```bash
echo -e "  ${YELLOW}9.${NC} Weather"
```

And in the case statement:
```bash
9) get_weather ;;
```

---

## Challenge 3 — Quote of the Day

Add to `mybot.sh` or a new module:

```bash
do_quote() {
    echo ""
    echo -e "  ${PURPLE}Quote of the moment:${NC}"
    RESULT=$(curl -s --max-time 5 "https://api.quotable.io/random" 2>/dev/null)
    if [ -n "$RESULT" ]; then
        echo "$RESULT" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    print('  \"' + data['content'] + '\"')
    print('  — ' + data['author'])
except:
    print('  Could not parse quote.')
" 2>/dev/null
    else
        echo "  Could not fetch quote (check your internet connection)"
    fi
    echo ""
}
```

---

## Challenge 4 — Make It Your Own

### Example: Random Dictionary Word

```bash
do_random_word() {
    WORD=$(grep "." /usr/share/dict/words | sort -R | head -1)
    echo ""
    echo -e "  ${CYAN}Random word of the moment: ${BOLD}$WORD${NC}"
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
    echo "  3. Clear completed (delete file)"
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

The best solution is whatever makes you open MyBot every day. Make it yours!
