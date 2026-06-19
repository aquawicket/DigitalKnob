@echo off
echo.Current User is '%USERNAME%'

rem -- Let's make sure this batch runs as Administrator --
set "RunAsUser=Administrator"
if "%USERNAME%" NEQ "%RunAsUser%" (
    RUNAS /user:%RunAsUser% "cmd /c %~f0"||PAUSE
    GOTO:EOF
)

rem -- your code goes below here --
echo.Hello World
 
ECHO.&PAUSE&GOTO:EOF
