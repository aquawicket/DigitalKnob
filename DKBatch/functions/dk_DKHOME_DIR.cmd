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
::# dk_DKHOME_DIR()
::#
::#
:dk_DKHOME_DIR
<<<<<<< HEAD
    call dk_debugFunc 0
:: setlocal

    if defined DKHOME_DIR %return%
    
	::###### WSLPATH_EXE ######
	::%dk_call% dk_set WSLPATH_EXE   "%WSL_EXE% wslpath"
	::%dk_call% dk_printVar WSLPATH_EXE

    if not defined HOMEDRIVE        %dk_call% dk_warning "HOMEDRIVE is invalid"
    if not defined HOMEPATH         %dk_call% dk_warning "HOMEPATH is invalid"
	
	::### DKHOME_DIR ###
    set "DKHOME_DIR=%USERPROFILE%"
	if exist "%WSLPATH_EXE%"        %dk_call% dk_commandToVariable "%WSLPATH_EXE% -u %DKHOME_DIR%" DKHOME_DIR
    if not exist "%DKHOME_DIR%"     %dk_call% dk_fatal "DKHOME_DIR:%DKHOME_DIR% does not exist"
	
	::### DKCACHE_DIR ###
	set "DKCACHE_DIR=%DKHOME_DIR%\.dk"
	if not exist "%DKCACHE_DIR%"    %dk_call% dk_makeDirectory "%DKCACHE_DIR%"
	
	::### DKDESKTOP_DIR ###
	set "DKDESKTOP_DIR=%DKHOME_DIR%\Desktop"
    if not exist %DKDESKTOP_DIR%    %dk_call% dk_fatal "DKDESKTOP_DIR:%DKDESKTOP_DIR% does not exist"
	
	::### DKTEMP_DIR ###
::	if NOT exist "%DKTEMP_DIR%"    %dk_call% dk_set DKTEMP_DIR "%TMP%"
::	if NOT exist "%DKTEMP_DIR%"    %dk_call% dk_set DKTEMP_DIR "%TMPDIR%"
::	if NOT exist "%DKTEMP_DIR%"    %dk_call% dk_set DKTEMP_DIR "%TMP_DIR%"
::	if NOT exist "%DKTEMP_DIR%"    %dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR" && %dk_call% dk_set DKTEMP_DIR "%DIGITALKNOB_DIR%"
::	if NOT exist "%DKTEMP_DIR%"    %dk_call% dk_fatal "unable to set .dk directory"
::	set "DKTEMP_DIR=%DKTEMP_DIR%\.dk"
::	if NOT exist "%DKTEMP_DIR%"    dk_makeDirectory "%DKTEMP_DIR%"
=======
 ::setlocal
	%dk_call% dk_debugFunc 0 1

	::############ SET ############
	if not "%~1" equ "" ( 
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
	
	rem	if exist "!WSLPATH_EXE!"		(!dk_call! dk_exec "!WSLPATH_EXE! -u !DKHOME_DIR!" DKHOME_DIR)

	%dk_call% dk_assertPath DKHOME_DIR
>>>>>>> Development
%endfunction%



<<<<<<< HEAD



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_DKHOME_DIR
    %dk_call% dk_printVar DKHOME_DIR
=======
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
>>>>>>> Development
%endfunction%
