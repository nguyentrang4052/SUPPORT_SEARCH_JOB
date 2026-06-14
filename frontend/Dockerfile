FROM node:24-alpine
WORKDIR /frontend
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM node:24-alpine
WORKDIR /frontend
RUN npm install -g serve
COPY --from=builder /frontend/dist ./dist
EXPOSE 3000
CMD serve -s dist -l $PORT
