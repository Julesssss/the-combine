#!/bin/bash

# Get API token from root dir
API_TOKEN=$(cat "$(dirname "$0")/../api_token.txt")

response=$(curl -s --location 'https://api.spacetraders.io/v2/my/contracts' \
--header "Authorization: Bearer $API_TOKEN")

echo "$response" | jq -r '.data[-1] | {id: .id, terms: .terms.deliver}'
