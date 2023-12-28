FROM node:20-alpine

WORKDIR /etc/enc

COPY . .

RUN npm i

RUN npm run build

VOLUME /etc/enc/data

ENTRYPOINT ["npm", "run", "start:prod"]
