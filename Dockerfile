FROM caddy:2.4.5-builder AS builder
RUN xcaddy build \
    --with github.com/greenpau/caddy-security \
    --with github.com/greenpau/caddy-trace

FROM caddy:2.4.5
COPY --from=builder /usr/bin/caddy /usr/bin/caddy

