@echo off
setlocal

:::loop
::set /p "dk_keyboardInput="
for /F %%I in ('cmd /c echo test ^> \\.\pipe\TestPipe') do set msg=%%~I
echo Client recieved %msg%
::goto:loop

pause
exit /b 0