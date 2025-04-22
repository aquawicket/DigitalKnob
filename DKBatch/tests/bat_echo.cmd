@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


if "%~1" neq "" goto %~1

:main
	echo this is a string echoed from bat_echo
%endfunction%

:hour
	set hour=%time:~0,2%
	if "%hour:~0,1%" equ " " set hour=0%hour:~1,1%
	echo %hour%
%endfunction%

:minute
	set minute=%time:~3,2%
	if "%minute:~0,1%" equ " " set minute=0%minute:~1,1%
	echo %minute%
%endfunction%

:second
	set second=%time:~6,2%
	if "%second:~0,1%" equ " " set second=0%second:~1,1%
	echo %second%
%endfunction%

:millisecond
	set millisecond=%time:~9,2%
	if "%millisecond:~0,1%" equ " " set millisecond=0%millisecond:~1,1%
	echo %millisecond%
%endfunction%