@echo off
setlocal
call :setVar result#(^.*)(Form Product=")([^"]*") FormType="[^"]*" FormID="([0-9][0-9]*)".*$

call :setVar result
setLocal EnableDelayedExpansion
echo setVar =  !setVar!
pause
goto :eof

:setVar <resultVar> <searchName>
:: Search the own batch file for <searchName> in a line with "REM <searchName>#"
:: Return all after the "#" without any modification
setLocal DisableDelayedExpansion
for /f "usebackq tokens=* delims=" %%G in (`findstr /n /c:"call :setVar %~1#" "%~f0"`) do (
    set "str=%%G"
)
setLocal EnableDelayedExpansion
set "str=!str:*#=!"

for /F "delims=" %%A in ("!str!") DO (
  endlocal
  endlocal
  set "setVar=%%A"
  goto :eof
)

pause
goto :eof