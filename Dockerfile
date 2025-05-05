FROM node:22-alpine AS builder

RUN npm install --global --force yarn

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn install

COPY . .

RUN yarn stand:build

FROM caddy:2-alpine

COPY --from=builder /app/build /usr/share/caddy

COPY Caddyfile /etc/caddy/Caddyfile

EXPOSE 8080