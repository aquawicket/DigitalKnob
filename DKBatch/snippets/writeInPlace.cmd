@echo off

setlocal enableextensions enabledelayedexpansion
for /f %%a in ('copy /Z "%~dpf0" nul') do set "ASCII_13=%%a"

set /p "=Step 1" <NUL
REM Do some stuff...

set /p "=x!ASCII_13!Step 2 " <NUL
REM do some other stuff...