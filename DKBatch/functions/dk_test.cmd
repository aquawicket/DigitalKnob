@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_test(args1 arg2 rtn_var)
::#
::#
:dk_test
    call dk_debugFunc 0 99
 setlocal
  
    %dk_call% dk_echo "################# dk_test.cmd ################"
    %dk_call% dk_echo "                    0 = %~0"
                 echo "                    * = %*
    %dk_call% dk_echo "           ERRORLEVEL = %ERRORLEVEL%"
    %dk_call% dk_echo "             __TIME__ = %__TIME__%"
    %dk_call% dk_echo "           __CALLER__ = %__CALLER__%"
    %dk_call% dk_echo "             __FILE__ = %__FILE__%"
    %dk_call% dk_echo "             __LINE__ = %__LINE__%"
    %dk_call% dk_echo "         __FUNCTION__ = %__FUNCTION__%"
    %dk_call% dk_echo "             __ARGC__ = %__ARGC__%"
                 echo "             __ARGV__ = %__ARGV__%"
    %dk_call% dk_echo "        DKSCRIPT_PATH = %DKSCRIPT_PATH%"
    %dk_call% dk_echo "         DKSCRIPT_DIR = %DKSCRIPT_DIR%"
    %dk_call% dk_echo "        DKSCRIPT_NAME = %DKSCRIPT_NAME%"
    %dk_call% dk_echo "         DKSCRIPT_EXT = %DKSCRIPT_EXT%"
                 echo "        DKSCRIPT_ARGS = %DKSCRIPT_ARGS%"
    %dk_call% dk_echo "           DKHOME_DIR = %DKHOME_DIR%"
    %dk_call% dk_echo "          DKCACHE_DIR = %DKCACHE_DIR%"
    %dk_call% dk_echo "        DKDESKTOP_DIR = %DKDESKTOP_DIR%"
    %dk_call% dk_echo "          DIGITALKNOB = %DIGITALKNOB%"
    %dk_call% dk_echo "      DIGITALKNOB_DIR = %DIGITALKNOB_DIR%"
    %dk_call% dk_echo "       DKDOWNLOAD_DIR = %DKDOWNLOAD_DIR%"
    %dk_call% dk_echo "          DKTOOLD_DIR = %DKTOOLD_DIR%"
    %dk_call% dk_echo "             DKBRANCH = %DKBRANCH%"
    %dk_call% dk_echo "         DKBRANCH_DIR = %DKBRANCH_DIR%"
    %dk_call% dk_echo "       DK3RDPARTY_DIR = %DK3RDPARTY_DIR%"
    %dk_call% dk_echo "           DKAPPS_DIR = %DKAPPS_DIR%"
    %dk_call% dk_echo "           DKBASH_DIR = %DKBASH_DIR%"
    %dk_call% dk_echo " DKBASH_FUNCTIONS_DIR = %DKBASH_FUNCTIONS_DIR%"
    %dk_call% dk_echo "DKBASH_FUNCTIONS_DIR_ = %DKBASH_FUNCTIONS_DIR_%"
    
    set "return_value=return value from dk_test.cmd"
    echo %return_value%
    endlocal & set "%3=%return_value%"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_test "arg 1" "arg 2" rtn_var
    %dk_call% dk_echo
	%dk_call% dk_echo "rtn_var = %rtn_var%"
%endfunction%
