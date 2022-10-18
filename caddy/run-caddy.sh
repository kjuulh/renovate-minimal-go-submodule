#!/bin/bash

rm -rf /mnt/caddy || true
mkdir -p /mnt/caddy

caddy run --config Caddyfile 2> /mnt/caddy/caddy.running.log &

until curl https://localhost.localdomain/renovate-minimal-go-submodule &> /dev/null
do
  echo "Waiting for caddy..."
  sleep 1
done
