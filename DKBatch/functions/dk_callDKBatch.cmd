<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::####################################################################
::# dk_callDKBatch(function, arguments..., rtn_var)
::#
::#   Reference: https://stackoverflow.com/questions/34451444/how-to-get-a-returned-value-from-powershell-and-get-it-in-a-batch-file
::#
:dk_callDKBatch
<<<<<<< HEAD
    call dk_debugFunc 1 99
 setlocal
    
    set "CMD_EXE=cmd.exe"
    
    
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
=======
setlocal
	%dk_call% dk_debugFunc 1 99

	%dk_call% dk_validate CMD_EXE "%dk_call% dk_CMD_EXE"

	set "ALL_BUT_FIRST=%*"
	if defined ALL_BUT_FIRST (set "ALL_BUT_FIRST=!ALL_BUT_FIRST:%1 =!")

	:: get LAST_ARG
	for %%a in (%*) do set LAST_ARG=%%a

	:: Call DKBatch function
	set DKBATCH_COMMAND=%CMD_EXE% /c (set "DK.cmd=") && (set "DKSCRIPT_PATH=%DKSCRIPT_PATH%") && (set "DKBATCH_FUNCTIONS_DIR=%DKBATCH_FUNCTIONS_DIR%") && %~1 %ALL_BUT_FIRST%
	%dk_call% dk_exec %DKBATCH_COMMAND%
	endlocal & (
		set "dk_callDKCmake=%dk_exec%"
	)
>>>>>>> Development
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
	%dk_call% dk_callDKBatch dk_test "FROM DKBatch" "dk_callDKBatch.cmd" rtn_var
    %dk_call% dk_echo
	%dk_call% dk_echo "rtn_var = %rtn_var%"
=======
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_callDKBatch dk_test "arg 1" "arg 2" "arg 3"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_callDKBatch = %dk_callDKBatch%"
>>>>>>> Development
%endfunction%
