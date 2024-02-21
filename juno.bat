@echo off
SETLOCAL EnableDelayedExpansion

REM Check if any arguments are provided
@REM IF "%~1" == "" (
@REM     echo Usage: %0 [docker run arguments]
@REM     exit /b 1
@REM )

REM Construct the command to run inside the container
SET "COMMAND=junod config chain-id juno-1 && junod config node https://rpc-juno.itastakers.com:443 && junod %*"

REM Construct the docker run command with provided arguments
set image_name=ghcr.io/strangelove-ventures/heighliner/juno:v20.0.0


docker ps -a --filter "ancestor=%image_name%" --format "{{.ID}}" | findstr /r "[0-9a-f]" >nul
if %errorlevel% equ 0 (
    echo A container based on image %image_name% already exists. Using existing container.
    for /f "tokens=1" %%i in ('docker ps -a --filter "ancestor=%image_name%" --format "{{.ID}}"') do (
    echo Starting container: %%i 
    docker start %%i 
    docker exec -it %%i sh -c !COMMAND!
    REM Break out of the loop after starting the first container
    goto :done
)
) else (
    echo No container based on image %image_name% found. Creating a new container.
    docker run -it -p 26657:26657 ghcr.io/strangelove-ventures/heighliner/juno:v20.0.0 sh -c "!COMMAND!"
)

:done

