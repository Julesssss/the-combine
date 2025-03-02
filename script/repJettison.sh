#!/bin/bash

# Get API token from root dir
API_TOKEN=$(cat "$(dirname "$0")/../api_token.txt")

# Get initial script dir
SCRIPT_DIR=$(dirname "$0")

# Ship to control
SHIP_NAME=${1:-"NO SHIP PASSED"}
EXCLUDED_MATERIAL=${2:-"NO EXCLUDED MATERIAL"}

if [ -z "$EXCLUDED_MATERIAL" ]; then
    echo "Error: You must provide an excluded material as param 2."
    exit 1
fi

# Get cargo
response=$(curl -s --location 'https://api.spacetraders.io/v2/my/ships/THECOMBINE-1/cargo' \
--header "Authorization: Bearer $API_TOKEN")
echo $response
