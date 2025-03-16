#!/bin/bash

# Get API token from root dir
API_TOKEN=$(cat "$(dirname "$0")/../api_token.txt")

# Verify ship was recieved
SHIP_NAME="$1"

response=$(curl -s --location --request POST "https://api.spacetraders.io/v2/my/ships/$SHIP_NAME/siphon" \
--header "Authorization: Bearer $API_TOKEN")

# Detect errors
error_message=$(echo "$response" | jq -r '.error.message // empty')
if [[ -n "$error_message" ]]; then
    echo "Error: $error_message"
    exit 1
fi

# Get cargo
SIPHONED=$(echo "$response" | jq -r '"\nSiphoned " + (.data.siphon.yield.units|tostring) + " " + .data.siphon.yield.symbol')
echo "$SIPHONED"

# Remaining cargo
# CARGO_INVENTORY=$(echo "$response" | jq '.data.cargo.inventory[] | "\(.name): \(.units)"')
# echo "$CARGO_INVENTORY"
