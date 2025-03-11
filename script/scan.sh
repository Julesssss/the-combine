#!/bin/bash

# Get API token from root dir
API_TOKEN=$(cat "$(dirname "$0")/../api_token.txt")

# Ship to control
SHIP_NAME=${1:-"NO SHIP PASSED"}

# Scan waypoints, check response for errors
response=$(curl -s --location --request POST "https://api.spacetraders.io/v2/my/ships/$SHIP_NAME/scan/waypoints" \
--header "Authorization: Bearer $API_TOKEN")

# Detect errors
error_message=$(echo "$response" | jq -r '.error.message // empty')
if [[ -n "$error_message" ]]; then
    echo "Error: $error_message"
    exit 1
fi

# Loop through waypoints json
echo "$response" | jq -c '.data.waypoints[]' | while IFS= read -r waypoint; do
    echo "Processing waypoint"
    systemSymbol=$(echo "$waypoint" | jq -r '.systemSymbol')
    symbol=$(echo "$waypoint" | jq -r '.symbol')
    type=$(echo "$waypoint" | jq -r '.type')
    x=$(echo "$waypoint" | jq -r '.x')
    y=$(echo "$waypoint" | jq -r '.y')
    traits=$(echo "$waypoint" | jq -r '[.traits[].symbol] | join(" ")')

    # Print waypoint
    sqlite3 database.db "insert into waypoints3 values('$symbol', '$systemSymbol', 'planet', 6, 7);"
    echo "System: $systemSymbol, Symbol: $symbol, Type: $type, X: $x, Y: $y, Traits: $traits"
done
