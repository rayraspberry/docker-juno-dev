FROM  ubuntu:latest

RUN apt-get clean && apt-get update
# Install Node.js
RUN apt-get install --yes nodejs
RUN apt-get install --yes npm

# root as working directory
WORKDIR /
RUN apt-get install make
RUN apt-get install --yes build-essential
RUN apt-get install gcc 
RUN apt-get install --yes wget 
RUN apt-get install --yes git
RUN apt-get install --yes jq

# Install Go
RUN wget https://golang.org/dl/go1.21.0.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.21.0.linux-amd64.tar.gz


ENV GOROOT=/usr/local/go
ENV GOPATH=$HOME/go
ENV GO111MODULE=on
ENV PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

RUN git clone https://github.com/CosmosContracts/juno
WORKDIR /juno
RUN git fetch
RUN git checkout v20.0.0

RUN make install

RUN junod config chain-id juno-1

RUN junod config node https://rpc-juno.itastakers.com:443

# Create app directory
WORKDIR /app

# Install app dependencies
COPY nodejs-docker-web-app/package.json ./

# run npm install
RUN npm install

# Bundle app source
COPY ./nodejs-docker-web-app .

EXPOSE 8080

CMD ["npm", "start"]
