#!/bin/bash

# Get API token from root dir
API_TOKEN=$(cat "$(dirname "$0")/../api_token.txt")

printf "\nExtracted:\n"
response=$(curl -s --location --request POST 'https://api.spacetraders.io/v2/my/ships/JULTEST-3/extract' \
--header "Authorization: Bearer $API_TOKEN")

# Get cargo
CARGO_INVENTORY=$(echo "$response" | jq '.data.cargo.inventory[] | "\(.name): \(.units)"')
echo "$CARGO_INVENTORY"