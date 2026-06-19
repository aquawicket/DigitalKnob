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


rem #####################################################################
rem # dk_validateDK()
rem #
rem #
:dk_validateDK
rem %setlocal%

	%dk_call% dk_validate DIGITALKNOB_DIR  %dk_call% dk_DIGITALKNOB_DIR
	if NOT defined DKBRANCH               (set "DKBRANCH=Development")
	if NOT defined DKBRANCH_DIR           (set "DKBRANCH_DIR=%DIGITALKNOB_DIR%/%DKBRANCH%")
	
	if EXIST "%DKBRANCH_DIR%/.git"        (if /i "%DKSCRIPT_NAME%" neq "DKBuilder" %return%)
	if EXIST "%DKBRANCH_DIR%/.git"        (if /i "%DKSCRIPT_DIR%" equ "%DKBRANCH_DIR%" %return%)

  if NOT EXIST "%DKBRANCH_DIR%/.git"    (%dk_call% dk_gitUpdate "%REPO_URL%" "%DKBRANCH%")
	
	if "%DKSCRIPT_NAME%" equ "DKBuilder"    (set "DKSCRIPT_PATH=%DKBRANCH_DIR%/%DKSCRIPT_NAME%%DKSCRIPT_EXT%")
	if NOT EXIST "%DKSCRIPT_PATH%"        (%dk_call% dk_fatal "DKSCRIPT_PATH:'%DKSCRIPT_PATH%' NOT FOUND")
	
	if /i "%DKSCRIPT_NAME%" equ "DKBuilder" (set "DKSCRIPT_ARGS=%DKSCRIPT_PATH%")
	for %%Z in ("%DKSCRIPT_PATH%") do     (set "DKSCRIPT_DIR=%%~dpZ")
	if "%DKSCRIPT_DIR:~-1%" equ "\"         (set "DKSCRIPT_DIR=%DKSCRIPT_DIR:~0,-1%")
	if "%DKSCRIPT_DIR:~-1%" equ "/"         (set "DKSCRIPT_DIR=%DKSCRIPT_DIR:~0,-1%")
	set "RELOADED="
	
	rem set "DKSCRIPT_DIR=%DKBRANCH_DIR%"
	rem set "DKSCRIPT_NAME="
	rem set "DKSCRIPT_EXT="
	rem set "DKBATCH_DIR="
	rem set "DKBATCH_FUNCTIONS_DIR=%DKBRANCH_DIR%\DKBatch\functions"
	rem set "DKBATCH_FUNCTIONS_DIR_="
	rem set "DKASSETS_DIR="
	
	exit /b 1
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
   
    %dk_call% dk_validateDK
%endfunction%
