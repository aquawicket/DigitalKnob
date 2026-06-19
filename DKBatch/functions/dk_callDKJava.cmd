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
:dk_callDKJava
%setlocal%

	set "_func_=%~1"
	set "_path_=%DKJAVA_FUNCTIONS_DIR:\=/%/%_func_%.java"
	
	rem ### Get DKJAVA_FUNCTIONS_DIR
	%dk_call% dk_validate DKJAVA_FUNCTIONS_DIR  %dk_call% dk_DKBRANCH_DIR
	
	rem ### Get DKHTTP_DKJAVA_FUNCTIONS_DIR
	if NOT defined DKHTTP_DKJAVA_DIR			(set "DKHTTP_DKJAVA_DIR=%DKHTTP_DKBRANCH_DIR%/DKJavas")
	if NOT defined DKHTTP_DKJAVA_FUNCTIONS_DIR	(set "DKHTTP_DKJAVA_FUNCTIONS_DIR=%DKHTTP_DKJAVA_DIR%/functions")
	
	rem ### Download files if missing
	if NOT EXIST "%DKJAVA_FUNCTIONS_DIR%/DK.js"	(%dk_call% dk_download "%DKHTTP_DKJAVA_FUNCTIONS_DIR%/DK.js"  "%DKJAVA_FUNCTIONS_DIR%/DK.js")
	if NOT EXIST "%_path_%"						(%dk_call% dk_download "%DKHTTP_DKJAVA_FUNCTIONS_DIR%/%~1.js" "%_path_%")

	%dk_call% dk_allButFirstArgs %*
	
	%dk_call% dk_validate java_exe %dk_call% dk_java_exe.cmd
	set DKCOMMAND=%ComSpec% /c %javac_exe%  %DKJAVA_FUNCTIONS_DIR%/DK.js; %DKJAVA_FUNCTIONS_DIR%/%1.js; %ALL_BUT_FIRST%
	
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_callDKJava=%dk_exec%"
		set "%_func_%=%dk_exec%"
	)
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_echo
	%dk_call% dk_callDKJava dk_testReturn inputA
	%dk_call% dk_echo "dk_callDKJava = %dk_callDKJava%"
	%dk_call% dk_echo "dk_testReturn = %dk_testReturn%"
	%dk_call% dk_echo
	
	%dk_call% dk_echo
	%dk_call% dk_callDKJava dk_basename "%USERPROFILE:\=/%/Digital Knob/Development"
	%dk_call% dk_echo "dk_callDKJava = %dk_callDKJava%"
	%dk_call% dk_echo "dk_basename = %dk_basename%"
	%dk_call% dk_echo
%endfunction%
