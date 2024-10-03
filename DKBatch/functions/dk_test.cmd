@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_test(args1 arg2 rtn_var)
::#
::#
:dk_test
    call dk_debugFunc 0 99
 setlocal
 
	%dk_call% dk_echo "DKSCRIPT_PATH = %DKSCRIPT_PATH%"
	%dk_call% dk_echo "DKSCRIPT_DIR  = %DKSCRIPT_DIR%"
	%dk_call% dk_echo "DKSCRIPT_NAME = %DKSCRIPT_NAME%"
	%dk_call% dk_echo "DKSCRIPT_EXT  = %DKSCRIPT_EXT%"
	%dk_call% dk_echo "__FILE__      = %__FILE__%"
	%dk_call% dk_echo "__LINE__      = %__LINE__%"
	%dk_call% dk_echo "__FUNCTION__  = %__FUNCTION__%"
	%dk_call% dk_echo "__ARGC__      = %__ARGC__%"
::	%dk_call% dk_echo "__ARGV__      = %__ARGV__%"
	%dk_call% dk_echo "__CALLER__    = %__CALLER__%"
	
	endlocal & set "rtn_var=value from dk_test.cmd"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_test "arg 1" "arg 2" rtn_var
	%dk_call% dk_echo "rtn_var = '%rtn_var%'"
	
	%return%
%endfunction%
