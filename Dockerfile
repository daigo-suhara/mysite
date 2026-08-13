FROM ghcr.io/gohugoio/hugo:v0.164.0 AS build

WORKDIR /src
COPY . .
RUN hugo --minify --baseURL https://daigo-suhara.com/

FROM nginxinc/nginx-unprivileged:1.29-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /src/public /usr/share/nginx/html

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -qO- http://127.0.0.1:8080/ >/dev/null || exit 1
