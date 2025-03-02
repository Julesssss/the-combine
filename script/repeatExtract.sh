#!/bin/bash

# Get initial script dir
SCRIPT_DIR=$(dirname "$0")

# Ship to control
SHIP_NAME=${1:-"NO SHIP PASSED"}
EXCLUDED_MATERIAL=${2:-"NO EXCLUDED MATERIAL"}

# Restricted repeats
while true; do

    # Extract
    sh "$SCRIPT_DIR/extract.sh" "$SHIP_NAME"

    # Jettison
    sh script/repJettison.sh THECOMBINE-1 "$EXCLUDED_MATERIAL"

    # Cooldown
    for i in {0..7}; do
        printf "\nwaiting for cooldown..."
        sleep 10
    done
done