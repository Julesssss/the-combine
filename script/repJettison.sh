#!/bin/bash

# Get API token from root dir
API_TOKEN=$(cat "$(dirname "$0")/../api_token.txt")

# Get initial script dir
SCRIPT_DIR=$(dirname "$0")

# Ship to control
SHIP_NAME=${1:-"NO SHIP PASSED"}
EXCLUDED_MATERIAL=${2:-"NO EXCLUDED MATERIAL"}

if [ -z "$EXCLUDED_MATERIAL" ]; then
    echo "Error: You must provide an excluded material as param 2."
    exit 1
fi

# Get cargo
response=$(curl -s --location 'https://api.spacetraders.io/v2/my/ships/THECOMBINE-1/cargo' \
--header "Authorization: Bearer $API_TOKEN")

# Extract cargo symbols into an array
while IFS= read -r symbol; do
    cargo_symbols+=("$symbol")
done <<< "$(echo "$response" | jq -r '.data.inventory[].symbol')"

# Exclude the material we want to keep
cargo_symbols=($(echo "${cargo_symbols[@]}" | tr ' ' '\n' | grep -v -w "$EXCLUDED_MATERIAL"))

# Jettison
echo "Cargo Symbols:"
for symbol in "${cargo_symbols[@]}"; do
    echo "Jettison $symbol"
    sh "$SCRIPT_DIR/jettison.sh" "$SHIP_NAME" "$symbol"
    sleep 1
done
