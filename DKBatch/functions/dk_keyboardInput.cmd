@echo off
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::##################################################################################
::# dk_keyboardInput(variable)
::#
::#
:dk_keyboardInput
setlocal
    %dk_call% dk_debugFunc 1
    
	
    endlocal & set /p "%~1=" || (call )  			&:: NOTE:   || (call ) is added to supress onErrors
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_echo "Type some input and press enter when done"
    %dk_call% dk_keyboardInput input
    %dk_call% dk_echo "you typed '%input%'"
%endfunction%
