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
::# dk_verbose(message)
::#
::#    Print a verbose message to the console
::#
::#    @message - The message to print
::#
:dk_verbose
<<<<<<< HEAD
    call dk_debugFunc 1
 setlocal
 
=======
setlocal
	%dk_call% dk_debugFunc 1
	
>>>>>>> Development
    %dk_call% dk_log VERBOSE "%~1"
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
    %dk_call% dk_verbose "test dk_verbose message"
%endfunction%
