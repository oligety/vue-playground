# Stage 1: Build
FROM node:lts-alpine AS build-stage
WORKDIR /app
COPY app/package.json app/package-lock.json ./
RUN npm ci
COPY app/ .
RUN npm run build

# Stage 2: Production
FROM nginx:stable-alpine AS production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]