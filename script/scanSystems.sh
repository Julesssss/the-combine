#!/bin/bash

# Get API token from root dir
API_TOKEN=$(cat "$(dirname "$0")/../api_token.txt")

# Ship to control
SHIP_NAME=${1:-"NO SHIP PASSED"}

sqlite3 database.db "CREATE TABLE IF NOT EXISTS systems (
    id TEXT PRIMARY KEY, 
    sector TEXT NOT NULL, 
    type TEXT NOT NULL, 
    x INT NOT NULL, 
    y INT NOT NULL
);"

for i in {1..1000}; do
    response=$(curl -s --location "https://api.spacetraders.io/v2/systems?limit=20&page=$i" \
--header "Authorization: Bearer $API_TOKEN")

    # Check if .data is an empty array
    if [[ $(echo "$response" | jq '.data | length') -eq 0 ]]; then
        printf "\nGalaxy scan complete!\n"
        exit 0
    fi

    # Persist systems to db
    echo "$response" | jq -c '.data[]' | while IFS= read -r waypoint; do
        # echo "$response" | jq -r '.'
        symbol=$(echo "$waypoint" | jq -r '.symbol')
        sector=$(echo "$waypoint" | jq -r '.sectorSymbol')
        type=$(echo "$waypoint" | jq -r '.type')
        x=$(echo "$waypoint" | jq -r '.x')
        y=$(echo "$waypoint" | jq -r '.y')

        echo "$symbol: $x/$y  $type  $sectorSymbol"
        sqlite3 database.db "insert into systems (id, sector, type, x, y) values('$symbol', '$sector', '$type', $x, $y);"
    done
    count=$(sqlite3 database.db "SELECT COUNT(*) FROM SYSTEMS;")
    echo Systems scanned: $count
done