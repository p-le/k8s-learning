FROM node:15.11-buster

WORKDIR /app

COPY server.js /app/server.js
COPY package*.json /app/

RUN npm ci

CMD node /app/server.js