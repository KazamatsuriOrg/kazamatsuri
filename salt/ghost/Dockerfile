FROM node:4.3
RUN apt-get update -qq && apt-get install unzip

WORKDIR /srv/ghost
ADD https://ghost.org/zip/ghost-{{ pillar['ghost']['version'] }}.zip ghost.zip
RUN unzip ghost.zip && npm install --production
RUN npm install ghost-s3-storage pg

ENV GHOST_NODE_VERSION_CHECK=false
CMD NODE_ENV=production npm start
