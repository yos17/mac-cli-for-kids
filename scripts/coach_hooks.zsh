# Terminal Quest Coach hooks for zsh.
# Loaded only inside `./coach start` sessions.

if [[ -n "${TERMINAL_QUEST_COACH_HOOKS_LOADED:-}" ]]; then
    return 0
fi

export TERMINAL_QUEST_COACH_HOOKS_LOADED=1
export TERMINAL_QUEST_COACH_ENABLED="${TERMINAL_QUEST_COACH_ENABLED:-1}"
export TERMINAL_QUEST_COACH_MODE="${TERMINAL_QUEST_COACH_MODE:-always}"
export TERMINAL_QUEST_COACH_SAFETY="${TERMINAL_QUEST_COACH_SAFETY:-1}"
export TERMINAL_QUEST_PROVIDER="${TERMINAL_QUEST_PROVIDER:-auto}"
export TERMINAL_QUEST_STATE_DIR="${TERMINAL_QUEST_STATE_DIR:-$HOME/.terminal_quest}"

mkdir -p "$TERMINAL_QUEST_STATE_DIR" 2>/dev/null

typeset -g _TQ_COACH_LAST_CMD=""
typeset -g _TQ_COACH_LAST_CWD=""
typeset -g _TQ_COACH_LAST_TIME=""

_tq_coach_log_event() {
    local event_status="$1"
    local log="$TERMINAL_QUEST_STATE_DIR/coach_events.log"
    {
        print -r -- "---"
        print -r -- "time: $(date '+%Y-%m-%d %H:%M:%S')"
        print -r -- "cwd: $_TQ_COACH_LAST_CWD"
        print -r -- "status: $event_status"
        print -r -- "command: $_TQ_COACH_LAST_CMD"
    } >> "$log" 2>/dev/null
}

_tq_coach_is_risky_text() {
    local cmd="$1"
    [[ "$cmd" == *"rm -rf"* ]] && return 0
    [[ "$cmd" == *"rm -fr"* ]] && return 0
    [[ "$cmd" == sudo\ * || "$cmd" == *" sudo "* ]] && return 0
    [[ "$cmd" == *"chmod -R"* ]] && return 0
    [[ "$cmd" == *"chown -R"* ]] && return 0
    [[ "$cmd" == *"curl "* && "$cmd" == *"| sh"* ]] && return 0
    [[ "$cmd" == *"curl "* && "$cmd" == *"| bash"* ]] && return 0
    return 1
}

_tq_coach_preexec() {
    _TQ_COACH_LAST_CMD="$1"
    _TQ_COACH_LAST_CWD="$PWD"
    _TQ_COACH_LAST_TIME="$(date +%s)"

    if [[ "$TERMINAL_QUEST_COACH_ENABLED" == "1" ]] && _tq_coach_is_risky_text "$1"; then
        print -r -- ""
        print -P "%F{red}Coach safety note:%f this command looks powerful. If it changes files, check pwd first."
        print -r -- ""
    fi
}

_tq_coach_precmd() {
    local last_status="$?"
    local cmd="$_TQ_COACH_LAST_CMD"
    local cwd="$_TQ_COACH_LAST_CWD"

    [[ -z "$cmd" ]] && return 0
    _tq_coach_log_event "$last_status"
    _TQ_COACH_LAST_CMD=""

    [[ "$TERMINAL_QUEST_COACH_ENABLED" != "1" ]] && return 0
    [[ "$cmd" == coach || "$cmd" == coach\ * ]] && return 0
    [[ "$cmd" == exit || "$cmd" == exit\ * ]] && return 0
    [[ "$cmd" == clear ]] && return 0
    [[ "$TERMINAL_QUEST_COACH_MODE" == "errors" && "$last_status" -eq 0 ]] && return 0

    local reply
    reply="$("$TERMINAL_QUEST_ROOT/coach" once \
        --provider "$TERMINAL_QUEST_PROVIDER" \
        --command "$cmd" \
        --status "$last_status" \
        --cwd "$cwd" 2>/dev/null)"

    if [[ -n "$reply" ]]; then
        print -r -- ""
        print -P "%F{cyan}Coach:%f $reply"
        print -r -- ""
    fi
}

coach() {
    local action="${1:-status}"
    case "$action" in
        on)
            export TERMINAL_QUEST_COACH_ENABLED=1
            print -P "%F{green}Coach feedback is on.%f"
            ;;
        off)
            export TERMINAL_QUEST_COACH_ENABLED=0
            print -P "%F{yellow}Coach feedback is paused. Type 'coach on' to resume.%f"
            ;;
        status)
            print -P "%F{cyan}Terminal Quest Coach%f"
            print -r -- "  enabled:  $TERMINAL_QUEST_COACH_ENABLED"
            print -r -- "  provider: $TERMINAL_QUEST_PROVIDER"
            print -r -- "  mode:     $TERMINAL_QUEST_COACH_MODE"
            print -r -- "  safety:   $TERMINAL_QUEST_COACH_SAFETY"
            print -r -- "  events:   $TERMINAL_QUEST_STATE_DIR/coach_events.log"
            ;;
        provider)
            if [[ -z "${2:-}" ]]; then
                print -r -- "Current provider: $TERMINAL_QUEST_PROVIDER"
                print -r -- "Usage: coach provider claude|codex|none|auto"
                return 0
            fi
            case "$2" in
                claude|codex|none|auto)
                    export TERMINAL_QUEST_PROVIDER="$2"
                    print -P "%F{green}Coach provider set to $2.%f"
                    ;;
                *)
                    print -P "%F{red}Unknown provider:%f $2"
                    return 1
                    ;;
            esac
            ;;
        mode)
            if [[ -z "${2:-}" ]]; then
                print -r -- "Current mode: $TERMINAL_QUEST_COACH_MODE"
                print -r -- "Usage: coach mode always|errors"
                return 0
            fi
            case "$2" in
                always|errors)
                    export TERMINAL_QUEST_COACH_MODE="$2"
                    print -P "%F{green}Coach mode set to $2.%f"
                    ;;
                *)
                    print -P "%F{red}Unknown mode:%f $2"
                    return 1
                    ;;
            esac
            ;;
        *)
            command "$TERMINAL_QUEST_ROOT/coach" "$@"
            ;;
    esac
}

_tq_confirm() {
    local message="$1"
    print -P "%F{yellow}Coach safety:%f $message"
    print -n "Run it anyway? [y/N] "
    local answer
    read -r answer
    [[ "$answer" == "y" || "$answer" == "Y" ]]
}

_tq_path_inside_playground() {
    local path="$1"
    local abs
    if [[ "$path" == /* ]]; then
        abs="$path"
    else
        abs="$PWD/$path"
    fi
    [[ "$abs" == "$TERMINAL_QUEST_ROOT/playground"* ]]
}

rm() {
    if [[ "$TERMINAL_QUEST_COACH_SAFETY" == "1" ]]; then
        local arg recursive_force=0 outside=0
        for arg in "$@"; do
            [[ "$arg" == -* && "$arg" == *r* && "$arg" == *f* ]] && recursive_force=1
            [[ "$arg" == -* ]] && continue
            _tq_path_inside_playground "$arg" || outside=1
        done
        if [[ "$recursive_force" == "1" ]]; then
            _tq_confirm "rm with recursive force can delete a whole folder tree." || return 1
        elif [[ "$outside" == "1" && "$PWD" != "$TERMINAL_QUEST_ROOT/playground"* ]]; then
            _tq_confirm "you are deleting outside the Terminal Quest playground." || return 1
        fi
    fi
    command rm "$@"
}

sudo() {
    if [[ "${TERMINAL_QUEST_ALLOW_SUDO:-0}" != "1" ]]; then
        print -P "%F{red}Coach safety:%f sudo is blocked in coach mode. These lessons should not need administrator power."
        print -r -- "If a parent really wants to allow it for this session: export TERMINAL_QUEST_ALLOW_SUDO=1"
        return 1
    fi
    command sudo "$@"
}

chmod() {
    if [[ "$TERMINAL_QUEST_COACH_SAFETY" == "1" ]]; then
        local arg risky=0 outside=0
        for arg in "$@"; do
            [[ "$arg" == "-R" || "$arg" == *"000"* ]] && risky=1
            [[ "$arg" == -* || "$arg" == [0-7][0-7][0-7] ]] && continue
            _tq_path_inside_playground "$arg" || outside=1
        done
        if [[ "$risky" == "1" ]]; then
            _tq_confirm "that chmod can remove access or affect many files." || return 1
        elif [[ "$outside" == "1" && "$PWD" != "$TERMINAL_QUEST_ROOT/playground"* ]]; then
            _tq_confirm "you are changing permissions outside the playground." || return 1
        fi
    fi
    command chmod "$@"
}

chown() {
    if [[ "$TERMINAL_QUEST_COACH_SAFETY" == "1" ]]; then
        _tq_confirm "chown changes file ownership and is not needed for the lessons." || return 1
    fi
    command chown "$@"
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec _tq_coach_preexec
add-zsh-hook precmd _tq_coach_precmd

print -r -- ""
print -P "%F{cyan}Terminal Quest Coach is watching this session.%f Type 'coach status', 'coach off', or 'exit'."
print -r -- ""
