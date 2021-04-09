#/bin/sh

CONFIG="config.json"

if [[ -e "$CONFIG" ]]; then
  DOMAIN=$(jq -r .domain config.json)

  # Update Caddy
  sed "s/\$DOMAIN/$DOMAIN/g" ./caddy/Caddyfile.template > ./caddy/Caddyfile

  # Update Owncast
  cp ./config.json ./owncast/config.json

  # Build
  docker-compose build
else
  echo "$CONFIG is missing"
fi
