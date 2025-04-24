@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


if not defined dk_return_PRINT (set "dk_return_PRINT=0")
if not defined dk_return (set "dk_return=dk_return")
::################################################################################
::dk_return(exit_code, message)
::#
::#		dk_return						pass
::#		dk_return -1					FIXME
::#		dk_return  1					FIXME
::#		dk_return "message"				pass
::#		dk_return  0 "message"			pass
::#		dk_return -1 "error message"	fail
::#		dk_return  1 "error message"	fail
::#
:dk_return
::setlocal enableDelayedExpansion
	::if 1%1 neq +1%1 (echo %~1 is not_numeric) else (echo %~1 is numeric)
	
	if "%~1" equ "" endlocal & (
		set "dk_return_PRINT=%dk_return_PRINT%"
		set "LAST_STATUS=%errorlevel%"
		set "LAST_FILE=!__FILENAME__!"
		set "LAST_FUNC=!__FUNC__!"
		set "LAST_ARGS=!__ARGV__!"
		set "LAST_MESSAGE=dk_return generic"
		if "%dk_return_PRINT%" equ "1" (call dk_printLastError)
	)
	if "%~2" equ "" endlocal & (
		set "dk_return_PRINT=%dk_return_PRINT%"
		set "LAST_STATUS=%errorlevel%"
		set "LAST_FILE=!__FILENAME__!"
		set "LAST_FUNC=!__FUNC__!"
		set "LAST_ARGV=!__ARGV__!"
		set "LAST_MESSAGE=%~1"
		if "%dk_return_PRINT%" equ "1" call dk_printLastError
	)
	if "%~2" neq "" endlocal & (
		set "dk_return_PRINT=%dk_return_PRINT%"
		set "LAST_STATUS=%~1"
		set "LAST_FILE=!__FILENAME__!"
		set "LAST_FUNC=!__FUNC__!"
		set "LAST_ARGV=!__ARGV__!"
		set "LAST_MESSAGE=%~2"
		if "%dk_return_PRINT%" equ "1" call dk_printLastError
	)
	
	if "%dk_return_PRINT%" equ "1" dk_printLastError

::call exit /b %LAST_STATUS%
