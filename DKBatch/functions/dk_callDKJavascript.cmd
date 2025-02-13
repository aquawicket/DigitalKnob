@echo off
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_callDKJavascript(function, arguments..., rtn_var)
::#
::#
:dk_callDKJavascript
setlocal
    %dk_call% dk_debugFunc 1 99
 
	::### Get DKJAVASCRIPT_FUNCTIONS_DIR
	%dk_call% dk_validate DKJAVASCRIPT_FUNCTIONS_DIR  "%dk_call% dk_DKBRANCH_DIR"
	if not exist "%DKJAVASCRIPT_FUNCTIONS_DIR%"			(set "DKJAVASCRIPT_FUNCTIONS_DIR=%CD%/DKJavascript/functions")
	if not exist "%DKJAVASCRIPT_FUNCTIONS_DIR%"			(mkdir "%DKJAVASCRIPT_FUNCTIONS_DIR%")
	%dk_call% dk_assertPath DKJAVASCRIPT_FUNCTIONS_DIR
	
	::### Get DKHTTP_DKJAVASCRIPT_FUNCTIONS_DIR
	if not defined DKHTTP_DKJAVASCRIPT_DIR				(set "DKHTTP_DKJAVASCRIPT_DIR=%DKHTTP_DKBRANCH_DIR%/DKJavascript")
	if not defined DKHTTP_DKJAVASCRIPT_FUNCTIONS_DIR	(set "DKHTTP_DKJAVASCRIPT_FUNCTIONS_DIR=%DKHTTP_DKJAVASCRIPT_DIR%/functions")
	
	::### Download files if missing
	if not exist %DKJAVASCRIPT_FUNCTIONS_DIR%/DK.js		(%dk_call% dk_download "%DKHTTP_DKJAVASCRIPT_FUNCTIONS_DIR%/DK.js" "%DKJAVASCRIPT_FUNCTIONS_DIR%/DK.js")
	if not exist %DKJAVASCRIPT_FUNCTIONS_DIR%/%~1.js	(%dk_call% dk_download "%DKHTTP_DKJAVASCRIPT_FUNCTIONS_DIR%/%~1.js" "%DKJAVASCRIPT_FUNCTIONS_DIR%/%~1.js")



	set "CSCRIPT_EXE=cscript.exe"
	::(set DKJAVASCRIPT_COMMAND=%COMSPEC% /c %CSCRIPT_EXE% //e:javascript "%DKJAVASCRIPT_FUNCTIONS_DIR%/DK.js" "%DKSCRIPT_PATH%")
	set DKJAVASCRIPT_COMMAND=%COMSPEC% /c %CSCRIPT_EXE% //e:javascript %DKJAVASCRIPT_FUNCTIONS_DIR%/DK.js; %DKJAVASCRIPT_FUNCTIONS_DIR%/%1.js
	
	echo DKJAVASCRIPT_COMMAND = %DKJAVASCRIPT_COMMAND%
	for /f "delims=" %%Z in ('%DKJAVASCRIPT_COMMAND%') do (
        echo %%Z                		&rem  Display the other shell's stdout
        set "dk_callDKJavascript=%%Z"	&rem  Set the return value to the last line of output
    )
	
	
	::###### run executable ######
::	%dk_call% dk_commandToVariable "%DKJAVASCRIPT_COMMAND%"
::	endlocal & (set dk_callDKC=%dk_commandToVariable%)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_callDKJavascript dk_test "FROM DKBatch" "dk_callDKJavascript.cmd"
    %dk_call% dk_echo
	if defined rtn_var (%dk_call% dk_echo "dk_callDKJavascript = %dk_callDKJavascript%")
%endfunction%
