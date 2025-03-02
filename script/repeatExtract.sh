#!/bin/bash

# Get initial script dir
SCRIPT_DIR=$(dirname "$0")

# Ship to control
SHIP_NAME=${1:-"NO SHIP PASSED"}

# Restricted repeats
while true; do

    # Extract
    bash "$SCRIPT_DIR/extract.sh" "$SHIP_NAME"

    # Cooldown
    for i in {0..7}; do
        printf "\nwaiting for cooldown..."
        sleep 10
    done
done