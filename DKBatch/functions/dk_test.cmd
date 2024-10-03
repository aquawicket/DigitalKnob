@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_test(args1 arg2 rtn_var)
::#
::#
:dk_test
    call dk_debugFunc 0 99
 setlocal
 
    echo ########## dk_test.cmd ##########
    echo  0 = %0
    echo  * = %*
	echo  DKSCRIPT_PATH = %DKSCRIPT_PATH%
	echo  DKSCRIPT_DIR  = %DKSCRIPT_DIR%
	echo  DKSCRIPT_NAME = %DKSCRIPT_NAME%
	echo  DKSCRIPT_EXT  = %DKSCRIPT_EXT%
	echo  __FILE__      = %__FILE__%
	echo  __LINE__      = %__LINE__%
	echo  __FUNCTION__  = %__FUNCTION__%
	echo  __ARGC__      = %__ARGC__%
	echo  __ARGV__      = %__ARGV__%
	echo  __CALLER__    = %__CALLER__%
    echo  ERRORLEVEL    = %ERRORLEVEL%
	
	endlocal & set "rtn_var=value from dk_test.cmd"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_test "arg 1" "arg 2" rtn_var
    %dk_call% dk_echo
	%dk_call% dk_echo "rtn_var = '%rtn_var%'"
%endfunction%
