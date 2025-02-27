@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_callDKPython(function, arguments...)
::#
::#
:dk_callDKPython
setlocal
    %dk_call% dk_debugFunc 1 99
 
	::### Get DKPYTHON_FUNCTIONS_DIR
	%dk_call% dk_validate DKPYTHON_FUNCTIONS_DIR  "%dk_call% dk_DKBRANCH_DIR"
	
	::### Get DKHTTP_DKPYTHON_FUNCTIONS_DIR
	if not defined DKHTTP_DKPYTHON_DIR				(set "DKHTTP_DKPYTHON_DIR=%DKHTTP_DKBRANCH_DIR%/DKJavascript")
	if not defined DKHTTP_DKPYTHON_FUNCTIONS_DIR	(set "DKHTTP_DKPYTHON_FUNCTIONS_DIR=%DKHTTP_DKPYTHON_DIR%/functions")
	
	::### Download files if missing
	if not exist %DKPYTHON_FUNCTIONS_DIR%/DK.py		(%dk_call% dk_download "%DKHTTP_DKPYTHON_FUNCTIONS_DIR%/DK.py" "%DKPYTHON_FUNCTIONS_DIR%/DK.py")
	if not exist %DKPYTHON_FUNCTIONS_DIR%/%~1.py	(%dk_call% dk_download "%DKHTTP_DKPYTHON_FUNCTIONS_DIR%/%~1.py" "%DKPYTHON_FUNCTIONS_DIR%/%~1.py")

	::### ALL_BUT_FIRST ###
	set "ALL_BUT_FIRST=%*"
	if defined ALL_BUT_FIRST (set "ALL_BUT_FIRST=!ALL_BUT_FIRST:%~1 =!")
	
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate PYTHON3_EXE "%dk_call% %DKIMPORTS_DIR%/python3/dk_install.cmd"
	
	set DKPYTHON_COMMAND=%COMSPEC% /V:ON /k call "%PYTHON3_EXE%" "%DKPYTHON_FUNCTIONS_DIR%/%1.py" %ALL_BUT_FIRST%
	echo DKPYTHON_COMMAND = %DKPYTHON_COMMAND%
	::set DKPYTHON_COMMAND=%COMSPEC% /c %CSCRIPT_EXE% //D //E:javascript //H:CScript //I //NoLogo //X %DKPYTHON_FUNCTIONS_DIR%/DK.py; %DKPYTHON_FUNCTIONS_DIR%/%1.py; %ALL_BUT_FIRST%
	
	
	for /f "delims=" %%Z in ('%DKPYTHON_COMMAND%') do (
        echo %%Z                		&rem  Display the command's stdout
		set "dk_callDKPython=%%Z"		&rem  Set the return value to the last line of output
    )
	endlocal & (
		set "dk_callDKPython=%dk_callDKPython%"
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_callDKPython dk_test "arg 1" "arg 2" "arg 3"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_callDKPython = %dk_callDKPython%"
%endfunction%
