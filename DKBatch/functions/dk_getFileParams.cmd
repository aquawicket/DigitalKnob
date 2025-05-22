@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################

::############ dk_getFileParams settings #########################################
::if not defined dk_getAllFileParams_PRINT_VARIABLES (set "dk_getFileParams_PRINT_VARIABLES=1")
::################################################################################
::# dk_getFileParams(<file>)
::#
:dk_getFileParams
::%setlocal%
	%dk_call% dk_debugFunc 2

	set "_file_=%~1"

	if "%dk_getFileParams_PRINT_VARIABLES%" equ "1" (
		echo:
		echo ### %_file_% Parameters ###
	)
	
	::### Remove comments from line
	set "line=todo"
	for /f "tokens=*" %%G in (%_file_:/=\%) do (
		set "line= %%G"
		for /f "delims=#" %%i in ("!line!") do (set "line=%%i")
		set line=!line:~1!
		rem echo line = !line!
		for /f "delims== tokens=1,2" %%A in ("!line!") do (
			set "Value=%%B"
			set "Value=!Value:${=%%!"
			set "Value=!Value:}=%%!"
			if "%dk_getFileParams_PRINT_VARIABLES%" equ "1" (
				echo %%A = '!Value!'
			)
			set "%%A=!Value!"
		)
	)
	
	if "%dk_getFileParams_PRINT_VARIABLES%" equ "1" (
		echo:
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	set "dk_getFileParams_PRINT_VARIABLES=1"
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_getFileParams "%DKBRANCH_DIR%/dkconfig.txt"
%endfunction%
