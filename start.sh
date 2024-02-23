#!/bin/bash

docker build . -t node-web-app-with-junod:v2.0.0

docker run -d --name juno-dev -p 8080:80 -p 8081:8080 node-web-app-with-junod:v2.0.0

docker exec -it juno-dev service nginx restart
