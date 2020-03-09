FROM mhart/alpine-node:12

RUN apk add --no-cache bash

RUN apk add libressl-dev