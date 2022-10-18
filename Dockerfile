FROM golang as buildmkcert

WORKDIR /src/mkcert

RUN apt update -y && \
  apt upgrade -y && \
  apt install -y curl libnss3-tools git

RUN git clone https://github.com/FiloSottile/mkcert . && \
  go build -ldflags "-X main.Version=$(git describe --tags)" && \
  ls && \
  pwd

FROM ubuntu 

WORKDIR src

# Fetch dependencies
RUN apt update -y && \
  apt upgrade -y && \
  apt install -y curl libnss3-tools build-essential python3 git && \
  curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
  apt install -y debian-keyring debian-archive-keyring apt-transport-https && \
  curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg && \
  curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list && \
  apt update -y && \
  apt install -y caddy nodejs && \
  npm install --global yarn

# Setup renovate
COPY renovate renovate
RUN (cd renovate; yarn)

# Setup mkcert
COPY cert cert
COPY --from=buildmkcert /src/mkcert/mkcert cert/
RUN (cd cert; ./mkcert)

# Run webserver
COPY caddy caddy
RUN (cd caddy; ./run-caddy.sh) # runs caddy as a daemon

COPY . .

CMD [ "./entrypoint.sh" ]
