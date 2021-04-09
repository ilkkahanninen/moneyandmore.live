FROM gabekangas/owncast:0.0.6

RUN apk update && apk add curl && apk add jq

WORKDIR /app
COPY *.sh /app/
COPY config.json /config/

COPY logo.svg /app/data/logo.svg
COPY logo.svg /app/webroot/img/
COPY logo.png /app/webroot/img/

# Configure Owncast using its Admin API
ENTRYPOINT [ "/app/entrypoint.sh" ]
