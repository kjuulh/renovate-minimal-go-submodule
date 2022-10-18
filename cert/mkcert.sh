#!/bin/bash

# Install root certificates
./mkcert --install

# Cleanup generated certificates
rm -rf generated/ || true
mkdir -p generated/

# Create keys from ca
./mkcert &&
  -key-file generated/key.pem &&
  -cert-file generated/cert.pem localhost.localdomain
