export PATH=$PATH:$HOME/go/bin
export PATH=~/.opencode/bin:$PATH

source <(ng completion script) # Angular CLI autocompletion

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
