<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::call dk_source dk_log
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


>>>>>>> Development
::################################################################################
::# dk_success(message)
::#
::#    Print a warning message to the console
::#
::#    @message - The message to print
::#
:dk_success
<<<<<<< HEAD
    call dk_debugFunc 1
 setlocal
 
=======
setlocal
	%dk_call% dk_debugFunc 1
	
>>>>>>> Development
    %dk_call% dk_log SUCCESS "%~1"
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
    %dk_call% dk_success "test dk_success message"
%endfunction%
