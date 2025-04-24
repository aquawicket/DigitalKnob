<<<<<<< HEAD
@echo off
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


>>>>>>> Development
if "%~1" neq "" goto %~1

:main
	echo this is a string echoed from bat_echo
%endfunction%

:hour
	set hour=%time:~0,2%
<<<<<<< HEAD
	if "%hour:~0,1%" == " " set hour=0%hour:~1,1%
=======
	if "%hour:~0,1%" equ " " set hour=0%hour:~1,1%
>>>>>>> Development
	echo %hour%
%endfunction%

:minute
	set minute=%time:~3,2%
<<<<<<< HEAD
	if "%minute:~0,1%" == " " set minute=0%minute:~1,1%
=======
	if "%minute:~0,1%" equ " " set minute=0%minute:~1,1%
>>>>>>> Development
	echo %minute%
%endfunction%

:second
	set second=%time:~6,2%
<<<<<<< HEAD
	if "%second:~0,1%" == " " set second=0%second:~1,1%
=======
	if "%second:~0,1%" equ " " set second=0%second:~1,1%
>>>>>>> Development
	echo %second%
%endfunction%

:millisecond
	set millisecond=%time:~9,2%
<<<<<<< HEAD
	if "%millisecond:~0,1%" == " " set millisecond=0%millisecond:~1,1%
=======
	if "%millisecond:~0,1%" equ " " set millisecond=0%millisecond:~1,1%
>>>>>>> Development
	echo %millisecond%
%endfunction%