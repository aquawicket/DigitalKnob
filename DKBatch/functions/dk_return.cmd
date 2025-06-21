@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


if not defined dk_return_PRINT (set "dk_return_PRINT=1")
if not defined dk_return (set "dk_return=dk_return")


::################################################################################
::dk_return(exit_code, message)
::#
::#		dk_return						pass
::#		dk_return  0					pass
::#		dk_return -1					error
::#		dk_return  1					error
::#		dk_return "message"				pass
::#		dk_return  0 "message"			pass
::#		dk_return -1 "error message"	error
::#		dk_return  1 "error message"	error
::#
:dk_return
::%setlocal%

	set "arg1=%~1"
	if defined %~1 (set "arg1=!%~1!")
	if not defined arg1 (
		goto :endNumCheck
	)
	set "arg1=%arg1:.=%"
	set "arg1=%arg1:+=%"
	if %arg1:-=% equ +%arg1:-=% (
		set "arg1IsNumber=0"
	)
	:endNumCheck

	::##### No Parameters ######
	if "%~1" equ "" (
		set "dk_return_PRINT=%dk_return_PRINT%"
		set "LAST_STATUS=!errorlevel!"
		set "LAST_FILE=!__FILENAME__!"
		set "LAST_FUNC=!__FUNC__!"
		set "LAST_ARGS=!__ARGV__!"
		set "LAST_MESSAGE=dk_return generic"
	
	rem ##### 1 Parameter ######
	) else if "%~2" equ "" (
		if defined arg1IsNumber (
			echo IS NUMBER
			set "LAST_STATUS=%~1"
			set "LAST_MESSAGE=dk_return generic"
		) else (
			echo IS NOT NUMBER
			set "LAST_STATUS=!errorlevel!"
			set "LAST_MESSAGE=%~1"
		)
		echo LAST_STATUS = !LAST_STATUS!
		echo LAST_MESSAGE = !LAST_MESSAGE!
	
		set "dk_return_PRINT=%dk_return_PRINT%"
		set "LAST_FILE=!__FILENAME__!"
		set "LAST_FUNC=!__FUNC__!"
		set "LAST_ARGV=!__ARGV__!"
	
	rem ##### 2 Parameters ######
	) else if "%~2" neq "" (
		set "dk_return_PRINT=%dk_return_PRINT%"
		set "LAST_STATUS=%~1"
		set "LAST_FILE=!__FILENAME__!"
		set "LAST_FUNC=!__FUNC__!"
		set "LAST_ARGV=!__ARGV__!"
		set "LAST_MESSAGE=%~2"
	)
	
	if "%dk_return_PRINT%" equ "1" (
		if "!LAST_STATUS!" equ "0"	echo "%green%!LAST_FUNC!(!LAST_ARGV!) exit:!LAST_STATUS! '!LAST_MESSAGE!' %clr%"
		if "!LAST_STATUS!" neq "0"	echo "%red%!LAST_FUNC!(!LAST_ARGV!) ERROR:!LAST_STATUS! '!LAST_MESSAGE!' %clr%"
	)
call exit /b %LAST_STATUS%

:isNumber
setlocal enableDelayedExpansion

	SET number=%1
	if 1%1 EQU +1%1 echo positive number
	if %1==-%number:-=% echo negative number
exit /b 0
