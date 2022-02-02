FROM node:14-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm cache clear --force
RUN npm config set fetch-retry-maxtimeout 1000000 -g
RUN npm install --force
COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html