# Renovate minimal go submodule

issue: https://github.com/renovatebot/renovate/issues/18396

## To run

```bash
cp .env.example .env
# Fill environment vars

docker compose up --build
```

This will setup an internal https server using caddy, a renovate and test
against https://github.com/kjuulh/renovate-minimal-go-submodule/pulls.

The idea is to illustrate that renovate will match errors wrong. Do note that
rate limit may apply

## Structure

- caddy -> webserver
- cert -> build https certificate for webserver, this is a hardcoded requirement
  in renovate
- output -> after run this will contain the logs of renovate, caddy etc. this is
  cleared on each run
- renovate -> renovate config
- submodule -> basic go library; without user in path
- submodule -> basic go library; with user in path
- test-fetch-package -> basic go executable without user in path
- test-fetch-package-with-user -> basic go executable with user in path
- Dockerfile -> setup to run locally
- docker-compose -> recipe for running tests locally
- entrypoint.sh -> used in docker to execute the test
- main.go and go.mod -> root module
- renovate.json -> renovate automatically adds this
