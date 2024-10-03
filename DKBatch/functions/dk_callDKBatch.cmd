@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_callDKBatch(function, arguments..., return_args...)
::#
::#   Reference: https://stackoverflow.com/questions/34451444/how-to-get-a-returned-value-from-powershell-and-get-it-in-a-batch-file
::#
:dk_callDKBatch
    call dk_debugFunc 1 99
 setlocal

	:: get ALL_BUT_FIRST_ARGS
	for /f "tokens=1,* delims= " %%a in ("%*") do set ALL_BUT_FIRST_ARGS=%%b
	
	:: get LAST_ARG
	for %%a in (%*) do set LAST_ARG=%%a
	
	set "CMD_EXE=cmd.exe"
	::echo '%CMD_EXE% /c "set "DKINIT=" && set "DKSCRIPT_PATH=%DKSCRIPT_PATH%" && set "DKBATCH_FUNCTIONS_DIR=%DKBATCH_FUNCTIONS_DIR%" && %~1 %ALL_BUT_FIRST_ARGS%"'
	for /f "delims=" %%Z in ('%CMD_EXE% /c "set "DKINIT=" && set "DKSCRIPT_PATH=%DKSCRIPT_PATH%" && set "DKBATCH_FUNCTIONS_DIR=%DKBATCH_FUNCTIONS_DIR%" && %~1 %ALL_BUT_FIRST_ARGS%"') do (
		set "rtn_value=%%Z"
	)

	if "%LAST_ARG%" == "rtn_var" endlocal & set "%LAST_ARG%=%rtn_value%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
	%dk_call% dk_callDKBatch dk_test "arg 1" "arg 2" rtn_var
	echo rtn_var = '%rtn_var%'
%endfunction%
