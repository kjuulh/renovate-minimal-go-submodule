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
