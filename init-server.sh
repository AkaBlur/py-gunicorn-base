#!/bin/bash

if [ ! -d "/app" ]; then
    echo "No 'app' application directory found!"
    exit 1
fi

if [ ! -f "/app/bootstrap.sh" ]; then
    echo "Application directory doesn't contain a 'bootstrap.sh' startup file!"
    exit 1
fi

if [ ! -f "/root/pip" -a -f "/app/requirements.txt" ]; then
    echo "requirements.txt detected. Installing..."
    pip install -r "/app/requirements.txt"
    touch "/root/pip"
fi

cd "/app"
source "bootstrap.sh"
