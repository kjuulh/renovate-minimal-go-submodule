#!/bin/bash

set -e


function run_renovate() {
  pushd renovate

  rm -rf /mnt/renovate || true
  mkdir -p /mnt/renovate/


  yarn renovate \
    --log-file-level 'trace' \
    --log-file '/mnt/renovate/renovate.log'

  popd
}

function run_caddy() {
  (cd caddy; ./run-caddy.sh)
  # Sanity check
  echo "check caddy service"
  echo "$(ps aux | grep caddy)"
  curl https://localhost.localdomain/renovate-minimal-go-submodule/submodule?go-get=1 -v > /dev/null
}

function make_cert() {
  (cd cert; ./mkcert.sh)

  ls /src/cert/generated
}

make_cert
export NODE_EXTRA_CA_CERTS="$(./cert/mkcert -CAROOT)/rootCA.pem"

run_caddy
run_renovate
