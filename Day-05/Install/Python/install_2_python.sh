#!/usr/bin/env bash

set -e

echo "🔍 Detecting OS and installing Python..."

# Detect OS
OS=$(uname -s)

# Function: Install on Ubuntu/Debian
install_ubuntu() {
  echo "📦 Installing Python on Ubuntu/Debian..."
  sudo apt update -y
  sudo apt install -y python3 python3-pip python3-venv
}

# Function: Install on CentOS/RHEL
install_centos() {
  echo "📦 Installing Python on CentOS/RHEL..."
  sudo yum install -y python3 python3-pip
}

# Function: Install on macOS
install_macos() {
  echo "🍏 Installing Python on macOS..."
  if ! command -v brew &>/dev/null; then
    echo "📦 Homebrew not found. Installing Homebrew first..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  brew install python
}

# Function: Install on Windows (WSL)
install_wsl() {
  echo "🪟 Detected Windows WSL (Linux)..."
  install_ubuntu
}

# Main logic
case "$OS" in
  "Linux")
    # Detect distribution
    if [ -f /etc/os-release ]; then
      . /etc/os-release
      case "$ID" in
        ubuntu|debian)
          install_ubuntu
          ;;
        centos|rhel|rocky|almalinux)
          install_centos
          ;;
        *)
          echo "⚠️ Unsupported Linux distro: $ID"
          exit 1
          ;;
      esac
    else
      echo "❌ Could not detect Linux distribution."
      exit 1
    fi
    ;;
  "Darwin")
    install_macos
    ;;
  MINGW*|MSYS*|CYGWIN*|Windows_NT)
    install_wsl
    ;;
  *)
    echo "❌ Unsupported OS: $OS"
    exit 1
    ;;
esac

echo "✅ Python installation completed!"
python3 --version
pip3 --version
