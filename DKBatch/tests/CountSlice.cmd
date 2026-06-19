@echo off
setlocal EnableDelayedExpansion


call :Split "10225" "Major:1 Minor:1 Revision:1 Subrev:2"
rem The result should be Major:1, Minor:0, Revision:2, Subrev:25
echo Major: %Major%, Minor: %Minor%, Revision: %Revision%, Subrev: %Subrev%


for /F "tokens=2 delims==" %%t in ('wmic os get localdatetime /value') do set "dateTime=%%t"
echo/
echo DateTime: %dateTime%
call :Split "%dateTime%" "Year:4 Month:2 Day:2 Hour:2 Minute:2 Second:2 _:7 Offset:4"
echo Year:%Year%  Month:%Month%  Day:%Day%  Hour:%Hour%  Minute:%Minute%  Second:%Second%  Offset:%Offset%

pause
goto :EOF



:Split string "var1:len1 var2:len2 ..."
set "str=%~1" & set "vars=%~2 " & set "p=%%"
set "v=%vars: =" & set "len=!v:*:=!" & call set "name=!p!v::!len!=!p!" & call set "!name!=!p!str:~0,!len!!p!" & call set "str=!p!str:~!len!!p!" & set "v=%"
exit /B


