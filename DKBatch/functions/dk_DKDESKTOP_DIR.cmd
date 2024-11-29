@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_DKDESKTOP_DIR()
::#
::#
:dk_DKDESKTOP_DIR
    call dk_debugFunc 0 1
 ::setlocal
 
	::############ SET ############
	if "%~1" neq "" ( 
		set "DKDESKTOP_DIR=%~1"
		%return%
	)
	
	::############ GET ############
	%dk_call% dk_validatePath DKHOME_DIR "%dk_call% dk_DKHOME_DIR"
	set "DKDESKTOP_DIR=%DKHOME_DIR%\Desktop"
	
	::if NOT exist "%DKDESKTOP_DIR%"   %dk_call% dk_makeDirectory "%DKDESKTOP_DIR%"
	
	::%dk_call% dk_assertPath DKDESKTOP_DIR
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Getting DKDESKTOP_DIR . . ."
	%dk_call% dk_DKDESKTOP_DIR
	%dk_call% dk_printVar DKDESKTOP_DIR
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Setting DKDESKTOP_DIR . . ."
	%dk_call% dk_DKDESKTOP_DIR "C:\Desktop"
	%dk_call% dk_printVar DKDESKTOP_DIR 
%endfunction%
