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
rem # dk_callDKPhp(function, arguments...)
rem #
rem #
:dk_callDKPhp
%setlocal%

	set "_func_=%~1"
	set "_path_=%DKPHP_FUNCTIONS_DIR:\=/%/%_func_%.php"
	
	%dk_call% dk_validate php_exe %dk_call% dk_depend php-src
	%dk_call% dk_assertPath php_exe
	
	%dk_call% dk_validate DKPHP_FUNCTIONS_DIR		%dk_call% dk_DKBRANCH_DIR
	%dk_call% dk_assertPath DKPHP_FUNCTIONS_DIR

	if NOT defined DKHTTP_DKPHP_DIR					(set "DKHTTP_DKPHP_DIR=%DKHTTP_DKBRANCH_DIR%/DKPhp")
	if NOT defined DKHTTP_DKPHP_FUNCTIONS_DIR		(set "DKHTTP_DKPHP_FUNCTIONS_DIR=%DKHTTP_DKPHP_DIR%/functions")

	rem ### Download files if missing
	if NOT EXIST "%DKPHP_FUNCTIONS_DIR%/DK.php"		(%dk_call% dk_download "%DKHTTP_DKPHP_FUNCTIONS_DIR%/DK.php" "%DKPHP_FUNCTIONS_DIR%/DK.php")
	if NOT EXIST "%_path_%"							(%dk_call% dk_download "%DKHTTP_DKPHP_FUNCTIONS_DIR%/%_func_%.php" "%_path_%")

	%dk_call% dk_allButFirstArgs %*
	
	set "PAUSE_ON_EXIT=0"
	
	set DKCOMMAND="%php_exe%" "%_path_%" %dk_allButFirstArgs%
	
	set "dk_exec_ECHO_OUTPUT=0"
	set "dk_exec_ECHO_ERROR=0"
rem set "dk_exec_PRINT_CALL=1" 			&rem dk_exec_call
rem set "dk_exec_PRINT_COMMAND=1" 		&rem dk_exec_command
rem set "dk_exec_PRINT_EXITCODES=1"		&rem dk_exec_exitcodes
rem set "dk_exec_PRINT_EXITCODE=1"		&rem dk_exec_exitcode
rem set "dk_exec_PRINT_STDERR=1"		&rem dk_exec_stderr[]
rem set "dk_exec_PRINT_STDOUT=1"		&rem dk_exec_stdout[]
rem set "dk_exec_PRINT_OUTPUT=1"		&rem dk_exec
	
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_callDKPhp=%dk_exec%"
		set "%_func_%=%dk_exec%"
	)
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_echo
	%dk_call% dk_callDKPhp dk_testReturn inputA
	%dk_call% dk_echo "dk_callDKPhp = %dk_callDKPhp%"
	%dk_call% dk_echo "dk_testReturn = %dk_testReturn%"
	%dk_call% dk_echo
	
	%dk_call% dk_echo
	%dk_call% dk_callDKPhp dk_basename "%USERPROFILE:\=/%/Digital Knob/Development"
	%dk_call% dk_echo "dk_callDKPhp = %dk_callDKPhp%"
	%dk_call% dk_echo "dk_basename = %dk_basename%"
	%dk_call% dk_echo
%endfunction%
