@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_quickAccessPin("$path")
::#
::#
:dk_quickAccessPin
%setlocal%
    %dk_call% dk_debugFunc 1
	
	%dk_call% dk_callDKPowershell dk_quickAccessPin "%~1"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
  
    %dk_call% dk_quickAccessPin "%USERPROFILE:\=/%/DigitalKnob"
%endfunction%
