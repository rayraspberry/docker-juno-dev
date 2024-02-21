#!/bin/bash

# Check if any arguments are provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 [docker run arguments]"
    exit 1
fi

# Construct the command to run inside the container
COMMAND="junod config chain-id juno-1 && junod config node https://rpc-juno.itastakers.com:443 && junod $@"

# Construct the docker run command with provided arguments
docker run -it -p 26657:26657 ghcr.io/strangelove-ventures/heighliner/juno:v20.0.0 sh -c "$COMMAND"
