@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::##################################################################################
::# dk_todo(message)
::#
::#    Print a todo message to the console
::#
::#    @message - The message to print
::#
:dk_todo
%setlocal%
    %dk_call% dk_debugFunc 0 1


    %dk_call% dk_log TODO "%~1"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
    %dk_call% dk_todo "test dk_todo message"
%endfunction%
