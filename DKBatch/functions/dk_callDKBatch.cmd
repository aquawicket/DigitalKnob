@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_callDKBatch(function, arguments..., rtn_var)
::#
::#   Reference: https://stackoverflow.com/questions/34451444/how-to-get-a-returned-value-from-powershell-and-get-it-in-a-batch-file
::#
:dk_callDKBatch
%setlocal%
	%dk_call% dk_debugFunc 1 99

	%dk_call% dk_validate CMD_EXE "%dk_call% dk_CMD_EXE"

	::### All but first Args ###
	%dk_call% dk_allButFirstArgs %*

	::############ DKBatch function call ############
	set DKCOMMAND=%CMD_EXE% /c (set "DK.cmd=") && (set "DKSCRIPT_PATH=%DKSCRIPT_PATH%") && (set "DKBATCH_FUNCTIONS_DIR=%DKBATCH_FUNCTIONS_DIR%") && %~1 %dk_allButFirstArgs%
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_callDKCmake=%dk_exec%"
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_callDKBatch dk_test "arg 1" "arg 2" "arg 3"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_callDKBatch = %dk_callDKBatch%"
%endfunction%
