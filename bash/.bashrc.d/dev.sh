# add dev tools to env if exists

if [ -d "$HOME/go/bin" ]; then
  export PATH="$PATH:$HOME/go/bin"
fi

if [ -d "$HOME/.opencode/bin" ]; then
  export PATH="$HOME/.opencode/bin:$PATH"
fi

# Angular CLI autocomplete
# command -v ng >/dev/null 2>&1 && source <(ng completion script)

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  . "$NVM_DIR/nvm.sh"
fi
if [ -s "$NVM_DIR/bash_completion" ]; then
  . "$NVM_DIR/bash_completion"
fi

# Rust / Cargo
if [ -s "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi
