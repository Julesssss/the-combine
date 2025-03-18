#!/bin/bash

# Get initial script dir
SCRIPT_DIR=$(dirname "$0")

# Ship to control
EXCLUDED_MATERIAL=${1:-"NO EXCLUDED MATERIAL"}

# Restricted repeats
while true; do

    # Extract
    sh "$SCRIPT_DIR/extract.sh" "THE-COMBINE-1"

    # Jettison
    sh "$SCRIPT_DIR/repJettison.sh" "THE-COMBINE-1" "$EXCLUDED_MATERIAL"

    # Cooldown
    for i in {0..7}; do
        printf "\nwaiting for cooldown..."
        sleep 10
    done
done