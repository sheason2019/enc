FROM node:20-alpine

WORKDIR /etc/enc

COPY . .

RUN npm i

RUN npm run build

RUN npx prisma migrate deploy

RUN npx prisma generate

VOLUME /etc/enc/data

EXPOSE 80

ENTRYPOINT ["npm", "run", "start:prod"]
