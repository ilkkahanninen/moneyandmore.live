#!/bin/sh

CONFIG="/app/data/setup.json"

echo "Setup configuration file: $CONFIG"
echo "Waiting Owncast to start..."
sleep 3

if [[ -e "$CONFIG" ]]; then
  call_api() {
    local PASSWORD="$1"
    local ENDPOINT="$2"
    local PROPERTY="$3"
    local VALUE=$(jq -c $PROPERTY "$CONFIG")
    local BODY=$(echo $VALUE | jq -c "{value: .}")

    echo "$ENDPOINT: $VALUE"
    curl -sk -u "admin:$PASSWORD" "http://localhost:8080/api/$ENDPOINT" -d "$BODY" | jq -r ".message"
  }

  echo Setup

  # Set password
  call_api "abc123" "admin/config/key" ".server.streamKey"

  # Set server meta data
  PASSWORD=$(jq -r .server.streamKey "$CONFIG")
  call_api "$PASSWORD" "admin/config/name" ".meta.name"
  call_api "$PASSWORD" "admin/config/serverurl" ".meta.url"
  call_api "$PASSWORD" "admin/config/serversummary" ".meta.about"
  call_api "$PASSWORD" "admin/config/tags" ".meta.tags"
  call_api "$PASSWORD" "admin/config/socialhandles" ".meta.links"

  # rm "$CONFIG"
else
  echo "Setubbed already"
fi
