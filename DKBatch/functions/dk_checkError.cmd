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
::# dk_checkError()
::#
:dk_checkError
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    if %ERRORLEVEL% equ 0 %return%
    %dk_call% dk_error "ERRORLEVEL = %ERRORLEVEL%"
=======
setlocal
	%dk_call% dk_debugFunc 0

	if %ERRORLEVEL% equ 0 %return%
	%dk_call% dk_error "ERRORLEVEL = %ERRORLEVEL%"
>>>>>>> Development
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_checkError
=======
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_checkError
>>>>>>> Development
%endfunction%
