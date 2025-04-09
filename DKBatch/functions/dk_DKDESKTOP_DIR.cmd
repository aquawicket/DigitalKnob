@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# dk_DKDESKTOP_DIR()
::#
::#
:dk_DKDESKTOP_DIR
::setlocal
	%dk_call% dk_debugFunc 0 1
 
	::############ SET ############
	if not "%~1"=="" ( 
		set "DKDESKTOP_DIR=%~1"
		%return%
	)
	
	::############ GET ############
	%dk_call% dk_validatePath DKHOME_DIR "%dk_call% dk_DKHOME_DIR"
	set "DKDESKTOP_DIR=%DKHOME_DIR%/Desktop"

%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_echo
	%dk_call% dk_echo "Test Getting DKDESKTOP_DIR . . ."
	%dk_call% dk_DKDESKTOP_DIR
	%dk_call% dk_echo "DKDESKTOP_DIR = %DKDESKTOP_DIR%"
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Setting DKDESKTOP_DIR . . ."
	%dk_call% dk_DKDESKTOP_DIR "C:/Desktop"
	%dk_call% dk_echo "DKDESKTOP_DIR = %DKDESKTOP_DIR%"
%endfunction%
