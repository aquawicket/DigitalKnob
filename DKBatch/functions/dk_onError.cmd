@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################
::https://ss64.com/nt/syntax-error.html

::SomeCommand && (
::  Echo success
::) || (
::  Echo failed/error
::)

::set "dk_onError=&& (echo success) || (echo error)



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
  
    set "dk_onError=&& (%dk_call% dk_echo "success") || (%dk_call% dk_error "error")"
    set "dk_onError=&& (echo success) || (echo error)"
   
    (call ) %dk_onError%
    (call) %dk_onError%
%endfunction%
