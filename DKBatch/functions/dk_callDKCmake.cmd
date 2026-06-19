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


rem ################################################################################
rem # dk_callDKCmake(function, arguments...)
rem #
:dk_callDKCmake
%setlocal%

	set "_func_=%~1"
	set "_path_=%DKCMAKE_FUNCTIONS_DIR:\=/%/%_func_%.cmake"
	set callDKCmake_func=%~1

	rem ### Get DKHTTP_DKCMAKE_FUNCTIONS_DIR
	if NOT defined DKHTTP_DKCMAKE_DIR					(set "DKHTTP_DKCMAKE_DIR=%DKHTTP_DKBRANCH_DIR%/DKCMake")
	if NOT defined DKHTTP_DKCMAKE_FUNCTIONS_DIR			(set "DKHTTP_DKCMAKE_FUNCTIONS_DIR=%DKHTTP_DKCMAKE_DIR%/functions")

	rem ### Download files if missing
	if NOT EXIST "%DKCMAKE_FUNCTIONS_DIR%/DK.cmake"		(%dk_call% dk_download "%DKHTTP_DKCMAKE_FUNCTIONS_DIR%/DK.cmake" "%DKCMAKE_FUNCTIONS_DIR%/DK.cmake")
	if NOT EXIST "%_path_%"								(%dk_call% dk_download "%DKHTTP_DKCMAKE_FUNCTIONS_DIR%/%_func_%.cmake" "%_path_%")

	%dk_call% dk_validate cmake.exe						%dk_call% dk_depend cmake.exe
	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%"
	
	%dk_call% dk_allButFirstArgs %*
	set callDKCmake_args=%dk_allButFirstArgs%

	set "PAUSE_ON_EXIT=0"
	
rem set DKCOMMAND=%cmake.exe% "-DDKCOMMAND=%CMAKE_COMMAND%" "-DDKSCRIPT_PATH=%DKSCRIPT_PATH%" "-DDKCMAKE_FUNCTIONS_DIR_=%DKCMAKE_FUNCTIONS_DIR_%" "-P" "%DKCMAKE_DIR%/DKEval.cmake"
	set DKCOMMAND="%cmake.exe:/=\%" "-P" "%DKCMAKE_FUNCTIONS_DIR%/dk_callDKCmake.cmake"
	
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
	
	
	:return
	endlocal & (
		set "dk_callDKCmake=%dk_exec%"
		set "%_func_%=%dk_exec%"
	)
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_echo
	%dk_call% dk_callDKCmake dk_testReturn inputA
	%dk_call% dk_echo "dk_callDKCmake = %dk_callDKCmake%"
	%dk_call% dk_echo "dk_testReturn = %dk_testReturn%"
	%dk_call% dk_echo
	
	%dk_call% dk_echo
	%dk_call% dk_callDKCmake dk_basename "%USERPROFILE:\=/%/Digital Knob/Development"
	%dk_call% dk_echo "dk_callDKCmake = %dk_callDKCmake%"
	%dk_call% dk_echo "dk_basename = %dk_basename%"
	%dk_call% dk_echo
%endfunction%
