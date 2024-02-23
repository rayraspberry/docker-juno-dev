# docker-juno-dev
Development environment for Working on Juno blockchain

## Prerequisites

- Docker

## Usage

`docker build . -t node-web-app-with-junod:v2.0.0`

then

`docker run -d -p 8080:80 -p 8081:8080 node-web-app-with-junod:v2.0.0`

then

`http://localhost:8001/`
