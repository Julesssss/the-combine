#!/bin/bash

# Get API token from root dir
API_TOKEN=$(cat "$(dirname "$0")/../api_token.txt")

response=$(curl -s --location 'https://api.spacetraders.io/v2/my/ships' \
--header "Authorization: Bearer $API_TOKEN")

echo "$response" | jq -r '.data[0] | {ship: .symbol, waypoint: .nav.waypointSymbol, status: .nav.status, destination: .nav.route.destination, fuel: {current: .fuel.current, capacity: .fuel.capacity}, cargo: [.cargo.inventory[] | {symbol, units}]}'
