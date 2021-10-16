FROM node:alpine AS builder

RUN mkdir /app

WORKDIR /app

COPY package*.json ./

RUN npm install

RUN npm config set unsafe-perm true

RUN mkdir -p node_modules/.cache && chmod -R 777 node_modules/.cache

COPY ./ ./

RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html