@echo off
setlocal enableDelayedExpansion

set "string=     1 2 3     "
echo|set /P='!string!'

echo.
pause