#!/bin/bash

# Get API token from root dir
API_TOKEN=$(cat "$(dirname "$0")/../api_token.txt")

# Ship to control
SHIP_NAME=${1:-"NO SHIP PASSED"}
SYMBOL=${2:-"NO MATERIAL PASSED"}

# Jettison unwanted cargo
response=$(curl -s --location "https://api.spacetraders.io/v2/my/ships/$SHIP_NAME/jettison" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $API_TOKEN" \
--data "{
    \"symbol\": \"$SYMBOL\",
    \"units\": \"100\"
}")

# Detect errors
error_message=$(echo "$response" | jq -r '.error.message // empty')
if [[ -n "$error_message" ]]; then
    echo "$response" | jq -r '.'
    exit 1
fi

# Remaining cargo
printf "Remaining Cargo:\n"
echo "$response" | jq -r '.data.cargo.inventory | .[] | "\(.symbol): \(.units|tostring)"'
