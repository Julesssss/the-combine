#!/bin/bash

# Get API token from root dir
API_TOKEN=$(cat "$(dirname "$0")/../api_token.txt")

# Ship to control
SHIP_NAME=${1:-"NO SHIP PASSED"}

marketWaypoints=$(sqlite3 database.db -json "SELECT json_array(id) FROM waypoints WHERE traits LIKE '%MARKET%';")
echo "$marketWaypoints" | jq -r '.[]."json_array(id)" | fromjson | .[]' |
while read -r id; do
    response=$(curl -s --location "https://api.spacetraders.io/v2/systems/X1-RH67/waypoints/$id/market" --header "Authorization: Bearer $API_TOKEN")
    echo "$response" | jq -r '.data.symbol'
    echo "Imports:"
    echo "$response" | jq -r '.data.imports[].symbol'
    echo "Exports:"
    echo "$response" | jq -r '.data.exports[].symbol'
    printf "\n"
    sleep 0.2
done

printf "Market scan complete!\n"
