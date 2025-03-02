#!/bin/bash

# Get API token from root dir
API_TOKEN=$(cat "$(dirname "$0")/../api_token.txt")

# Ship to control
SHIP_NAME=${1:-"NO SHIP PASSED"}

# Jettison unwanted cargo
response=$(curl -s --location 'https://api.spacetraders.io/v2/my/ships/THECOMBINE-1/jettison' \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $API_TOKEN" \
--data '{
    "symbol": "IRON_ORE",
    "units": "100"
   }')
echo "$response"
