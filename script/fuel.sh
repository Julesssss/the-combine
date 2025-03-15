#!/bin/bash

# Get API token from root dir
API_TOKEN=$(cat "$(dirname "$0")/../api_token.txt")

# Dock first, as a precaution
curl --location -s --request POST 'https://api.spacetraders.io/v2/my/ships/THE-COMBINE-1/dock' \
--header "Authorization: Bearer $API_TOKEN" > /dev/null

# Refuel 
response=$(curl -s --location --request POST 'https://api.spacetraders.io/v2/my/ships/THE-COMBINE-1/refuel' \
--header "Authorization: Bearer $API_TOKEN")
echo "$response" | jq -r '.'
