@echo off
setlocal enabledelayedexpansion

:main()
	::###### Load Function files ######
	call "../functions/DK.cmd"

	set funcA=(call :funcA echo test)
	%funcA%
	echo funcA = %funcA%

	pause
goto:eof



:funcA () {
	::for /f "usebackq tokens=*" %%a in (`echo Test`) do my_command %%a
	%* > bla.txt
	set /p VV=<bla.txt
	set funcA=%VV%
	
	::FOR /F "usebackq" %%x IN (`%*`) DO set "funcA=%%x"
goto:eof

:funcB () {
	echo 1 = %1
	!%1!
	echo funcB(%*)
goto:eof

pause