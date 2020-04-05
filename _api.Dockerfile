# Compile 1
FROM node:12.16.1-alpine3.11 AS build
WORKDIR /app

COPY ./back .
RUN npm install --only=prod

RUN npx -p @nestjs/cli nest build

# Run
FROM base-dind AS base
WORKDIR /app

COPY --from=build /app .

EXPOSE 80
CMD ["npm","run","start:prod"]