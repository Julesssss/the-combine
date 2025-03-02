#!/bin/bash

# Get API token from root dir
API_TOKEN=$(cat "$(dirname "$0")/../api_token.txt")

# Ship to control
SHIP_NAME=${1:-"NO SHIP PASSED"}

response=$(curl -s --location --request POST "https://api.spacetraders.io/v2/my/ships/$SHIP_NAME/scan/waypoints" \
--header "Authorization: Bearer $API_TOKEN")

waypoints=$(echo "$response" | jq -r '.data.waypoints[] | .symbol')
echo "$waypoints"