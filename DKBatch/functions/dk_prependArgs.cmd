@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_prependArgs(variable, string)
::#
::#
:dk_prependArgs
%setlocal%
    %dk_call% dk_debugFunc 2 99

	%dk_call% dk_allButFirstArgs %*
	
	endlocal & (
		if defined %~1 (
			set "%~1=%dk_allButFirstArgs% !%~1!"
		) else (
			set "%~1=%dk_allButFirstArgs%"
		)
	)
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_printVar myVar

    %dk_call% dk_prependArgs myVar abc 123
    %dk_call% dk_printVar myVar

    %dk_call% dk_prependArgs myVar def 456
    %dk_call% dk_printVar myVar
	
	%dk_call% dk_prependArgs myVar ghi 789
    %dk_call% dk_printVar myVar
%endfunction%
