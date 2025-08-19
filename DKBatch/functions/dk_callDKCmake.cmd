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
	%dk_call% dk_debugFunc 1 4

	%dk_call% dk_validate DKCMAKE_FUNCTIONS_DIR  "%dk_call% dk_DKBRANCH_DIR"

	::### Get DKHTTP_DKCMAKE_FUNCTIONS_DIR
	if NOT defined DKHTTP_DKCMAKE_DIR					(set "DKHTTP_DKCMAKE_DIR=%DKHTTP_DKBRANCH_DIR%/DKCMake")
	if NOT defined DKHTTP_DKCMAKE_FUNCTIONS_DIR			(set "DKHTTP_DKCMAKE_FUNCTIONS_DIR=%DKHTTP_DKCMAKE_DIR%/functions")

	::### Download files if missing
	if NOT EXIST "%DKCMAKE_FUNCTIONS_DIR%/DK.cmake"		(%dk_call% dk_download "%DKHTTP_DKCMAKE_FUNCTIONS_DIR%/DK.cmake" "%DKCMAKE_FUNCTIONS_DIR%/DK.cmake")
	::if NOT EXIST "%DKCMAKE_FUNCTIONS_DIR%/%~1.cmake"	(%dk_call% dk_download "%DKHTTP_DKCMAKE_FUNCTIONS_DIR%/%~1.cmake" "%DKCMAKE_FUNCTIONS_DIR%/%~1.cmake")

	%dk_call% dk_validate DKIMPORTS_DIR				"%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate CMAKE_EXE					"%dk_call% dk_depend cmake"
	set "cmake="
	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%"

	::### All but first Args ###
	::%dk_call% dk_allButFirstArgs %*
	
	::set CMAKE_COMMAND=%~1
::	%dk_call% dk_allButFirstArgs %*
::	set "CMAKE_COMMAND=dk_callDKCmake(%~1 %dk_allButFirstArgs%)"
	::set "DKCOMMAND=%DKCOMMAND:"='%"

	::############ DKCMake function call ############
	::set DKCOMMAND=%CMAKE_EXE% "-DDKCOMMAND=%CMAKE_COMMAND%" "-DDKSCRIPT_PATH=%DKSCRIPT_PATH%" "-DDKCMAKE_FUNCTIONS_DIR_=%DKCMAKE_FUNCTIONS_DIR_%" "-P" "%DKCMAKE_DIR%/DKEval.cmake"

	set "dk_exec_ECHO_OUTPUT=1"
	set "dk_exec_ECHO_ERROR=1"
	set "dk_exec_PRINT_CALL=1"
	set "dk_exec_PRINT_COMMAND=1"
::	set "dk_exec_PRINT_EXITCODES=1"
::	set "dk_exec_PRINT_EXITCODE=1"
::	set "dk_exec_PRINT_STDERR=1"
::	set "dk_exec_PRINT_STDOUT=1"
::	set "dk_exec_PRINT_OUTPUT=1"
	
	set callDKCmake_func=%~1

	%dk_call% dk_allButFirstArgs %*

	echo dk_allButFirstArgs = %dk_allButFirstArgs%
	set callDKCmake_args=%dk_allButFirstArgs%

	set DKCOMMAND="%CMAKE_EXE:/=\%" "-P" "%DKCMAKE_FUNCTIONS_DIR%/dk_callDKCmake.cmake"
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_callDKCmake=%dk_exec%"
	)

%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0



	%dk_call% dk_callDKCmake "dk_basename" "C:/Windows/System32"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_callDKCmake = %dk_callDKCmake%"

	
	%dk_call% dk_callDKCmake "dk_test" "arg 1" "arg 2" "arg 3"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_callDKCmake = %dk_callDKCmake%"
%endfunction%
