FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
FROM node:20-alpine
WORKDIR /app
RUN mkdir -p /etc/todos && chown -R node:node /etc/todos
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/src ./src
EXPOSE 3000
USER node

CMD ["node", "src/index.js"]
