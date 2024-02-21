@echo off
setlocal EnableDelayedExpansion

REM Specify the name of the file you want to find
SET "filename=juno.bat"

REM Get the full path of the file
SET "file_path=%~dp0%filename%"




REM Check if the file exists
if exist "%file_path%" (
    SET "current_path=%file_path%;%PATH%"
    SETX PATH "!current_path!"

) else (
    echo The file "%filename%" was not found in the directory.
)

endlocal