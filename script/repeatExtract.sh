#!/bin/bash

# Get initial script dir
SCRIPT_DIR=$(dirname "$0")

# Ship to control
SHIP_NAME=${1:-"NO SHIP PASSED"}

# Restricted repeats
while true; do

    # Extract
    bash "$SCRIPT_DIR/extract.sh" "$SHIP_NAME"
    sleep 2

    # Cooldown
    for i in {1..7}; do
        printf "\nwaiting for cooldown..."
        sleep 10 # Wait for cooldown
    done
done