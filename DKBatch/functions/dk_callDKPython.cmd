@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_callDKPython(function, arguments...)
::#
::#
:dk_callDKPython
%setlocal%
	%dk_call% dk_debugFunc 1 99

	::### Get DKPYTHON_FUNCTIONS_DIR
	%dk_call% dk_validate DKPYTHON_FUNCTIONS_DIR  "%dk_call% dk_DKBRANCH_DIR"

	::### Get DKHTTP_DKPYTHON_FUNCTIONS_DIR
	if not defined DKHTTP_DKPYTHON_DIR				(set "DKHTTP_DKPYTHON_DIR=%DKHTTP_DKBRANCH_DIR%/DKJavascript")
	if not defined DKHTTP_DKPYTHON_FUNCTIONS_DIR	(set "DKHTTP_DKPYTHON_FUNCTIONS_DIR=%DKHTTP_DKPYTHON_DIR%/functions")

	::### Download files if missing
	if not exist %DKPYTHON_FUNCTIONS_DIR%/DK.py		(%dk_call% dk_download "%DKHTTP_DKPYTHON_FUNCTIONS_DIR%/DK.py" "%DKPYTHON_FUNCTIONS_DIR%/DK.py")
	if not exist %DKPYTHON_FUNCTIONS_DIR%/%~1.py	(%dk_call% dk_download "%DKHTTP_DKPYTHON_FUNCTIONS_DIR%/%~1.py" "%DKPYTHON_FUNCTIONS_DIR%/%~1.py")

	::### All but first Args ###
	%dk_call% dk_allButFirstArgs %*
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate PYTHON3_EXE 	"%dk_call% %DKIMPORTS_DIR%/python3/DKINSTALL.cmd"
	%dk_call% dk_validate CMD_EXE "dk_CMD_EXE.cmd"
	
	::set DKPYTHON_COMMAND=%ComSpec% /c %CSCRIPT_EXE% //D //E:javascript //H:CScript //I //NoLogo //X %DKPYTHON_FUNCTIONS_DIR%/DK.py; %DKPYTHON_FUNCTIONS_DIR%/%1.py; %ALL_BUT_FIRST%

	::############ DKPython function call ############
	set DKPYTHON_COMMAND=%ComSpec% /V:ON /c call "%PYTHON3_EXE:\=/%" "%DKPYTHON_FUNCTIONS_DIR:\=/%/%1.py" %dk_allButFirstArgs% &:: %ALL_BUT_FIRST%
	%dk_call% dk_exec %DKPYTHON_COMMAND%
	endlocal & (
		set "dk_callDKPython=%dk_exec%"
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_callDKPython dk_test "arg 1" "arg 2" "arg 3"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_callDKPython = %dk_callDKPython%"
%endfunction%
