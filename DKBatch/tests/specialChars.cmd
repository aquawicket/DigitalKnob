@echo off
setlocal
call :setVar (^.*)(Form Product=")([^"]*") FormType="[^"]*" FormID="([0-9][0-9]*)".*$
call :setVar "' ` ( ) ! \ / [ ] . ^ , ; = ? | < > & * ~ @ $ % ^ { } - _ "
::call :setVar "' ` ( ) ! \ / [ ] . ^ , ; = ? | < > & * ~ @ $ % ^ # { } - _ #"

setLocal EnableDelayedExpansion
echo setVar = '!setVar!'
pause
goto :eof



:: Search the own batch file for <searchName> in a line with "call :setVar "
:setVar <resultVar> <searchName>
	setLocal DisableDelayedExpansion
	for /f "usebackq tokens=* delims=" %%G in (`findstr /B /c:"call :setVar " "%~f0"`) do (
		set "str=%%G"
	)

	setLocal EnableDelayedExpansion
	set str=!str:call :setVar =!
	echo !str!
	set "str=!str:*#=!"

	for /F "delims=" %%A in ("!str!") DO (
	  endlocal
	  endlocal
	  set "setVar=%%A"
	  goto :eof
	)

	pause
goto :eof