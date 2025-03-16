#!/bin/bash

# Get API token from root dir
API_TOKEN=$(cat "$(dirname "$0")/../api_token.txt")

# Ship to control
SHIP_NAME=${1:-"NO SHIP PASSED"}

marketWaypoints=$(sqlite3 database.db -json "SELECT json_array(id) FROM waypoints WHERE traits LIKE '%MARKET%';")
echo "$marketWaypoints" | jq -r '.[]."json_array(id)" | fromjson | .[]' |
while read -r id; do
    response=$(curl -s --location "https://api.spacetraders.io/v2/systems/X1-RH67/waypoints/$id/market" --header "Authorization: Bearer $API_TOKEN")

    # Ignore market with no imports/exports
    if [[ $(echo "$response" | jq '.data.imports | length') -eq 0 ]]; then
        if [[ $(echo "$response" | jq '.data.exports | length') -eq 0 ]]; then
            continue
        fi
    fi

    echo "\n$id:"
    if [[ $(echo "$response" | jq '.data.imports | length') -ne 0 ]]; then
        echo "IMPORTS: $(echo "$response" | jq -r '[.data.imports[].symbol] | join(", ")')"
    fi

    if [[ $(echo "$response" | jq '.data.exports | length') -ne 0 ]]; then
        echo "EXPORTS: $(echo "$response" | jq -r '[.data.exports[].symbol] | join(", ")')"
    fi
done

printf "Market scan complete!\n"
