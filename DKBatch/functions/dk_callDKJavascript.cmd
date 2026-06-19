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
rem # dk_callDKJavascript(function, arguments...)
rem #
rem #
:dk_callDKJavascript
%setlocal%

	set "_func_=%~1"
	set "_path_=%DKJAVASCRIPT_FUNCTIONS_DIR:\=/%/%_func_%.js"
	
	%dk_call% dk_validate DKJAVASCRIPT_FUNCTIONS_DIR  %dk_call% dk_DKBRANCH_DIR

	if NOT defined DKHTTP_DKJAVASCRIPT_DIR				(set "DKHTTP_DKJAVASCRIPT_DIR=%DKHTTP_DKBRANCH_DIR%/DKJavascript")
	if NOT defined DKHTTP_DKJAVASCRIPT_FUNCTIONS_DIR	(set "DKHTTP_DKJAVASCRIPT_FUNCTIONS_DIR=%DKHTTP_DKJAVASCRIPT_DIR%/functions")

	if NOT EXIST "%DKJAVASCRIPT_FUNCTIONS_DIR%/DK.js"	(%dk_call% dk_download "%DKHTTP_DKJAVASCRIPT_FUNCTIONS_DIR%/DK.js" "%DKJAVASCRIPT_FUNCTIONS_DIR%/DK.js")
	if NOT EXIST "%_path_%"								(%dk_call% dk_download "%DKHTTP_DKJAVASCRIPT_FUNCTIONS_DIR%/%~1.js" "%_path_%")

	%dk_call% dk_allButFirstArgs %*

	%dk_call% dk_validate cscript.exe %dk_call% dk_findFile cscript.exe
	
	set DKCOMMAND=%ComSpec% /c %cscript.exe% //D //E:javascript //H:CScript //I //NoLogo //X %DKJAVASCRIPT_FUNCTIONS_DIR%/DK.js; %DKJAVASCRIPT_FUNCTIONS_DIR%/%1.js; %dk_allButFirstArgs%
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_callDKJavascript=%dk_exec%"
		set "%_func_%=%dk_exec%"
	)
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_echo
	%dk_call% dk_callDKJavascript dk_testReturn inputA
	%dk_call% dk_echo "dk_callDKJavascript = %dk_callDKJavascript%"
	%dk_call% dk_echo "dk_testReturn = %dk_testReturn%"
	%dk_call% dk_echo
	
	%dk_call% dk_echo
	%dk_call% dk_callDKJavascript dk_basename "%USERPROFILE:\=/%/Digital Knob/Development"
	%dk_call% dk_echo "dk_callDKJavascript = %dk_callDKJavascript%"
	%dk_call% dk_echo "dk_basename = %dk_basename%"
	%dk_call% dk_echo
%endfunction%
