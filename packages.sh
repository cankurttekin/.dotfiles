#!/usr/bin/env bash
set -e

# read package list
PACKAGE_FILE="packages"

if [[ ! -f "$PACKAGE_FILE" ]]; then
  echo "Package list '$PACKAGE_FILE' not found."
  exit 1
fi

mapfile -t PACKAGES < "$PACKAGE_FILE"

# detect distro
detect_distro() {
  if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    echo "$ID"
  else
    echo "unknown"
  fi
}

DISTRO=$(detect_distro)
echo "detected distro: $DISTRO"

# install packages
install_packages() {
  case "$DISTRO" in
    debian|ubuntu)
      sudo apt update
      sudo apt install -y "${PACKAGES[@]}"
      ;;
    fedora)
      sudo dnf install -y "${PACKAGES[@]}"
      ;;
    *)
      echo "unsupported or unknown distro: $DISTRO"
      exit 1
      ;;
  esac
}

install_packages

echo "all packages installed successfully!"
