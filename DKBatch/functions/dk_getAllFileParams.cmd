@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

if not defined dk_getAllFileParams_PRINT_VARIABLES (set "dk_getAllFileParams_PRINT_VARIABLES=0")
::################################################################################
::# dk_getAllFileParams(<file>)
::#
:dk_getAllFileParams
setlocal
	%dk_call% dk_debugFunc 2

	set "_file_=%~1"

	for /f "delims== tokens=1,2" %%A in (%_file_:/=\%) do (
		set "B=%%B"
		set "B=!B:${=%%!"
		set "B=!B:}=%%!"
		if "%dk_getAllFileParams_PRINT_VARIABLES%" equ "1" (
			echo %%A = !B!
		)
		endlocal & (
			set "%%A=!B!"
		)
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_getAllFileParams %DKBRANCH_DIR%/DKBatch/apps/DKBuilder/dkconfig.txt
	%dk_call% dk_printVar dk_call_PRINTCALLS
%endfunction%
