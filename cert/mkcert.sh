#!/bin/bash


mkcert --install

rm -rf generated/
mkdir -p generated/

mkcert -key-file generated/key.pem -cert-file generated/cert.pem localhost.localdomain
