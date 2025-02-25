#!/bin/bash

# Get API token from root dir
API_TOKEN=$(cat "$(dirname "$0")/../api_token.txt")

# Verify ship was recieved
SHIP_NAME="$1"
printf "\nSHIP_NAME: $SHIP_NAME"

printf "\nExtracted:\n"
response=$(curl -s --location --request POST "https://api.spacetraders.io/v2/my/ships/$SHIP_NAME/extract" \
--header "Authorization: Bearer $API_TOKEN")

# Get cargo
CARGO_INVENTORY=$(echo "$response" | jq '.data.cargo.inventory[] | "\(.name): \(.units)"')
echo "$CARGO_INVENTORY"