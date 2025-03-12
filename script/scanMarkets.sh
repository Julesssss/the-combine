#!/bin/bash

# Get API token from root dir
API_TOKEN=$(cat "$(dirname "$0")/../api_token.txt")

# Ship to control
SHIP_NAME=${1:-"NO SHIP PASSED"}

marketWaypoints=$(sqlite3 database.db -json "SELECT json_array(id) FROM waypoints WHERE traits LIKE '%MARKET%';")

echo "$marketWaypoints" | jq -r '.[]."json_array(id)" | fromjson | .[]' | while read -r id; do
    response=$(curl -s --location "https://api.spacetraders.io/v2/systems/X1-RH67/waypoints/$id/market" \
    --header "Authorization: Bearer $API_TOKEN")
    
    echo "\n\n$response"
    sleep 0.2
done

exit 0

# Scan waypoints, check response for errors
response=$(curl -s --location --request POST "https://api.spacetraders.io/v2/my/ships/$SHIP_NAME/scan/waypoints" \
--header "Authorization: Bearer $API_TOKEN")

# Detect errors
error_message=$(echo "$response" | jq -r '.error.message // empty')

printf "Scan complete!\n"
