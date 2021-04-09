#!/bin/sh

CONFIG="/config/config.json"
LAST_UPDATE="/app/data/last_update"

echo "Setup configuration file: $CONFIG"

# ---------------------------------

set_value() {
  local PASSWORD="$1"
  local ENDPOINT="$2"
  local VALUE="$3"

  echo "$ENDPOINT: $VALUE"

  local BODY=$(echo $VALUE | jq -c "{value: .}")
  curl -sk -u "admin:$PASSWORD" "http://localhost:8080/api/$ENDPOINT" -d "$BODY" | jq -r ".message"
}

set_from_config() {
  set_value "$1" "$2" "$(jq -c "$3" "$CONFIG")"
}

if [[ ! -e "$LAST_UPDATE" ]] || [[ "$CONFIG" -nt "$LAST_UPDATE" ]]; then
  echo "Configuration updated..."
  sleep 3
fi

if [[ ! -e "$LAST_UPDATE" ]]; then
  # Set password
  set_from_config "abc123" "admin/config/key" ".server.streamKey"
fi

if [[ ! -e "$LAST_UPDATE" ]] || [[ "$CONFIG" -nt "$LAST_UPDATE" ]]; then
  # Set server meta data
  PASSWORD=$(jq -r .server.streamKey "$CONFIG")
  set_from_config "$PASSWORD" "admin/config/name" ".meta.name"
  set_from_config "$PASSWORD" "admin/config/serverurl" ".meta.url"
  set_from_config "$PASSWORD" "admin/config/serversummary" ".meta.about"
  set_from_config "$PASSWORD" "admin/config/tags" ".meta.tags"
  set_from_config "$PASSWORD" "admin/config/socialhandles" ".meta.links"
  # set_value "$PASSWORD" "admin/config/rtmpserverport" "19350"
fi

touch "$LAST_UPDATE"
