#!/bin/bash

# Get API token from root dir
API_TOKEN=$(cat "$(dirname "$0")/../api_token.txt")

# Ship to control
SHIP_NAME=${1:-"NO SHIP PASSED"}

# Scan waypoints, check response for errors
response=$(curl -s --location --request POST "https://api.spacetraders.io/v2/my/ships/$SHIP_NAME/scan/waypoints" \
--header "Authorization: Bearer $API_TOKEN")

# Detect errors
error_message=$(echo "$response" | jq -r '.error.message')
if [[ -n "$error_message" ]]; then
    echo "Error: $error_message"
    exit 1
fi

# Format waypoint results
waypoints=$(echo "$response" | jq -r '.data.waypoints[] | .symbol + ": " + (.x|tostring) + "/" + (.y|tostring) + " " + .type')
echo "$waypoints"
