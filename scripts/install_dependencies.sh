#! /bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

if [ -f /etc/os-release ]; then
    source /etc/os-release
    OS=$NAME
fi

case $OS in
    "Ubuntu")
        apt-get update && apt-get install -y jq curl
        ;;
    "macOS")
        brew install jq curl
        ;;
    *)
        echo "Unsupported OS: $OS"
        exit 1
        ;;
esac

echo "Dependencies installed successfully"
