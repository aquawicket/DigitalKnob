@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# Test/dk_test(args)
::#
:Test/dk_test
echo: & echo %bg_blue%-^> Test/dk_test(%*)%clr%
setlocal enableDelayedExpansion
	::%dk_call% dk_debugFunc 0 99
	
	echo ################# Test/dk_test.cmd ################
						(echo            ###### cmd variables ######)
	if not "%~0" equ ""	(echo                      0 = '%~0')
						(echo                      * = '%*')
	if not "%~1" equ ""	(echo                      1 = '%~1')
	if not "%~2" equ ""	(echo                      2 = '%~2')
	if not "%~3" equ ""	(echo                      3 = '%~3')
	if not "%~4" equ ""	(echo                      4 = '%~4')
	if not "%~5" equ ""	(echo                      5 = '%~5')
	if not "%~6" equ ""	(echo                      6 = '%~6')
	if not "%~7" equ ""	(echo                      7 = '%~7')
	if not "%~8" equ ""	(echo                      8 = '%~8')
	if not "%~9" equ ""	(echo                      9 = '%~9')
						(echo             ERRORLEVEL = '%ERRORLEVEL%')
						(echo                   DATE = '%DATE%')
						(echo                   TIME = '%TIME: =%')
						(echo                ComSpec = '%ComSpec%')
						(echo:)
						(echo             ###### DK variables ######)
						(echo                   test = '%test%')
						(echo           DKSHELL_NAME = '%DKSHELL_NAME%')
						(echo           DKSHELL_PATH = '%DKSHELL_PATH%')
						(echo        DKSHELL_VERSION = '%DKSHELL_VERSION%')
						(echo                    LVL = '%LVL%')
						(echo               __FULL__ = '%__FULL__%')
						(echo               __TIME__ = '%__TIME__%')
						(echo               __FILE__ = '%__FILE__%')
						(echo               __LINE__ = '%__LINE__%')
						(echo               __CMND__ = '%__CMND__%')
						(echo               __FUNC__ = '%__FUNC__%')
						(echo               __ARGC__ = '%__ARGC__%')
						(echo               __ARGV__ = '%__ARGV__%')
						(echo          DKSCRIPT_PATH = '%DKSCRIPT_PATH%')
						(echo           DKSCRIPT_DIR = '%DKSCRIPT_DIR%')
						(echo          DKSCRIPT_FILE = '%DKSCRIPT_FILE%')
						(echo          DKSCRIPT_NAME = '%DKSCRIPT_NAME%')
						(echo           DKSCRIPT_EXT = '%DKSCRIPT_EXT%')
						(echo          DKSCRIPT_ARGS = '%DKSCRIPT_ARGS%')
						(echo             DKHOME_DIR = '%DKHOME_DIR%')
						(echo            DKCACHE_DIR = '%DKCACHE_DIR%')
						(echo          DKDESKTOP_DIR = '%DKDESKTOP_DIR%')
						(echo            DIGITALKNOB = '%DIGITALKNOB%')
						(echo        DIGITALKNOB_DIR = '%DIGITALKNOB_DIR%')
						(echo             DKDOWNLOAD = '%DKDOWNLOAD%')
						(echo         DKDOWNLOAD_DIR = '%DKDOWNLOAD_DIR%')
						(echo                DKTOOLS = '%DKTOOLS%')
						(echo            DKTOOLS_DIR = '%DKTOOLS_DIR%')
						(echo               DKBRANCH = '%DKBRANCH%')
						(echo           DKBRANCH_DIR = '%DKBRANCH_DIR%')
						(echo             DK3RDPARTY = '%DK3RDPARTY%')
						(echo         DK3RDPARTY_DIR = '%DK3RDPARTY_DIR%')
						(echo              DKCPP_DIR = '%DKCPP_DIR%')
						(echo         DKCPP_APPS_DIR = '%DKCPP_APPS_DIR%')
						(echo    DKCPP_FUNCTIONS_DIR = '%DKCPP_FUNCTIONS_DIR%')
						(echo             DKBASH_DIR = '%DKBASH_DIR%')
						(echo   DKBASH_FUNCTIONS_DIR = '%DKBASH_FUNCTIONS_DIR%')
						(echo  DKBASH_FUNCTIONS_DIR_ = '%DKBASH_FUNCTIONS_DIR_%')
						(echo            DKBATCH_DIR = '%DKBATCH_DIR%')
						(echo  DKBATCH_FUNCTIONS_DIR = '%DKBATCH_FUNCTIONS_DIR%')
						(echo DKBATCH_FUNCTIONS_DIR_ = '%DKBATCH_FUNCTIONS_DIR_%')
						(echo:)
						(echo      ###### return values before being set ######)
						(echo                dk_test = '%dk_test%')
						(echo             RETURN_VAR = '%RETURN_VAR%')
						(echo             GLOBAL_VAR = '%GLOBAL_VAR%')

	%dk_call% dk_stacktrace

	endlocal & (
		set "dk_test=this B"
		%dk_call% setReturn RETURN_VAR "return B"
		%dk_call% setGlobal GLOBAL_VAR "global B"
	)

	%dk_call% Test/Test/dk_test "dk_test" "Test/dk_test"
	echo: & echo ### Test/Test/dk_test return values ###
	echo    dk_test = '%dk_test%'
	echo RETURN_VAR = '%RETURN_VAR%'
	echo GLOBAL_VAR = '%GLOBAL_VAR%'

::	echo: & echo ### Test/dk_test return values before end function ###
::	echo              dk_test = '%dk_test%'
::	echo           RETURN_VAR = '%RETURN_VAR%'
::	echo           GLOBAL_VAR = '%GLOBAL_VAR%'

echo %bg_blue%^<- Test/dk_test(%*)%clr% & echo:
%endfunction%








::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 0

	%dk_call% Test/dk_test ":DKTEST" "Test/dk_test" "Test:DKTEST" "1 2 3"
	echo: & echo ### Test/dk_test return values ###
	echo    dk_test = '%dk_test%'
	echo RETURN_VAR = '%RETURN_VAR%'
	echo GLOBAL_VAR = '%GLOBAL_VAR%'
%endfunction%
