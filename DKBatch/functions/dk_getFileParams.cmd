@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

if not defined dk_getAllFileParams_PRINT_VARIABLES (set "dk_getAllFileParams_PRINT_VARIABLES=0")
::################################################################################
::# dk_getFileParams(<file>)
::#
:dk_getFileParams
::setlocal
	%dk_call% dk_debugFunc 2

	set "_file_=%~1"

	for /f "delims== tokens=1,2" %%A in (%_file_:/=\%) do (
		set "B=%%B"
		set "B=!B:${=%%!"
		set "B=!B:}=%%!"
		if "%dk_getAllFileParams_PRINT_VARIABLES%" equ "1" (
			echo %%A = !B!
		)
		rem endlocal & (
			echo "%%A=!B!"
			set "%%A=!B!"
		rem )
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_getFileParams %DKBRANCH_DIR%/DKBatch/apps/DKBuilder/dkconfig.txt
	%dk_call% dk_printVar dk_call_PRINTCALLS
%endfunction%
