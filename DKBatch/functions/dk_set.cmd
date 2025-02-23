@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::################################################################################
::# dk_set(name, value...)
::#
::#
:dk_set
setlocal
::	%dk_call% dk_debugFunc 2 99

	set "_name_=%~1"
	set "_args_=%*"

	if defined _args_ (set "_args_=!_args_:*%~1 =!")
	
    endlocal & (
		set "%_name_%=%_args_%"
	)
	
::DEBUG
::    %dk_call% dk_printVar %~1
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST 
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_set myVar "value assigned with dk_set"
    %dk_call% dk_echo "myVar = %myVar%"
	
	%dk_call% dk_set myVarB dk_info('test dk_info message')
	%dk_call% dk_echo "myVarB = %myVarB%"
%endfunction%
