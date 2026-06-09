FROM node:22-alpine AS base
WORKDIR /backend
COPY package*.json ./
RUN npm ci
COPY . .
RUN npx prisma generate
RUN npm run build

FROM node:22-alpine AS production
WORKDIR /backend
COPY package*.json ./
RUN npm ci --omit=dev

COPY --from=base /backend/dist ./dist
COPY --from=base /backend/node_modules ./node_modules
COPY --from=base /backend/prisma ./prisma

EXPOSE 3000
CMD ["node","dist/main.js"]
