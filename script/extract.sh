API_TOKEN=$(cat api_token.txt)
printf "\n\nExtracting:\n"
curl --location --request POST 'https://api.spacetraders.io/v2/my/ships/JULTEST-3/extract' \
--header "Authorization: Bearer $API_TOKEN"