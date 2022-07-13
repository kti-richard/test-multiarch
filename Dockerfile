FROM --platform=$BUILDPLATFORM caddy:2.5.0-builder AS builder
RUN xcaddy build \
    --with github.com/greenpau/caddy-security \
    --with github.com/greenpau/caddy-trace

FROM --platform=$BUILDPLATFORM caddy:2.5.0
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
RUN apk add --no-cache nss-tools tzdata && \
    mkdir -p /opt/caddy/auth/

# keys.env defaults
ENV JWT_KEY=AnExampleSecretString123

# caddy/.env defaults
ENV CA_CN_ID=CA_CN_ID_NOT_CONFIGURED

ADD ./css /opt/caddy/css
ADD ./templates /opt/caddy/templates
ADD ./Caddyfile /etc/caddy
