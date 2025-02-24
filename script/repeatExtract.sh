#!/bin/bash

# Restricted repeats
while true; do
#for i in {1..10}; do
    bash ./extract.sh
    printf "\n\nwaiting..."
    sleep 10  # Wait for cooldown
done
