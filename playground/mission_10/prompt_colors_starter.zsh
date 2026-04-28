# Mission 10 starter: prompt colors and useful aliases.
#
# Paste the parts you like into ~/.zshrc, then run:
#   source ~/.zshrc

autoload -U colors && colors

# Prompt format:
#   Joanna mission_10 $
PROMPT='%F{magenta}Joanna%f %F{cyan}%1~%f %F{yellow}$%f '

# Safer file commands while learning.
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Fast navigation.
alias hq='cd ~/mac-cli-for-kids'
alias missions='cd ~/mac-cli-for-kids/playground'

# Helpful views.
alias ll='ls -lhG'
alias la='ls -lahG'
