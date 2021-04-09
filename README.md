# Money & More infra

## Installation on clean server:

```
apt update
apt -y install git jq docker.io docker-compose
systemctl enable docker
git clone https://github.com/ilkkahanninen/moneyandmore.live
```

## Configuration

1. Copy `config.template.json` to `config.json` and edit it.
2. Run `./configure.sh`

## Start

`docker-compose up -d`

## TODO

- Stream forwarding
- Custom rtmp auth
