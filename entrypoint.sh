#!/bin/bash

function run_renovate() {
  yarn renovate \
    --log-file-level 'info' \
    --log-file 'renovate.log' || true
  cat renovate.log
}

(cd renovate; run_renovate)
