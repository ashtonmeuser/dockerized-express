FROM node:13.10-alpine3.11

COPY . .

RUN npm ci

EXPOSE 3000

CMD ["npm", "start"]
