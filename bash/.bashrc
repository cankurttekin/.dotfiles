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
alias cim="vim"
alias bim="vim"

alias :q="exit"

#repeat the last command with sudo
alias pls='sudo $(history -p !!)' 

alias untar='tar -zxvf ' 

extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"   ;;
      *.tar.gz)    tar xzf "$1"   ;;
      *.tar.xz)    tar xf "$1"    ;;
      *.bz2)       bunzip2 "$1"   ;;
      *.rar)       unrar x "$1"   ;;
      *.gz)        gunzip "$1"    ;;
      *.tar)       tar xf "$1"    ;;
      *.tbz2)      tar xjf "$1"   ;;
      *.tgz)       tar xzf "$1"   ;;
      *.zip)       unzip "$1"     ;;
      *.7z)        7z x "$1"      ;;
      *) echo "Can't extract '$1'." ;;
    esac
  else
    echo "'$1' is not a valid file."
  fi
}

weather() { curl -s "wttr.in/${1:-Ankara}?format=4"; }
alias ytmp="yt-dlp -t mp3 "

# cd up x
up() { cd $(eval printf '../'%.0s {1..$1}); }

alias whoami="whoami && curl ident.me && echo"
alias speedtest="wget http://st-ankara-1.turksatkablo.com.tr:8080/download?size=51200000 -O /dev/null"
alias fuz='nvim $(fzf --preview="bat --color=always --style=numbers {}")'
#alias rm="rm -i"

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
