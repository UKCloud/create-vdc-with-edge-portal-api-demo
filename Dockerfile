FROM node:12 AS web-compiler
RUN apt-get update && apt-get install --assume-yes default-jre
WORKDIR /app
COPY package.json package-lock.json generate-api.bash /app/
RUN npm install
COPY generated /app/generated
COPY docs /app/docs
RUN npm run generate-api
COPY dist /app/dist
COPY tsconfig.json webpack.config.js /app/
COPY src /app/src
RUN npx webpack --mode production

FROM rust:1.51 AS server-compiler
WORKDIR /app/server
RUN mkdir /app/dist && touch --date "1 Jan 1970" /app/dist/index.html /app/dist/main.js
COPY server /app/server
RUN cargo build --release
COPY --from=web-compiler /app/dist/ /app/dist
RUN touch /app/dist/*
RUN cargo build --release

FROM ubuntu:20.04
RUN apt-get update && apt-get install --assume-yes ca-certificates
COPY --from=server-compiler /app/server/target/release/server /server
ENTRYPOINT ["/server", "0.0.0.0:3000"]
CMD ["portal.skyscapecloud.com"]
EXPOSE 3000
