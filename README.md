## Creating Symlinks using GNU Stow
```stow bash git tmux nvim sway wofi foot```

## Installing [`packages`](./packages)
- bash:
```package-installer.sh```

- ansible:
```ansible-playbook -K install-packages.yml```

- or if you are sane person(probably listed package names are same for debian based distros too but not sure):
```sudo dnf install -y $(<packages)```

##
This repository contains my personal configurations for essential tools i use daily. 
I prefer minimal configurations focused on speed and low resource usage. 
Constantly evolving as I discover more efficient or elegant ways to interact with my system so it's never finished.
