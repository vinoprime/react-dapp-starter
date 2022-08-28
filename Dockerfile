# stage 1
FROM node:16 AS build-step-0

WORKDIR /app

# RUN npm install -g npm
RUN npm install -g npm@latest

COPY package*.json ./

RUN npm install --legacy-peer-deps

COPY . .
RUN npm run build


# stage 2
FROM nginx:1.16.1-alpine as prod-stage
COPY --from=build-step-0 /app/build /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/nginx.conf
CMD ["nginx", "-g", "daemon off;"]
