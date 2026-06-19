@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ####################################################################
rem # dk_test(args)
rem #
:dk_test
rem echo. & echo %bg_blue%-^> dk_test(%*)%clr%
%setlocal%

	set "dk_test=Return value from dk_test.cmd"
	
	echo ################# dk_test.cmd ################
					(echo                dk_test = %dk_test%)
					(echo            ###### cmd variables ######)
	if "%~0" neq ""	(echo                      0 = %0)
					(echo                      * = %*)
	if "%~1" neq ""	(echo                      1 = %1)
	if "%~2" neq ""	(echo                      2 = %2)
	if "%~3" neq ""	(echo                      3 = %3)
	if "%~4" neq ""	(echo                      4 = %4)
	if "%~5" neq ""	(echo                      5 = %5)
	if "%~6" neq ""	(echo                      6 = %6)
	if "%~7" neq ""	(echo                      7 = %7)
	if "%~8" neq ""	(echo                      8 = %8)
	if "%~9" neq ""	(echo                      9 = %9)
					(echo             ERRORLEVEL = %ERRORLEVEL%)
					(echo                   DATE = %DATE%)
					(echo                   TIME = %TIME: =%)
					(echo                ComSpec = %ComSpec%)
					(echo.)
					(echo             ###### DK variables ######)
					(echo                 DK.cmd = %DK.cmd%)
					(echo           DKSHELL_NAME = %DKSHELL_NAME%)
					(echo           DKSHELL_PATH = %DKSHELL_PATH%)
					(echo        DKSHELL_VERSION = %DKSHELL_VERSION%)
					(echo                    LVL = %LVL%)
					(echo               __FULL__ = %__FULL__%)
					(echo               __TIME__ = %__TIME__%)
					(echo               __FILE__ = %__FILE__%)
					(echo               __LINE__ = %__LINE__%)
					(echo               __CMND__ = %__CMND__%)
					(echo               __FUNC__ = %__FUNC__%)
					(echo               __ARGC__ = %__ARGC__%)
					(echo               __ARGV__ = %__ARGV__%)
					(echo          DKSCRIPT_PATH = %DKSCRIPT_PATH%)
					(echo           DKSCRIPT_DIR = %DKSCRIPT_DIR%)
					(echo          DKSCRIPT_FILE = %DKSCRIPT_FILE%)
					(echo          DKSCRIPT_NAME = %DKSCRIPT_NAME%)
					(echo           DKSCRIPT_EXT = %DKSCRIPT_EXT%)
					(echo          DKSCRIPT_ARGS = %DKSCRIPT_ARGS%)
					(echo             DKHOME_DIR = %DKHOME_DIR%)
					(echo            DKCACHE_DIR = %DKCACHE_DIR%)
					(echo          DKDESKTOP_DIR = %DKDESKTOP_DIR%)
					(echo            DIGITALKNOB = %DIGITALKNOB%)
					(echo        DIGITALKNOB_DIR = %DIGITALKNOB_DIR%)
					(echo             DKDOWNLOAD = %DKDOWNLOAD%)
					(echo         DKDOWNLOAD_DIR = %DKDOWNLOAD_DIR%)
					(echo                DKTOOLS = %DKTOOLS%)
					(echo            DKTOOLS_DIR = %DKTOOLS_DIR%)
					(echo               DKBRANCH = %DKBRANCH%)
					(echo           DKBRANCH_DIR = %DKBRANCH_DIR%)
					(echo             DK3RDPARTY = %DK3RDPARTY%)
					(echo         DK3RDPARTY_DIR = %DK3RDPARTY_DIR%)
					(echo              DKCPP_DIR = %DKCPP_DIR%)
					(echo         DKCPP_APPS_DIR = %DKCPP_APPS_DIR%)
					(echo    DKCPP_FUNCTIONS_DIR = %DKCPP_FUNCTIONS_DIR%)
					(echo             DKBASH_DIR = %DKBASH_DIR%)
					(echo   DKBASH_FUNCTIONS_DIR = %DKBASH_FUNCTIONS_DIR%)
					(echo  DKBASH_FUNCTIONS_DIR_ = %DKBASH_FUNCTIONS_DIR_%)
					(echo            DKBATCH_DIR = %DKBATCH_DIR%)
					(echo  DKBATCH_FUNCTIONS_DIR = %DKBATCH_FUNCTIONS_DIR%)
					(echo DKBATCH_FUNCTIONS_DIR_ = %DKBATCH_FUNCTIONS_DIR_%)
					(echo.)
					
	%dk_call% Test/dk_test "dk_test" "Test/dk_test"
	echo Test/dk_test = '%Test/dk_test%'
	
	:return
	endlocal & (
		set "dk_test=%dk_test%"
		if /i "%~1" equ "RTN_VAR" (
			set "%~1=%dk_test%"
		) else (
			echo %dk_test%
		)
	)
	
	exit /b 2
rem echo %bg_blue%^<- dk_test(%*)%clr% & echo.
%endfunction%








rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
rem	%dk_call% dk_test ":DKTEST" "dk_test" ":DKTEST" "1 2 3"
rem	echo      dk_test = '%dk_test%'
	
	set command=dk_test
	for /f "usebackq delims=" %%G in (`call %command% 2^>^&1 ^& call echo ExItCoDe%%^^errorlevel%%`) do (
		set "line=%%G"
		if "!line:ExItCoDe=!" neq "!line!" (
			set ExItCoDe=!line:ExItCoDe=!
		) else (
			echo !line!
			set ReTuRnVaL=!line!
		)
	)
	
	echo.
	echo.
	echo ReTuRnVaL = %ReTuRnVaL%
	echo ExItCoDe = %ExItCoDe%
	exit /b %ExItCoDe%
%endfunction%
