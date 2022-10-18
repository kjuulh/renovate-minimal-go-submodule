#!/bin/bash

set -e

# Install root certificates
./mkcert -install

# Cleanup generated certificates
rm -rf generated/ || true
mkdir -p generated/

# Create keys from ca
./mkcert \
  -key-file generated/key.pem \
  -cert-file generated/cert.pem \
  localhost.localdomain localhost 127.0.0.1 ::1 

export NODE_EXTRA_CA_CERTS="$(./mkcert -CAROOT)/rootCA.pem"
