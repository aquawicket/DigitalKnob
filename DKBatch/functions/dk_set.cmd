@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_set(name, value)
::#
::#
:dk_set
::    %dk_call% dk_debugFunc 1 2
:: setlocal
 
    set "%~1=%~2"
	
::DEBUG
::    %dk_call% dk_printVar %~1
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST 
    %dk_call% dk_debugFunc 0
 setlocal
 
    %dk_call% dk_set myVar "value assigned with dk_set"
    %dk_call% dk_echo "myVar = %myVar%"
	
	%dk_call% dk_set myVarB "dk_info('test dk_info message')"
	%dk_call% dk_echo "myVarB = %myVarB%"
%endfunction%
