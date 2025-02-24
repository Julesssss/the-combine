#!/bin/bash

# Get API token from root dir
API_TOKEN=$(cat "$(dirname "$0")/../api_token.txt")

printf "\nExtracting:\n"
curl --location --request POST 'https://api.spacetraders.io/v2/my/ships/JULTEST-3/extract' \
--header "Authorization: Bearer $API_TOKEN"
