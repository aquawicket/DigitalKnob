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
rem # dk_DKBRANCH_DIR()
rem #
:dk_DKBRANCH_DIR
rem %setlocal%

	rem https://stackoverflow.com/a/33662275
	rem If the current folder matches the current branch set DKBRANCH. Otherwise, default to Development

rem	if "%~1" neq "" (
rem		set "DKBRANCH_DIR=%~1"
rem	)

	%dk_call% dk_validate DIGITALKNOB_DIR %dk_call% dk_DIGITALKNOB_DIR

	if NOT defined DKBRANCH  (set "DKBRANCH=Development")			&rem set the default branch
	rem for %%I in (.) do set "CURRENT_FOLDER=%%~nxI"				&rem get the current folder
	rem if NOT defined git.exe (%dk_call% dk_depend git)
	rem if EXIST "%CD%\.git" (
	rem 	"%git.exe%" "-C %DKBRANCH_DIR% branch | find "* %CURRENT_FOLDER%" > NUL & if ERRORLEVEL 0 (
	rem 		set "DKBRANCH=%CURRENT_FOLDER%"
	rem 	)
	rem )
	rem %dk_call% dk_printVar DKBRANCH
	if NOT defined DKBRANCH_DIR (set "DKBRANCH_DIR=%DIGITALKNOB_DIR%/%DKBRANCH%")

	set "DKBASH_DIR=%DKBRANCH_DIR%/DKBash"
		set "DKBASH_FUNCTIONS_DIR=%DKBASH_DIR%/functions"
		set "DKBASH_FUNCTIONS_DIR_=%DKBASH_FUNCTIONS_DIR%/"

	if NOT defined DKBATCH_DIR (set "DKBATCH_DIR=%DKBRANCH_DIR%/DKBatch")
		set "DKBATCH_FUNCTIONS_DIR=%DKBATCH_DIR%/functions"
		set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_FUNCTIONS_DIR%/"

	set "DKC_DIR=%DKBRANCH_DIR%/DKC"
		set "DKC_FUNCTIONS_DIR=%DKC_DIR%/functions"
		set "DKC_FUNCTIONS_DIR_=%DKC_FUNCTIONS_DIR%/"

	set "DKCMAKE_DIR=%DKBRANCH_DIR%/DKCMake"
		set "DKCMAKE_FUNCTIONS_DIR=%DKCMAKE_DIR%/functions"
		set "DKCMAKE_FUNCTIONS_DIR_=%DKCMAKE_FUNCTIONS_DIR%/"

	set "DKCPP_DIR=%DKBRANCH_DIR%/DKCpp"
		set "DKCPP_APPS_DIR=%DKCPP_DIR%/apps"
		set "DKCPP_FUNCTIONS_DIR=%DKCPP_DIR%/functions"
		set "DKCPP_FUNCTIONS_DIR_=%DKCPP_FUNCTIONS_DIR%/"
		set "DKCPP_PLUGINS_DIR=%DKCPP_DIR%/plugins"

	set "DKCSHARP_DIR=%DKBRANCH_DIR%/DKCSharp"
		set "DKCSHARP_FUNCTIONS_DIR=%DKCSHARP_DIR%/functions"
		set "DKCSHARP_FUNCTIONS_DIR_=%DKCSHARP_FUNCTIONS_DIR%/"

	set "DKHTA_DIR=%DKBRANCH_DIR%/DKHta"
		set "DKHTA_FUNCTIONS_DIR=%DKHTA_DIR%/functions"
		set "DKHTA_FUNCTIONS_DIR_=%DKHTA_FUNCTIONS_DIR%/"

	set "DKHTML_DIR=%DKBRANCH_DIR%/DKHtml"
		set "DKHTML_FUNCTIONS_DIR=%DKHTML_DIR%/functions"
		set "DKHTML_FUNCTIONS_DIR_=%DKHTML_FUNCTIONS_DIR%/"

	set "DKJAVA_DIR=%DKBRANCH_DIR%/DKJava"
		set "DKJAVA_FUNCTIONS_DIR=%DKJAVA_DIR%/functions"
		set "DKJAVA_FUNCTIONS_DIR_=%DKJAVA_FUNCTIONS_DIR%/"

	set "DKJAVASCRIPT_DIR=%DKBRANCH_DIR%/DKJavascript"
		set "DKJAVASCRIPT_FUNCTIONS_DIR=%DKJAVASCRIPT_DIR%/functions"
		set "DKJAVASCRIPT_FUNCTIONS_DIR_=%DKJAVASCRIPT_FUNCTIONS_DIR%/"

	set "DKPHP_DIR=%DKBRANCH_DIR%/DKPhp"
		set "DKPHP_FUNCTIONS_DIR=%DKPHP_DIR%/functions"
		set "DKPHP_FUNCTIONS_DIR_=%DKPHP_FUNCTIONS_DIR%/"

	set "DKPOWERSHELL_DIR=%DKBRANCH_DIR%/DKPowershell"
		set "DKPOWERSHELL_FUNCTIONS_DIR=%DKPOWERSHELL_DIR%/functions"
		set "DKPOWERSHELL_FUNCTIONS_DIR_=%DKPOWERSHELL_FUNCTIONS_DIR%/"

	set "DKPYTHON_DIR=%DKBRANCH_DIR%/DKPython"
		set "DKPYTHON_FUNCTIONS_DIR=%DKPYTHON_DIR%/functions"
		set "DKPYTHON_FUNCTIONS_DIR_=%DKPYTHON_FUNCTIONS_DIR%/"
		
	set "DKVBS_DIR=%DKBRANCH_DIR%/DKVbs"
		set "DKVBS_FUNCTIONS_DIR=%DKVBS_DIR%/functions"
		set "DKVBS_FUNCTIONS_DIR_=%DKVBS_FUNCTIONS_DIR%/"
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_echo
	%dk_call% dk_echo "Test Getting DKBRANCH_DIR . . ."
	%dk_call% dk_DKBRANCH_DIR
	%dk_call% dk_echo "DKBRANCH_DIR = %DKBRANCH_DIR%"

	%dk_call% dk_echo
	%dk_call% dk_echo "Test Setting DKBRANCH_DIR . . ."
	%dk_call% dk_DKBRANCH_DIR "C:/DK/Development"
	%dk_call% dk_echo "DKBRANCH_DIR = %DKBRANCH_DIR%"
%endfunction%
