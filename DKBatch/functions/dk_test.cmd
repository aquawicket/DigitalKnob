@echo off
if not defined DK_CMD call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~f0 %*

::####################################################################
::# dk_test(args)
::#
:dk_test
echo -^> dk_test(%*)
setlocal enableDelayedExpansion
	::%dk_call% dk_debugFunc 0 99
	
	echo:
	echo ################# dk_test.cmd ################
	echo ### cmd variables ###
	if not "%~0"=="" (echo                     0 = '%~0')
	if not "%~1"=="" (echo                     1 = '%~1')
	if not "%~2"=="" (echo                     2 = '%~2')
	if not "%~3"=="" (echo                     3 = '%~3')
	if not "%~4"=="" (echo                     4 = '%~4')
	if not "%~5"=="" (echo                     5 = '%~5')
	if not "%~6"=="" (echo                     6 = '%~6')
	if not "%~7"=="" (echo                     7 = '%~7')
	if not "%~8"=="" (echo                     8 = '%~8')
	if not "%~9"=="" (echo                     9 = '%~9')
	echo                     * = '%*'
	echo            ERRORLEVEL = '%ERRORLEVEL%'
	echo                  DATE = '%DATE%'
	echo                  TIME = '%TIME%'
	echo               COMSPEC = '%COMSPEC%'
	echo:
	echo ### DK variables ###
	echo                    LVL = '%LVL%'
	echo               __TIME__ = '%__TIME__%'
	echo               __CMND__ = '%__CMND__%'
	echo               __FILE__ = '%__FILE__%'
	echo               __LINE__ = '%__LINE__%'
	echo               __FUNC__ = '%__FUNC__%'
	echo               __ARGC__ = '%__ARGC__%'
	echo               __ARGV__ = '%__ARGV__%'
	echo          DKSCRIPT_PATH = '%DKSCRIPT_PATH%'
	echo           DKSCRIPT_DIR = '%DKSCRIPT_DIR%'
	echo          DKSCRIPT_FILE = '%DKSCRIPT_FILE%'
	echo          DKSCRIPT_NAME = '%DKSCRIPT_NAME%'
	echo           DKSCRIPT_EXT = '%DKSCRIPT_EXT%'
	echo          DKSCRIPT_ARGS = '%DKSCRIPT_ARGS%'
	echo             DKHOME_DIR = '%DKHOME_DIR%'
	echo            DKCACHE_DIR = '%DKCACHE_DIR%'
	echo          DKDESKTOP_DIR = '%DKDESKTOP_DIR%'
	echo            DIGITALKNOB = '%DIGITALKNOB%'
	echo        DIGITALKNOB_DIR = '%DIGITALKNOB_DIR%'
	echo             DKDOWNLOAD = '%DKDOWNLOAD%'
	echo         DKDOWNLOAD_DIR = '%DKDOWNLOAD_DIR%'
	echo                DKTOOLS = '%DKTOOLS%'
	echo            DKTOOLS_DIR = '%DKTOOLS_DIR%'
	echo               DKBRANCH = '%DKBRANCH%'
	echo           DKBRANCH_DIR = '%DKBRANCH_DIR%'
	echo             DK3RDPARTY = '%DK3RDPARTY%'
	echo         DK3RDPARTY_DIR = '%DK3RDPARTY_DIR%'
	echo              DKCPP_DIR = '%DKCPP_DIR%'
	echo         DKCPP_APPS_DIR = '%DKCPP_APPS_DIR%'
	echo    DKCPP_FUNCTIONS_DIR = '%DKCPP_FUNCTIONS_DIR%'
	echo             DKBASH_DIR = '%DKBASH_DIR%'
	echo   DKBASH_FUNCTIONS_DIR = '%DKBASH_FUNCTIONS_DIR%'
	echo  DKBASH_FUNCTIONS_DIR_ = '%DKBASH_FUNCTIONS_DIR_%'
	echo            DKBATCH_DIR = '%DKBATCH_DIR%'
	echo  DKBATCH_FUNCTIONS_DIR = '%DKBATCH_FUNCTIONS_DIR%'
	echo DKBATCH_FUNCTIONS_DIR_ = '%DKBATCH_FUNCTIONS_DIR_%'
	echo:
	echo ### return values before setting ###
	echo               dk_test = '%dk_test%'
	echo            RETURN_VAR = '%RETURN_VAR%'
	echo            GLOBAL_VAR = '%GLOBAL_VAR%'
	
	endlocal & (
		set "dk_test=this A"
		%dk_call% setReturn RETURN_VAR "return A"
		%dk_call% setGlobal GLOBAL_VAR "global A"
	)
	
	echo:
	echo ### return values before end function ###
	echo              dk_test = '%dk_test%'
	echo           RETURN_VAR = '%RETURN_VAR%'
	echo           GLOBAL_VAR = '%GLOBAL_VAR%'
	
echo ^<- dk_test(%*)
%endfunction%








::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal enableDelayedExpansion
	::%dk_call% dk_debugFunc 0

	%dk_call% dk_test "from :DKTEST" "to dk_test"
	echo:
	echo ### dk_test return values ###
	echo    dk_test = '%dk_test%'
	echo RETURN_VAR = '%RETURN_VAR%'
	echo GLOBAL_VAR = '%GLOBAL_VAR%'
	echo:

	%dk_call% Test::dk_test "from :DKTEST" "to Test::dk_test"
	echo:
	echo ### Test::dk_test return values ###
	echo    dk_test = '%dk_test%'
	echo RETURN_VAR = '%RETURN_VAR%'
	echo GLOBAL_VAR = '%GLOBAL_VAR%'

	%dk_call% Test::Test::dk_test "from :DKTEST" "to Test::Test::dk_test"
	echo:
	echo ### Test::Test::dk_test return values ###
	echo    dk_test = '%dk_test%'
	echo RETURN_VAR = '%RETURN_VAR%'
	echo GLOBAL_VAR = '%GLOBAL_VAR%'
%endfunction%
