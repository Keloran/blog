FROM caddy


COPY ./public /srv
COPY ./Caddyfile /etc/caddy/Caddyfile


EXPOSE 80
EXPOSE 443