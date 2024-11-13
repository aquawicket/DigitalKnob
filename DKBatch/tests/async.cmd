@echo off
if not "%~1"=="" goto %~1
:MAIN
	setlocal
	echo Here I am in the MAIN thread
	start "" /B cmd /D /C "%~f0" :ASYNC
	echo Here I am in the MAIN thread again
	endlocal
	
	call :loop
	echo at end of MAIN
	pause
exit /b 0

:ASYNC
	setlocal
	echo Now I am in the ASYNC thread
	
	set /P REPLY="Press a key"
	echo you pressed %REPLY%
	::timeout /T 10
	endlocal

	echo at end of ASYNC
exit /b 0

echo should not get here