# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# my bashrcs in .bashrc.d
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

PS1='$( \
  if git rev-parse --is-inside-work-tree &>/dev/null; then \
    status=""; \
    if ! git diff --quiet --ignore-submodules --; then \
      status="\[\033[01;33m\]"; # yellow - local changes
    elif [ "$(git rev-list --count --left-only @{u}...HEAD 2>/dev/null)" -gt 0 ]; then \
      status="\[\033[01;32m\]"; # green - ahead
    elif [ "$(git rev-list --count --right-only @{u}...HEAD 2>/dev/null)" -gt 0 ]; then \
      status="\[\033[01;31m\]"; # red - behind
    else \
      status="\[\033[01;34m\]"; # blue - clean
    fi; \
    echo -n "$status"; \
  else echo -n "\[\033[01;34m\]"; fi \
) ⟶ \W \[\033[01;32m\]$( \
  git rev-parse --is-inside-work-tree &>/dev/null && \
  git symbolic-ref --quiet HEAD 2>/dev/null | sed "s|refs/heads/|git:\[\033[01;33m\](|;s|$|)\[\033[00m\]|" || echo "" \
)\[\033[00m\]\$ '

set -o vi

export EDITOR='nvim'
export VISUAL='nvim'
export HISTSIZE=10000
export HISTIGNORE="ls:ps:history"
export HISTTIMEFORMAT="[%d-%m-%Y %T] "
#HISTCONTROL=ignoredups

eval "$(fzf --bash)"

alias fuz='nvim $(fzf --preview="bat --color=always --style=numbers {}")'
alias vim="nvim"
alias projects="cd ~/Documents/projects"
alias speedtest="wget http://st-ankara-1.turksatkablo.com.tr:8080/download?size=51200000 -O /dev/null"
alias whoami="whoami && curl ident.me && echo"
alias rm="rm -i"
