#!/bin/bash

# Get API token from root dir
API_TOKEN=$(cat "$(dirname "$0")/../api_token.txt")

# Get to orbit, as a precaution
curl --location -s --request POST 'https://api.spacetraders.io/v2/my/ships/THE-COMBINE-1/orbit' \
--header "Authorization: Bearer $API_TOKEN" > /dev/null

# Navigate 
response=$(curl -s --location 'https://api.spacetraders.io/v2/my/ships/THE-COMBINE-1/navigate' \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $API_TOKEN" \
--data '{
    "waypointSymbol": "X1-RH67-C40"
   }')
echo "$response" | jq -r '.'
