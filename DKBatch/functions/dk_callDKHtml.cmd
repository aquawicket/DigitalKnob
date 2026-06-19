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
rem # dk_callDKHtml(function, arguments..., rtn_var)
rem #
rem #
rem #
:dk_callDKHtml
%setlocal%

	set "_func_=%~1"
	set "_path_=%DKHTML_FUNCTIONS_DIR:\=/%/%_func_%.sh"
	
	rem ### Get DKHTTP_DKBASH_FUNCTIONS_DIR
	if NOT defined DKHTTP_DKBASH_DIR			(set "DKHTTP_DKBASH_DIR=%DKHTTP_DKBRANCH_DIR%/DKBash")
	if NOT defined DKHTTP_DKBASH_FUNCTIONS_DIR  (set "DKHTTP_DKBASH_FUNCTIONS_DIR=%DKHTTP_DKBASH_DIR%/functions")

	rem ### Download files if missing
	if NOT EXIST "%DKHTML_FUNCTIONS_DIR%/DK.sh"	(%dk_call% dk_download "%DKHTTP_DKBASH_FUNCTIONS_DIR%/DK.sh" "%DKHTML_FUNCTIONS_DIR%/DK.sh")
	if NOT EXIST "%_path_%"						(%dk_call% dk_download "%DKHTTP_DKBASH_FUNCTIONS_DIR%/%_func_%.sh" "%_path_%")

	%dk_call% dk_allButFirstArgs %*

	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:C:=/c%"
	set "PAUSE_ON_EXIT=0"

	set DKCOMMAND=%bash_exe% -c '%_path_% %dk_allButFirstArgs%'
	
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
		set "dk_callDKHtml=%dk_exec%"
		set "%_func_%=%dk_exec%"
	)
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_callDKHtml TODO
%endfunction%
