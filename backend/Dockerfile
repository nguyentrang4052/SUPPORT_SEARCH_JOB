FROM node:22-alpine
WORKDIR /backend
COPY package*.json ./
RUN npm ci
COPY . .
RUN npx prisma generate
RUN npm run build
RUN ls -la dist/

EXPOSE 3000
CMD ["node", "-r", "./tsconfig-paths-bootstrap.js", "dist/src/main.js"]
