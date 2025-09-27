@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_callDKPhp(function, arguments...)
::#
::#
:dk_callDKPhp
%setlocal%
	%dk_call% dk_debugFunc 1 99

	set "_func_=%~1"
	set "_path_=%DKPHP_FUNCTIONS_DIR:\=/%/%_func_%.php"
	
	%dk_call% dk_validate php_exe "%dk_call% dk_depend php-src"
	%dk_call% dk_assertPath php_exe
	
	%dk_call% dk_validate DKPHP_FUNCTIONS_DIR		"%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_assertPath DKPHP_FUNCTIONS_DIR

	if NOT defined DKHTTP_DKPHP_DIR					(set "DKHTTP_DKPHP_DIR=%DKHTTP_DKBRANCH_DIR%/DKPhp")
	if NOT defined DKHTTP_DKPHP_FUNCTIONS_DIR		(set "DKHTTP_DKPHP_FUNCTIONS_DIR=%DKHTTP_DKPHP_DIR%/functions")

	::### Download files if missing
	if NOT EXIST "%DKPHP_FUNCTIONS_DIR%/DK.php"		(%dk_call% dk_download "%DKHTTP_DKPHP_FUNCTIONS_DIR%/DK.php" "%DKPHP_FUNCTIONS_DIR%/DK.php")
	if NOT EXIST "%_path_%"							(%dk_call% dk_download "%DKHTTP_DKPHP_FUNCTIONS_DIR%/%_func_%.php" "%_path_%")

	%dk_call% dk_allButFirstArgs %*
	
	set "PAUSE_ON_EXIT=0"
	
	set DKCOMMAND="%php_exe%" "%_path_%" %dk_allButFirstArgs%
	
	set "dk_exec_ECHO_OUTPUT=0"
	set "dk_exec_ECHO_ERROR=0"
	::set "dk_exec_PRINT_CALL=1" 		&:: dk_exec_call
	::set "dk_exec_PRINT_COMMAND=1" 	&:: dk_exec_command
	::set "dk_exec_PRINT_EXITCODES=1"	&:: dk_exec_exitcodes
	::set "dk_exec_PRINT_EXITCODE=1"	&:: dk_exec_exitcode
	::set "dk_exec_PRINT_STDERR=1"		&:: dk_exec_stderr[]
	::set "dk_exec_PRINT_STDOUT=1"		&:: dk_exec_stdout[]
	::set "dk_exec_PRINT_OUTPUT=1"		&:: dk_exec
	
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_callDKPhp=%dk_exec%"
		set "%_func_%=%dk_exec%"
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_echo
	%dk_call% dk_callDKPhp dk_testReturn inputA
	%dk_call% dk_echo "dk_callDKPhp = %dk_callDKPhp%"
	%dk_call% dk_echo "dk_testReturn = %dk_testReturn%"
	%dk_call% dk_echo
	
	%dk_call% dk_echo
	%dk_call% dk_callDKPhp dk_basename "C:/Users/Administrator/DigitalKnob/Development"
	%dk_call% dk_echo "dk_callDKPhp = %dk_callDKPhp%"
	%dk_call% dk_echo "dk_basename = %dk_basename%"
	%dk_call% dk_echo
%endfunction%
