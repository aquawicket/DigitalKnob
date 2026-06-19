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
rem # dk_callDKVbs(function, arguments...)
rem #
rem #
:dk_callDKVbs
%setlocal%

	rem ### Get DKVBS_FUNCTIONS_DIR
	%dk_call% dk_validate DKVBS_FUNCTIONS_DIR  %dk_call% dk_DKBRANCH_DIR

	rem ### Get DKHTTP_DKVBS_FUNCTIONS_DIR
	if NOT defined DKHTTP_DKVBS_DIR				(set "DKHTTP_DKVBS_DIR=%DKHTTP_DKBRANCH_DIR%/DKVbs")
	if NOT defined DKHTTP_DKVBS_FUNCTIONS_DIR	(set "DKHTTP_DKVBS_FUNCTIONS_DIR=%DKHTTP_DKVBS_DIR%/functions")
	rem ### Download files if missing
	if NOT EXIST "%DKVBS_FUNCTIONS_DIR%/DK.vbs"	(%dk_call% dk_download "%DKHTTP_DKVBS_FUNCTIONS_DIR%/DK.vbs" "%DKVBS_FUNCTIONS_DIR%/DK.vbs")
	if NOT EXIST "%DKVBS_FUNCTIONS_DIR%/%~1.vbs"	(%dk_call% dk_download "%DKHTTP_DKVBS_FUNCTIONS_DIR%/%~1.vbs" "%DKVBS_FUNCTIONS_DIR%/%~1.vbs")

	rem ### All but first Args ###
	%dk_call% dk_allButFirstArgs %*
	
	%dk_call% dk_validate cscript.exe %dk_call% dk_findFile cscript.exe
	
	rem ############ DKVbs function call ############
	set DKCOMMAND=%ComSpec% /c %cscript.exe% //D //E:VBScript //H:CScript //I //NoLogo //X %DKVBS_FUNCTIONS_DIR%/DK.vbs; %DKVBS_FUNCTIONS_DIR%/%1.vbs; %dk_allButFirstArgs%
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_callDKVbs=%dk_exec%"
	)

%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_callDKVbs dk_test "arg 1" "arg 2" "arg 3"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_callDKVbs = %dk_callDKVbs%"
%endfunction%
