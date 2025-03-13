@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)


::set "dk_returnError_PRINT=1"
::################################################################################
::dk_returnError()
::#
::#		dk_return						pass
::#		dk_return "success"				pass
::#		dk_return -1					pass
::#		dk_return  0 "success"			pass
::#		dk_return -1 "error"			fail
::#
:dk_returnError
	endlocal & (
		if not defined dk_returnError (set "dk_returnError=dk_returnError")
		
rem		if "%~2"=="" (
rem			set "_exit_status_=0"
rem			set "_exit_string_=%~1"
rem		) else (
rem			set "_exit_status_=%~1"
rem			set "_exit_string_=%~2"
rem		)

		if "%~2"=="" (
			set "LAST_ERROR_STATUS=-1"
			set "LAST_ERROR=%~1"
		) else (
			set "LAST_ERROR_STATUS=%~1"
			set "LAST_ERROR=%~2"
		)
		if "%dk_returnError_PRINT%"=="1" (
			%dk_call% dk_echo "%red%### dk_returnError_PRINT ###%clr%"
			%dk_call% dk_printLastError
		)
	)
exit /b %LAST_ERROR_STATUS%
