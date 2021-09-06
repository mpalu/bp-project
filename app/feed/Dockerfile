FROM node:lts-alpine3.14@sha256:3f4c922d5f29da10fc2a5f1ab6a9812e7aadfc88ecc9e150ef86066f449e55ec

RUN apk add openjdk11-jre

RUN addgroup -S bp && \
  adduser -S bp -G bp --disabled-password --no-create-home

WORKDIR /usr/src/app

COPY --chown=bp:bp . /usr/src/app

RUN npm install && \
  npm run release

USER bp

CMD "npm" "run" "start"

EXPOSE 3000