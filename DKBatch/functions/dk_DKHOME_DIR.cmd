@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_DKHOME_DIR()
::#
::#
:dk_DKHOME_DIR
    call dk_debugFunc 0 1
:: setlocal

    ::if defined DKHOME_DIR %return%
    
	::############ SET ############
	if "%~1" neq "" ( 
		set "DKHOME_DIR=%~1"

	rem ############ GET ############
	) else (

		rem ###### WSLPATH_EXE ######
		rem %dk_call% dk_set WSLPATH_EXE   "%WSL_EXE% wslpath"
		rem %dk_call% dk_printVar WSLPATH_EXE

		if not defined HOMEDRIVE        !dk_call! dk_warning "HOMEDRIVE is invalid"
		if not defined HOMEPATH         !dk_call! dk_warning "HOMEPATH is invalid"
		
		rem ### DKHOME_DIR ###
		set "DKHOME_DIR=!USERPROFILE!"
		if exist "!WSLPATH_EXE!"        !dk_call! dk_commandToVariable "!WSLPATH_EXE! -u !DKHOME_DIR!" DKHOME_DIR
		if not exist "!DKHOME_DIR!"     !dk_call! dk_fatal "DKHOME_DIR:!DKHOME_DIR! does not exist"
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Getting DKHOME_DIR . . ."
	%dk_call% dk_DKHOME_DIR
	%dk_call% dk_printVar DKHOME_DIR
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Setting DKHOME_DIR . . ."
	%dk_call% dk_DKHOME_DIR "C:\"
	%dk_call% dk_printVar DKHOME_DIR 
%endfunction%
