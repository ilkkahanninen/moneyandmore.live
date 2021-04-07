FROM gabekangas/owncast:0.0.6

RUN apk update && apk add curl && apk add jq

WORKDIR /app
COPY owncast/*.sh /app/
COPY config.json /app/data/setup.json

COPY owncast/logo.svg /app/data/logo.svg
COPY owncast/logo.svg /app/webroot/img/
COPY owncast/logo.png /app/webroot/img/

# Configure Owncast using its Admin API
ENTRYPOINT [ "/app/entrypoint.sh" ]
