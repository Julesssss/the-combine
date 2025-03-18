#!/bin/bash

# Get API token from root dir
API_TOKEN=$(cat "$(dirname "$0")/../api_token.txt")

# Destination waypoint
WAYPOINT=${1:-"NO WAYPOINT"}
SHIP_NAME=$(echo "THE-COMBINE-2")

# Get to orbit, as a precaution
curl -s --location --request POST "https://api.spacetraders.io/v2/my/ships/$SHIP_NAME/orbit" \
--header "Authorization: Bearer $API_TOKEN" > /dev/null

# Navigate 
response=$(curl -s --location "https://api.spacetraders.io/v2/my/ships/$SHIP_NAME/navigate" \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $API_TOKEN" \
--data "{
    \"waypointSymbol\": \"$WAYPOINT\"
}")
# echo "$response" | jq -r '.'

# Detect navigation error
error_message=$(echo "$response" | jq -r '.error.message // empty')
if [[ -n "$error_message" ]]; then
    echo "Error: $error_message"
    exit 1
fi

timestamp=$(echo "$response" | jq -r '.data.nav.route.arrival')
destinationWaypoint=$(echo "$response" | jq -r '.data.nav.waypointSymbol')
destinationWType=$(echo "$response" | jq -r '.data.nav.route.destination.type')

target_clean=${timestamp%%.*}

# Convert target time (assumed to be UTC) to epoch seconds using BSD date
end=$(TZ=UTC date -j -f "%Y-%m-%dT%H:%M:%S" "$target_clean" +%s)

# Get current time in seconds and calculate remaining
now=$(date +%s)
diff=$(( end - now ))

echo "Setting course for $destinationWaypoint"
sleep 1

if (( diff > 0 )); then
#   printf "Burning for %d seconds... " "$diff"

  while (( diff-- > 0 )); do
      printf "\rBurning for %d seconds... " "$diff"
      sleep 1
  done

  printf "\nArrived in orbit at %s -- (%s)\n" "$destinationWaypoint" "$destinationWType"
else
  echo "Error: Timestamp must be in future."
fi