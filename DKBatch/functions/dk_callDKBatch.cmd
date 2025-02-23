@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_callDKBatch(function, arguments..., rtn_var)
::#
::#   Reference: https://stackoverflow.com/questions/34451444/how-to-get-a-returned-value-from-powershell-and-get-it-in-a-batch-file
::#
:dk_callDKBatch
setlocal
    %dk_call% dk_debugFunc 1 99

	%dk_call% dk_validate CMD_EXE "%dk_call% dk_CMD_EXE"
    
	set "ALL_BUT_FIRST=%*"
	if defined ALL_BUT_FIRST (set "ALL_BUT_FIRST=!ALL_BUT_FIRST:%1 =!")
	
	:: get LAST_ARG
	for %%a in (%*) do set LAST_ARG=%%a
	
    :: Call DKBatch function
    set DKBATCH_COMMAND=%CMD_EXE% /c (set "DK_CMD=") && (set "DKSCRIPT_PATH=%DKSCRIPT_PATH%") && (set "DKBATCH_FUNCTIONS_DIR=%DKBATCH_FUNCTIONS_DIR%") && %~1 %ALL_BUT_FIRST%
    ::echo %DKBATCH_COMMAND%
	for /f "delims=" %%Z in ('%DKBATCH_COMMAND%') do (
        echo %%Z                &rem  Display the other shell's stdout
        set "dk_callDKBatch=%%Z"     &rem  Set the return value to the last line of output
	)
    ::echo rtn_value = !rtn_value!
    
	endlocal & (
		set "dk_callDKBatch=%dk_callDKBatch%"
		rem if "%LAST_ARG%" == "rtn_var" (set "%LAST_ARG%=%dk_callDKBatch%")
	)
	echo dk_callDKBatch = %dk_callDKBatch%
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_callDKBatch dk_test "arg 1" "arg 2" "arg 3"
    %dk_call% dk_echo
	%dk_call% dk_echo "dk_callDKBatch = %dk_callDKBatch%"
%endfunction%
