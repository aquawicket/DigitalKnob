@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_test(args1 arg2 rtn_var)
::#
::#
:dk_test
    call dk_debugFunc 0 99
 setlocal
  
    echo "################# dk_test.cmd ################"
    echo "                    0 = %0"
    echo "                    * = %*"
    echo "           ERRORLEVEL = %ERRORLEVEL%"
    echo "             __TIME__ = %__TIME__%"
    echo "           __CALLER__ = %__CALLER__%"
    echo "             __FILE__ = %__FILE__%"
    echo "             __LINE__ = %__LINE__%"
    echo "         __FUNCTION__ = %__FUNCTION__%"
    echo "             __ARGC__ = %__ARGC__%"
    echo "             __ARGV__ = %__ARGV__%"
    echo "        DKSCRIPT_PATH = %DKSCRIPT_PATH%"
    echo "         DKSCRIPT_DIR = %DKSCRIPT_DIR%"
    echo "        DKSCRIPT_NAME = %DKSCRIPT_NAME%"
    echo "         DKSCRIPT_EXT = %DKSCRIPT_EXT%"
    echo "        DKSCRIPT_ARGS = %DKSCRIPT_ARGS%"
    echo "           DKHOME_DIR = %DKHOME_DIR%"
    echo "          DKCACHE_DIR = %DKCACHE_DIR%"
    echo "        DKDESKTOP_DIR = %DKDESKTOP_DIR%"
    echo "          DIGITALKNOB = %DIGITALKNOB%"
    echo "      DIGITALKNOB_DIR = %DIGITALKNOB_DIR%"
    echo "       DKDOWNLOAD_DIR = %DKDOWNLOAD_DIR%"
    echo "          DKTOOLD_DIR = %DKTOOLD_DIR%"
    echo "             DKBRANCH = %DKBRANCH%"
    echo "         DKBRANCH_DIR = %DKBRANCH_DIR%"
    echo "       DK3RDPARTY_DIR = %DK3RDPARTY_DIR%"
    echo "           DKAPPS_DIR = %DKAPPS_DIR%"
    echo "           DKBASH_DIR = %DKBASH_DIR%"
    echo " DKBASH_FUNCTIONS_DIR = %DKBASH_FUNCTIONS_DIR%"
    echo "DKBASH_FUNCTIONS_DIR_ = %DKBASH_FUNCTIONS_DIR_%"
    
    set "return_value=return value from dk_test.cmd"
    
    endlocal & set "rtn_var=%return_value%"
    echo "%return_value%"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_test "arg 1" "arg 2" rtn_var
    %dk_call% dk_echo
	%dk_call% dk_echo "rtn_var = '%rtn_var%'"
%endfunction%
