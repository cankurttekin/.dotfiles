if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

RESET="\[\e[0m\]"
BLUE="\[\e[34m\]"
CYAN="\[\e[36m\]"
YELLOW="\[\e[33m\]"
GREEN="\[\e[32m\]"
MAGENTA="\[\e[35m\]"

parse_git() {
  git rev-parse --is-inside-work-tree &>/dev/null || return

  local branch ahead behind arrows dirty
  branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
  [ -z "$branch" ] && branch=":unknown"

  ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null || echo 0)
  behind=$(git rev-list --count HEAD..@{u} 2>/dev/null || echo 0)
  [ "$ahead" -gt 0 ] && arrows="↑$ahead"
  [ "$behind" -gt 0 ] && arrows="${arrows}↓$behind"

  git diff --quiet --ignore-submodules HEAD &>/dev/null || dirty="✚"
  [ -z "$dirty" ] && dirty="✔"

  echo " ${MAGENTA}git:${RESET}(${CYAN}${branch}${RESET}${YELLOW}${arrows:+$arrows}${RESET}|${GREEN}${dirty}${RESET})"
}

get_dir() {
  if [ "$PWD" = "$HOME" ]; then
    echo "~"
  else
    echo "${PWD##*/}"
  fi
}

PROMPT_COMMAND='PS1=" ${BLUE}⤳ $(get_dir)${RESET}$(parse_git) \$ "'

set -o vi

export EDITOR='nvim'
export VISUAL='nvim'
export HISTSIZE=10000
export HISTIGNORE="ls:ps:history"
export HISTTIMEFORMAT="%s "
#export HISTCONTROL=ignoredups

eval "$(fzf --bash)"

bind 'TAB:menu-complete'
bind 'set show-all-if-ambiguous on'

alias vim="nvim"
alias whoami="whoami && curl ident.me && echo"
alias speedtest="wget http://st-ankara-1.turksatkablo.com.tr:8080/download?size=51200000 -O /dev/null"
alias fuz='nvim $(fzf --preview="bat --color=always --style=numbers {}")'
#alias rm="rm -i"
