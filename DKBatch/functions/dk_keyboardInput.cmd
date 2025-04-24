<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::##################################################################################
::# dk_keyboardInput(variable)
::#
::#
:dk_keyboardInput
<<<<<<< HEAD
 setlocal
    call dk_debugFunc 1
    
    %dk_call% dk_unset %~1
    set /p "%~1=" 
=======
setlocal
    %dk_call% dk_debugFunc 1
    
	
    endlocal & set /p "%~1=" || (call )  			&:: NOTE:   || (call ) is added to supress onErrors
>>>>>>> Development
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
    %dk_call% dk_echo "Type some input and press enter when done"
    %dk_call% dk_keyboardInput input
    %dk_call% dk_echo "you typed '%input%'"
%endfunction%
