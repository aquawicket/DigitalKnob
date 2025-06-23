@echo off
if "%minimized%" equ "1" goto :minimized
set minimized=1
start /min cmd /C "%~dpnx0"
goto:eof
:minimized
::###############################################################
::#  Anything after here will run in a minimized window





set sleep_time=60
set /a "seconds=(%sleep_time%+1)"
ping 127.0.0.1 -n %seconds%






