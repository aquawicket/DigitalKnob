@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_test(args1 arg2 rtn_var)
::#
::#
:dk_test
    call dk_debugFunc 0 99
 setlocal
 
	echo "dk_test(%*)"
	
	::set count=0
	::for %%a in (%*) do set /a count+=1
	for %%a in (%*) do set last_arg=%%a
	
	set "rtn_value=return value"
	if "%last_arg%" == "rtn_var" endlocal & set "%last_arg%=%rtn_value%" && echo %rtn_value%
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_test "arg 1" "arg 2" rtn_var
	
	::%dk_call% dk_getDefaultGateway rtn_var

	
	echo rtn_var = '%rtn_var%'

%endfunction%
