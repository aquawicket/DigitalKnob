@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# dk_DKHOME_DIR()
::#
::#
:dk_DKHOME_DIR
 ::setlocal
	%dk_call% dk_debugFunc 0 1

	::############ SET ############
	if not "%~1"=="" ( 
		set "DKHOME_DIR=%~1"
		%return%
	)

	rem ############ GET ############
	rem ###### WSLPATH_EXE ######
	rem %dk_call% dk_set WSLPATH_EXE   "%WSL_EXE% wslpath"
	rem %dk_call% dk_printVar WSLPATH_EXE

	rem if not defined HOMEDRIVE		(!dk_call! dk_warning "HOMEDRIVE is invalid")
	rem if not defined HOMEPATH			(!dk_call! dk_warning "HOMEPATH is invalid")
	
	set "DKHOME_DIR=%USERPROFILE:\=/%"
	
	rem	if exist "!WSLPATH_EXE!"		(!dk_call! dk_commandToVariable "!WSLPATH_EXE! -u !DKHOME_DIR!" DKHOME_DIR)

	%dk_call% dk_assertPath DKHOME_DIR
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 0

	%dk_call% dk_echo
	%dk_call% dk_echo "Test Getting DKHOME_DIR . . ."
	%dk_call% dk_DKHOME_DIR
	%dk_call% dk_echo "DKHOME_DIR = %DKHOME_DIR%"
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Setting DKHOME_DIR . . ."
	%dk_call% dk_DKHOME_DIR "C:/"
	%dk_call% dk_echo "DKHOME_DIR = %DKHOME_DIR%"
%endfunction%
