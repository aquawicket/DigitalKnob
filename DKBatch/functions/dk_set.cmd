@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_set(name, value)
::#
::#
:dk_set
    call dk_debugFunc 1 2
:: setlocal
 
    set "%~1=%~2"
	
::debug
    %dk_call% dk_printVar %1
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST 
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_set myVar "value assigned with dk_set"
    %dk_call% dk_echo "myVar = %myVar%"
%endfunction%
