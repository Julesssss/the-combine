#!/bin/bash

# Get initial script dir
SCRIPT_DIR=$(dirname "$0")

# Restricted repeats
while true; do
#for i in {1..10}; do
    bash "$SCRIPT_DIR/extract.sh"
    printf "\n\nwaiting..."
    sleep 10  # Wait for cooldown
done
