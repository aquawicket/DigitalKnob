@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::##################################################################################
::# dk_keyboardInput(variable)
::#
::#
:dk_keyboardInput
%setlocal%
    %dk_call% dk_debugFunc 1
    
    endlocal & (
		set "dk_keyboardInput="
		set /p "dk_keyboardInput=" || (call )  			&:: NOTE:   || (call ) is added to supress onErrors
		if "%~1" neq "" (set "%~1=!dk_keyboardInput!")
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_echo "Type some input and press enter when done"
    %dk_call% dk_keyboardInput
    %dk_call% dk_echo "you typed '%dk_keyboardInput%'"
%endfunction%
