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
rem # dk_callDKHta(function, arguments...)
rem #
rem #
:dk_callDKHta
%setlocal%

	rem ### Get DKHTA_FUNCTIONS_DIR
	%dk_call% dk_validate DKHTA_FUNCTIONS_DIR  %dk_call% dk_DKBRANCH_DIR

	rem ### Get DKHTTP_DKHTA_FUNCTIONS_DIR
	if NOT defined DKHTTP_DKHTA_DIR				(set "DKHTTP_DKHTA_DIR=%DKHTTP_DKBRANCH_DIR%/DKHTA")
	if NOT defined DKHTTP_DKHTA_FUNCTIONS_DIR	(set "DKHTTP_DKHTA_FUNCTIONS_DIR=%DKHTTP_DKHTA_DIR%/functions")
	
	rem ### Download files if missing
	rem if NOT EXIST "%DKHTA_FUNCTIONS_DIR%/DK.hta"	(%dk_call% dk_download "%DKHTTP_DKHTA_FUNCTIONS_DIR%/DK.hta" "%DKHTA_FUNCTIONS_DIR%/DK.hta")
	rem if NOT EXIST "%DKHTA_FUNCTIONS_DIR%/%~1.hta"	(%dk_call% dk_download "%DKHTTP_DKHTA_FUNCTIONS_DIR%/%~1.hta" "%DKHTA_FUNCTIONS_DIR%/%~1.hta")

	rem ### All but first Args ###
	%dk_call% dk_allButFirstArgs %*

rem	%dk_call% dk_validate mshta.exe %dk_call% dk_findFile mshta.exe
	
	rem ############ DKHta function call ############
	set DKCOMMAND=%ComSpec% /c %DKHTA_FUNCTIONS_DIR%/%1.hta; %dk_allButFirstArgs%
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_callDKHta=%dk_exec%"
	)

%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_callDKHta dk_test "arg 1" "arg 2" "arg 3"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_callDKHta = %dk_callDKHta%"
%endfunction%
