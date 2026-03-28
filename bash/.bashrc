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

# this is not the best way to do this, its slow and expensive.
# but it works for now
parse_git() {
  git rev-parse --is-inside-work-tree &>/dev/null || return

  local branch ahead behind arrows dirty
  branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
  [ -z "$branch" ] && branch=":unknown"

  ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null || echo 0)
  behind=$(git rev-list --count HEAD..@{u} 2>/dev/null || echo 0)
  [ "$ahead" -gt 0 ] && arrows="↑$ahead"
  [ "$behind" -gt 0 ] && arrows="${arrows}↓$behind"

  git diff --quiet --ignore-submodules HEAD &>/dev/null || dirty="+"
  [ -z "$dirty" ] && dirty="✓"

  echo " ${MAGENTA}git:${RESET}(${CYAN}${branch}${RESET}${YELLOW}${arrows:+$arrows}${RESET}|${GREEN}${dirty}${RESET})"
}

get_dir() {
  if [ "$PWD" = "$HOME" ]; then
    echo "~"
  else
    echo "${PWD##*/}"
  fi
}

PROMPT_COMMAND='PS1=" ${BLUE}$(get_dir)${RESET}$(parse_git) \$ "'

set -o vi

# default programs
export TERMINAL='foot'
export EDITOR='nvim'
export BROWSER='librewolf'
export VISUAL='nvim'

export HISTSIZE=10000
export HISTIGNORE="ls:ps:history"
export HISTTIMEFORMAT="%s "
export HISTCONTROL=ignoredups

eval "$(fzf --bash)"

#bind 'TAB:menu-complete'
#bind 'set show-all-if-ambiguous on'

alias vim="nvim"
alias cim="vim"
alias bim="vim"
alias :q="exit"
alias pls='sudo $(history -p !!)' #repeat the last command with sudo
alias untar='tar -zxvf ' 
alias whoami="whoami && curl ident.me && echo"
alias speedtest="wget http://st-ankara-1.turksatkablo.com.tr:8080/download?size=51200000 -O /dev/null"
alias fuz='nvim $(fzf --preview="bat --color=always --style=numbers {}")'
#alias rm="rm -i"
alias ytmp="yt-dlp -t mp3 "

weather() { curl -s "wttr.in/${1:-Ankara}?format=4"; }

# cd up x
up() { cd $(eval printf '../'%.0s {1..$1}); }

# ctrl+d to exit shell but not from tmux session
function trap_exit_tmux {
    if [ -n "$TMUX" ]; then
        # check if there is exactly one window and one pane
        if [ $(tmux list-windows 2>/dev/null | wc -l) -eq 1 ] && [ $(tmux list-panes 2>/dev/null | wc -l) -eq 1 ]; then
            # switch to the default session if the current one is the last
            tmux switch-client -t default 2>/dev/null || tmux switch-client -l
        fi
    fi
}
trap trap_exit_tmux EXIT

bind -x '"\C-f": fuzzy-find'
