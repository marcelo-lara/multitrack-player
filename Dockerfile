FROM node:16-bullseye-slim AS base

WORKDIR /app

COPY package*.json ./
RUN npm ci

FROM base AS development

ENV HOST=0.0.0.0
ENV PORT=8080

EXPOSE 8080

CMD ["npm", "run", "serve", "--", "--host", "0.0.0.0", "--port", "8080"]

FROM base AS build

COPY . .
RUN npm run build

FROM nginx:1.27-alpine AS production

COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html/multitrack-player

EXPOSE 80