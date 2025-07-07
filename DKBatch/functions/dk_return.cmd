::@echo off&::###### DK.cmd #########################################################################################################################
::if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
::if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################

::echo:
::if "%~1" neq "" (echo 1 = %~1)
::if "!errorlevel!" neq "" (echo errorlevel = !errorlevel!)
::if "!LAST_STATUS!" neq "" (echo LAST_STATUS = !LAST_STATUS!)


::if not defined dk_return_PRINT_SUCCESS (set "dk_return_PRINT_SUCCESS=1")
if not defined dk_return_PRINT_ERRORS (set "dk_return_PRINT_ERRORS=1")
if not defined dk_return (set "dk_return=%dk_call% dk_return")

::################################################################################
::dk_return(exit_code, message)
::#
::#		dk_return						pass
::#		dk_return  0					pass
::#		dk_return "message"				pass
::#		dk_return  0 "message"			pass
::#		dk_return -1					error
::#		dk_return  1					error
::#		dk_return -1 "error message"	error
::#		dk_return  1 "error message"	error
::#
:dk_return
%setlocal%

	set "arg1=%~1"
	set "arg2=%~2"
	if defined %~1 (set "arg1=!%~1!")
	
	if not defined arg1 (goto :endNumCheck)
	set "arg1=%arg1:.=%"
	set "arg1=%arg1:+=%"
	if %arg1:-=% equ +%arg1:-=% (set "arg1IsNumber=1")
	:endNumCheck

	::##### No Parameters ######
	if not defined arg1 (

		rem echo ##### No Parameters ######
		set "LAST_STATUS=!errorlevel!"
		set "LAST_MESSAGE="
	
	rem ##### 1 Parameter ######
	) else if not defined arg2 (

		rem echo ##### 1 Parameter ######
		if defined arg1IsNumber (
			set "LAST_STATUS=%~1"
			set "LAST_MESSAGE="
		) else (
			set "LAST_STATUS=!errorlevel!"
			set "LAST_MESSAGE=%~1"
		)

	rem ##### 2 Parameters ######
	) else if defined arg2 (

		rem echo ##### 2 Parameters ######
		set "LAST_STATUS=%~1"
		set "LAST_MESSAGE="
	)

	set "dk_return_PRINT=!dk_return_PRINT!"
	set "LAST_FILE=!__FILENAME__!"
	set "LAST_FUNC=!__FUNC__!"
	set "LAST_ARGS=!__ARGV__!"
		
	if "%dk_return_PRINT_SUCCESS%" equ "1" (
		if "!LAST_STATUS!" equ "0"	(echo "!LAST_FUNC!(!LAST_ARGV!) %green%!LAST_STATUS! '!LAST_MESSAGE!' %clr%")
	) 
	if "%dk_return_PRINT_ERRORS%" equ "1" (
		if "!LAST_STATUS!" neq "0"	(echo "!LAST_FUNC!(!LAST_ARGV!):%red%!LAST_STATUS! '!LAST_MESSAGE!' %clr%")
	)
	
::exit /b !LAST_STATUS! & set "LAST_STATUS="
exit /b 0