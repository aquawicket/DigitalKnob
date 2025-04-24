<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_getFileParam(file, var_name) value
::#
::# todo: add optional 3rd parameter for output value
:dk_getFileParam
    call dk_debugFunc 2
 setlocal
    
	for /f "delims== tokens=1,2" %%A in (%~1) do (
		rem echo %%A = %%B
		if "%%A" == "%~2" endlocal & set %~2=%%B
	)
	
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_getFileParam(<file> <var_name>)
::#
::# todo: add optional 3rd parameter for output value
:dk_getFileParamB
setlocal
	%dk_call% dk_debugFunc 2

	set "_file_=%~1"

	for /f "delims== tokens=1,2" %%A in (%_file_:/=\%) do (
		if "%%A" equ "%~2" (
			endlocal & (
				set "%~2=%%B"
			)
		)
	)
>>>>>>> Development
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKBRANCH_DIR"
    %dk_call% dk_getFileParam %DKIMPORTS_DIR%\git\git.txt VERSION
	%dk_call% dk_printVar VERSION
	
=======
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_getFileParam %DKBRANCH_DIR%/settings dk_call_PRINTENTRY
	%dk_call% dk_printVar dk_call_PRINTENTRY
>>>>>>> Development
%endfunction%
