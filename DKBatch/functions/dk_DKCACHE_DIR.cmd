@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# dk_DKCACHE_DIR()
::#
::#
:dk_DKCACHE_DIR
::setlocal
	%dk_call% dk_debugFunc 0 1
 
	::############ SET ############
	if not "%~1" equ "" ( 
		set "DKCACHE_DIR=%~1"
		%return%
	)
	
	::############ GET ############
	%dk_call% dk_validatePath DKHOME_DIR "%dk_call% dk_DKHOME_DIR"
	set "DKCACHE_DIR=%DKHOME_DIR%/.dk"
	
	if NOT exist "%DKCACHE_DIR%" (%dk_call% dk_mkdir "%DKCACHE_DIR%")
	
	%dk_call% dk_assertPath DKCACHE_DIR
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_echo
	%dk_call% dk_echo "Test Getting DKCACHE_DIR . . ."
	%dk_call% dk_DKCACHE_DIR
	%dk_call% dk_printVar DKCACHE_DIR
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Setting DKCACHE_DIR . . ."
	%dk_call% dk_DKCACHE_DIR "C:/.dk"
	%dk_call% dk_printVar DKCACHE_DIR 
%endfunction%
