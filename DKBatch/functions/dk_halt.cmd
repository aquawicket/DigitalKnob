<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::################################################################################
::# dk_halt()
::#
::#
:dk_halt
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
=======
setlocal
	%dk_call% dk_debugFunc 0

>>>>>>> Development
    call:HALT %NO_STDERR%
    :HALT
        %dk_call% dk_echo "%red%###### HALT ######%clr%"
        ()
%endfunction%

::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
=======
setlocal
	%dk_call% dk_debugFunc 0

>>>>>>> Development
    %dk_call% dk_echo "calling dk_halt on next line"
    %dk_call% dk_halt
    %dk_call% dk_echo "this is the line after halt"
%endfunction%
