@echo off
%dkbatch%
setlocal ENABLEDELAYEDEXPANSION

set "string=Windows Push Notifications User Service"

echo #### Windows Services containing "%string%" ####
sc queryex type= service state= all | find /i %string%


:: output of command to a variable
::for /f "delims=" %%i in ('command') do set output=%%i




:: last 5 chaacters of the string
::set "substring=%i~-5%"
::echo "%substring%"