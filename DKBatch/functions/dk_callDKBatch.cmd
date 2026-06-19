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
rem # dk_callDKBatch(function, arguments..., rtn_var)
rem #
rem #   Reference: https://stackoverflow.com/questions/34451444/how-to-get-a-returned-value-from-powershell-and-get-it-in-a-batch-file
rem #
:dk_callDKBatch
%setlocal%

	set "_func_=%~1"
	set "_path_=%DKBATCH_FUNCTIONS_DIR_%%_func_%.cmd"
	%dk_call% dk_allButFirstArgs %*

rem	:DeEscape
rem	echo %_ARGS_% | %findstr.exe% /c:"^^" >nul && (
rem		set _ARGS_=%_ARGS_:^^=^%
rem		goto :DeEscape
rem	)
		
	set DKCOMMAND=%_path_% %dk_allButFirstArgs%
	
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
		set dk_callDKBatch=%dk_exec%
		set "%_func_%=%dk_exec%"
	)
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

rem	%dk_call% dk_echo
rem	%dk_call% dk_callDKBatch dk_testReturn inputA
rem	%dk_call% dk_echo "dk_callDKBatch = %dk_callDKBatch%"
rem	%dk_call% dk_echo "dk_testReturn = %dk_testReturn%"
rem	%dk_call% dk_echo
	
	%dk_call% dk_echo
	%dk_call% dk_callDKBatch dk_basename "%USERPROFILE:\=/%/Digital Knob/Development"
	%dk_call% dk_echo "dk_callDKBatch = %dk_callDKBatch%"
	%dk_call% dk_echo "dk_basename = %dk_basename%"
	%dk_call% dk_echo
%endfunction%		
