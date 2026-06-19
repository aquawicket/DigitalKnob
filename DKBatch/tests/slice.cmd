@echo off
setlocal EnableDelayedExpansion

rem set "str=1.0.2.25"
rem set "vars=Major Minor Revision Subrev"
rem set "p=%%"
rem set "v=%vars: =" & set "s=!str:*.=!" & call set "!v!=!p!str:.!s!=!p!" & set "str=!s!" & set "v=%" & set "!v!=!s!"
rem echo Major: %Major%, Minor: %Minor%, Revision: %Revision%, Subrev: %Subrev%
set str=Paul=Thomas
echo.
echo str: %str%
call :ReplaceEqual %str%
echo str = %str%
pause

set "vars=Name Value"
set "p=%%"
set "v=%vars: =" & set "s=!str:*.=!" & call set "!v!=!p!str:.!s!=!p!" & set "str=!s!" & set "v=%" & set "!v!=!s!"
echo Name:%Name%, Value:%Value%

pause
exit /b

:ReplaceEqual
  set str=%1.%2
exit /b

pause