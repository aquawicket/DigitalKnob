@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_callDKBatch(function, arguments..., rtn_var)
::#
::#   Reference: https://stackoverflow.com/questions/34451444/how-to-get-a-returned-value-from-powershell-and-get-it-in-a-batch-file
::#
:dk_callDKBatch
    %dk_call% dk_debugFunc 1 99
 setlocal
    
	%dk_call% dk_validate CMD_EXE "%dk_call% dk_CMD_EXE"
    
	:: get ALL_BUT_FIRST_ARGS
	for /f "tokens=1,* delims= " %%a in ("%*") do set ALL_BUT_FIRST_ARGS=%%b
	
	:: get LAST_ARG
	for %%a in (%*) do set LAST_ARG=%%a
	
    :: Call DKBatch function
    set DKBATCH_COMMAND="%CMD_EXE% /c "set "DKINIT=" && set "DKSCRIPT_PATH=%DKSCRIPT_PATH%" && set "DKBATCH_FUNCTIONS_DIR=%DKBATCH_FUNCTIONS_DIR%" && %~1 %ALL_BUT_FIRST_ARGS%"
    ::echo %DKBATCH_COMMAND%
	for /f "delims=" %%Z in ('%DKBATCH_COMMAND%') do (
        echo %%Z                &rem  Display the other shell's stdout
        set "rtn_value=%%Z"     &rem  Set the return value to the last line of output
	)
    ::echo rtn_value = !rtn_value!
    
	if "%LAST_ARG%" == "rtn_var" endlocal & set "%LAST_ARG%=%rtn_value%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    %dk_call% dk_debugFunc 0
 setlocal
 
	%dk_call% dk_callDKBatch dk_test "FROM DKBatch" "dk_callDKBatch.cmd" rtn_var
    %dk_call% dk_echo
	%dk_call% dk_echo "rtn_var = %rtn_var%"
%endfunction%
