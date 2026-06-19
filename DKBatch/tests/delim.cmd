@echo off
setlocal EnableDelayedExpansion

set "x=Here, There and Everywhere"

call :StrPos "er" "%x%"
call :StrPos "here" "%x%"
pause
goto :EOF


:StrPos Delim String
setlocal EnableDelayedExpansion

set "x=%~2"
if not defined x echo/& echo No string& exit /B
set "v=%~1"
if not defined v echo/& echo No delimiter& exit /B
call :strLen v k=
set /A i=-k
set "x2="
set "w=!x:%~1=" ^& call :strLen w j ^& set /A i+=j+k ^& set "x2=¡x2¡,¡i¡" ^& set "w=!"
set "w=%w:¡=!%"
if defined x2 set "x2=%x2:~1%"
echo %~2
echo Substring "%~1" at positions: %x2%
exit /B


:strLen var len=
setlocal EnableDelayedExpansion
set "str=0!%1!"
set "%2=0"
for /L %%a in (8,-1,0) do (
   set /A "newLen=%2+(1<<%%a)"
   for %%b in (!newLen!) do if "!str:~%%b,1!" neq "" set "%2=%%b"
)
for %%a in (!%2!) do endlocal & set "%2=%%a"
exit /B