@echo off
SETLOCAL EnableDelayedExpansion

REM Check if any arguments are provided
IF "%~1" == "" (
    echo Usage: %0 [docker run arguments]
    exit /b 1
)

REM Construct the command to run inside the container
SET "COMMAND=junod config chain-id juno-1 && junod config node https://rpc-juno.itastakers.com:443 && junod %*"

REM Construct the docker run command with provided arguments
docker run -it -p 26657:26657 ghcr.io/strangelove-ventures/heighliner/juno:v20.0.0 sh -c "!COMMAND!"
