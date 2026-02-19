FROM node:18-alpine
WORKDIR /usr/src/app
RUN apk add --no-cache python3 make g++ sqlite-dev
COPY package*.json ./
RUN npm ci --omit=dev
COPY . .
EXPOSE 3000
CMD ["npm","start"]