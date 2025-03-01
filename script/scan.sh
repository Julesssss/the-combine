#!/bin/bash

# Ship to control
SHIP_NAME=${1:-"NO SHIP PASSED"}

response=$(curl -s --location --request GET "https://api.spacetraders.io/v2/systems/X1-PT46/waypoints" \
--header "Authorization: Bearer $API_TOKEN")

CARGO_INVENTORY=$(echo "$response" | jq -r '.data[] | .symbol + ": " + (.x|tostring) + "/" + (.y|tostring) + " " + .type')
echo "$CARGO_INVENTORY"
