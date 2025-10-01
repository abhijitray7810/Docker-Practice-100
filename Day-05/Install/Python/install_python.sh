#!/usr/bin/env bash

# =========================
# Python Installer Script
# Works on:
#  - Ubuntu/Debian
#  - CentOS/RHEL
#  - macOS
#  - WSL (Windows Subsystem for Linux)
# =========================

set -e

echo "🔍 Detecting OS..."

OS="unknown"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
    OS="windows"
fi

echo "✅ Detected OS: $OS"

install_python_ubuntu() {
    echo "📦 Updating package list..."
    sudo apt update -y
    echo "📦 Installing Python..."
    sudo apt install -y python3 python3-pip python3-venv
}

install_python_centos() {
    echo "📦 Installing Python..."
    sudo yum install -y python3 python3-pip
}

install_python_macos() {
    echo "🍏 Installing Homebrew (if not installed)..."
    if ! command -v brew &> /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    echo "📦 Installing Python..."
    brew install python
}

install_python_windows() {
    echo "⚠️  Direct installation on Windows requires manual download."
    echo "👉 Download Python from https://www.python.org/downloads/"
    echo "Or use WSL (this script works there)."
}

# ---- Main ----
case $OS in
    ubuntu|debian)
        install_python_ubuntu
        ;;
    centos|rhel)
        install_python_centos
        ;;
    macos)
        install_python_macos
        ;;
    windows)
        install_python_windows
        ;;
    *)
        echo "❌ Unsupported OS. Exiting."
        exit 1
        ;;
esac

echo "✅ Python installation completed!"
echo "👉 Check version with: python3 --version && pip3 --version"
