#Builder
FROM containers.chewed-k8s.net/docker_hub_cache/library/golang:alpine3.19 AS builder
WORKDIR /builder

RUN apk update && apk add --no-cache git
RUN mkdir /src && cd /src
RUN git clone https://github.com/gohugoio/hugo.git .
RUN git checkout v0.121.1
RUN go install

RUN cd /builder
COPY . .

RUN hugo

## Runner
FROM caddy AS runner

COPY --from=builder /builder/public /srv
COPY ./Caddyfile /etc/caddy/Caddyfile

EXPOSE 80
EXPOSE 443
