FROM caddy


COPY ./public /usr/share/caddy
COPY ./Caddyfile /etc/caddy/Caddyfile


EXPOSE 80
EXPOSE 443