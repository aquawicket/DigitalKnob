echo dk_test.cmd %*
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~f0 %*

::####################################################################
::# dk_test(args1 arg2 rtn_var)
::#
::#

:dk_test
setlocal enableDelayedExpansion
    %dk_call% dk_debugFunc 0 99

    echo ################# dk_test.cmd ################
    echo                     0 = %~0
	echo                     1 = %~1
    echo                     2 = %~2
    echo                     3 = %~3
    echo                     4 = %~4
    echo                     5 = %~5
    echo                     6 = %~6
    echo                     7 = %~7
    echo                     8 = %~8
    echo                     9 = %~9	
    echo                     * = %*
    echo            ERRORLEVEL = %ERRORLEVEL%
    echo                   LVL = %LVL%
    echo              __TIME__ = %__TIME__%
    echo              __CMND__ = %__CMND__%
    echo              __FILE__ = %__FILE__%
    echo              __LINE__ = %__LINE__%
    echo              __FUNC__ = %__FUNC__%
    echo              __ARGC__ = %__ARGC__%
    echo              __ARGV__ = %__ARGV__%
    echo         DKSCRIPT_PATH = %DKSCRIPT_PATH%
    echo          DKSCRIPT_DIR = %DKSCRIPT_DIR%
    echo         DKSCRIPT_NAME = %DKSCRIPT_NAME%
    echo          DKSCRIPT_EXT = %DKSCRIPT_EXT%
    echo         DKSCRIPT_ARGS = %DKSCRIPT_ARGS%
    echo            DKHOME_DIR = %DKHOME_DIR%
    echo           DKCACHE_DIR = %DKCACHE_DIR%
    echo         DKDESKTOP_DIR = %DKDESKTOP_DIR%
    echo           DIGITALKNOB = %DIGITALKNOB%
    echo       DIGITALKNOB_DIR = %DIGITALKNOB_DIR%
    echo        DKDOWNLOAD_DIR = %DKDOWNLOAD_DIR%
    echo           DKTOOLS_DIR = %DKTOOLS_DIR%
    echo              DKBRANCH = %DKBRANCH%
    echo          DKBRANCH_DIR = %DKBRANCH_DIR%
    echo        DK3RDPARTY_DIR = %DK3RDPARTY_DIR%
    echo            DKAPPS_DIR = %DKAPPS_DIR%
    echo            DKBASH_DIR = %DKBASH_DIR%
    echo  DKBASH_FUNCTIONS_DIR = %DKBASH_FUNCTIONS_DIR%
    echo DKBASH_FUNCTIONS_DIR_ = %DKBASH_FUNCTIONS_DIR_%
    
    set "return_value=return value from dk_test.cmd"
	
    endlocal & set "%3=%return_value%"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal enableDelayedExpansion
    %dk_call% dk_debugFunc 0
	echo dk_test.cmd :DKTEST

    %dk_call% dk_test "arg 1" "arg 2" rtn_var
    echo:
	echo:

    %dk_call% dk_echo "rtn_var = %rtn_var%"
%endfunction%
