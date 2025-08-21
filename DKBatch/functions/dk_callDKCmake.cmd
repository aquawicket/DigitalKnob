@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_callDKCmake(function, arguments...)
::#
::#
:dk_callDKCmake
%setlocal%
	%dk_call% dk_debugFunc 1 99

	set "_func_=%~1"
	set "_path_=%DKCMAKE_FUNCTIONS_DIR:\=/%/%_func_%.cmake"
	
	set callDKCmake_func=%~1

	::### Get DKHTTP_DKCMAKE_FUNCTIONS_DIR
	if NOT defined DKHTTP_DKCMAKE_DIR					(set "DKHTTP_DKCMAKE_DIR=%DKHTTP_DKBRANCH_DIR%/DKCMake")
	if NOT defined DKHTTP_DKCMAKE_FUNCTIONS_DIR			(set "DKHTTP_DKCMAKE_FUNCTIONS_DIR=%DKHTTP_DKCMAKE_DIR%/functions")

	::### Download files if missing
	if NOT EXIST "%DKCMAKE_FUNCTIONS_DIR%/DK.cmake"		(%dk_call% dk_download "%DKHTTP_DKCMAKE_FUNCTIONS_DIR%/DK.cmake" "%DKCMAKE_FUNCTIONS_DIR%/DK.cmake")
	if NOT EXIST "%_path_%"								(%dk_call% dk_download "%DKHTTP_DKCMAKE_FUNCTIONS_DIR%/%_func_%.cmake" "%_path_%")

	%dk_call% dk_validate CMAKE_EXE						"%dk_call% dk_depend cmake"
	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%"
	
	%dk_call% dk_allButFirstArgs %*
	set callDKCmake_args=%dk_allButFirstArgs%

	set "PAUSE_ON_EXIT=0"
	
	::set DKCOMMAND=%CMAKE_EXE% "-DDKCOMMAND=%CMAKE_COMMAND%" "-DDKSCRIPT_PATH=%DKSCRIPT_PATH%" "-DDKCMAKE_FUNCTIONS_DIR_=%DKCMAKE_FUNCTIONS_DIR_%" "-P" "%DKCMAKE_DIR%/DKEval.cmake"
	set DKCOMMAND="%CMAKE_EXE:/=\%" "-P" "%DKCMAKE_FUNCTIONS_DIR%/dk_callDKCmake.cmake"
	
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
		set "dk_callDKCmake=%dk_exec%"
		set "%_func_%=%dk_exec%"
	)

%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_echo
	%dk_call% dk_callDKCmake dk_testReturn inputA
	%dk_call% dk_echo "dk_callDKCmake = %dk_callDKCmake%"
	%dk_call% dk_echo "dk_testReturn = %dk_testReturn%"
	%dk_call% dk_echo
	
	%dk_call% dk_echo
	%dk_call% dk_callDKCmake dk_basename "C:/Users/Administrator/DigitalKnob/Development"
	%dk_call% dk_echo "dk_callDKCmake = %dk_callDKCmake%"
	%dk_call% dk_echo "dk_basename = %dk_basename%"
	%dk_call% dk_echo
%endfunction%
