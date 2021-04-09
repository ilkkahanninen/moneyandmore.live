#/bin/sh

CONFIG="config.json"

if [[ -e "$CONFIG" ]]; then
  DOMAIN=$(jq -r .domain config.json)

  # Update Caddy
  sed "s/\$DOMAIN/$DOMAIN/g" ./caddy/Caddyfile.template > ./caddy/Caddyfile

  # Update Owncast
  cp ./config.json ./owncast/config.json

  # Build and run
  docker-compose build && docker-compose up
else
  echo "$CONFIG is missing"
fi
