:: file:///C:/Users/Administrator/Digital Knob/Development/DKJavascript/functions/dk_echo.js.cmd
:: file:///C:/Users/Administrator/Digital Knob/Development/DKJavascript/functions/dk_echo.WSCRIPT.cmd
:: file:///C:/Users/Administrator/Digital Knob/Development/DKJavascript/functions/dk_echo.js
@echo off
setlocal EnableDelayedExpansion
:: file:///C:/Users/Administrator/Digital Knob/Development/DKJavascript/functions/dk_echo.js.cmd";

set "file=%USERPROFILE:\=/%/Digital Knob/Development/DKJavascript/functions/dk_echo.js"

if "%~1" neq "" (
	call :%~1
	pause
	exit /b %errorlevel%
)
:main
	:: file:///C:/Users/Administrator/Digital Knob/Development/DKCMake/functions/dk_echo.cmake
	::"C:\Users\Administrator\AppData\Local\Programs\Opera\opera.exe" "data:text/html,<a href='javascript:window.open("file:///C:/Users/Administrator/DigitalKnob/Development/DKJavascript/functions/dk_echo.js")'>Click me</a>"
	::javascript:file:///C:/Users/Administrator/Digital Knob/Development/DKJavascript/functions/dk_echo.js
	::"C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe" javascript:"file:///%file%"
	::"C:\Users\Administrator\AppData\Local\Programs\Opera\opera.exe" javascript:"file:///%file%"
	call :CSCRIPT
	call :WSCRIPT
	call :MSHTA
exit /b %errorlevel%





::############ CSCRIPT ############
:: file:///C:/Users/Administrator/Digital Knob/Development/DKJavascript/functions/dk_echo.CSCRIPT.cmd
:CSCRIPT
	echo ########### CSCRIPT ############
	set COMMAND=cscript.exe //E:Javascript "%file%"
	!COMMAND!
	echo.
	exit /b %errorlevel%
:END_CSCRIPT

::############ WSCRIPT ############
:: file:///C:/Users/Administrator/Digital Knob/Development/DKJavascript/functions/dk_echo.WSCRIPT.cmd
:WSCRIPT
	echo ########### WSCRIPT ############
	set COMMAND=wscript.exe "%file%"
	%COMMAND% | for /f "delims=" %%a in ('findstr "^"') do @echo %%a
	echo.
	exit /b %errorlevel%
:END_WSCRIPT

::############ MSHTA ############
:: file:///C:/Users/Administrator/Digital Knob/Development/DKJavascript/functions/dk_echo.MSHTA.cmd
:MSHTA
	echo ########### MSHTA ############
	set COMMAND=mshta.exe "javascript:(1, eval)((new ActiveXObject('Scripting.FileSystemObject')).OpenTextFile('%file%', 1).ReadAll());"
	%COMMAND% | for /f "delims=" %%a in ('findstr "^"') do @echo %%a
	echo.
	exit /b %errorlevel%
:END_MSHTA

pause