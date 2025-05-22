@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_evalDKCmake(function, arguments..., rtn_var)
::#
::#
:dk_evalDKCmake
%setlocal%
	%dk_call% dk_debugFunc 1 4


	%dk_call% dk_validate DKCMAKE_FUNCTIONS_DIR  "%dk_call% dk_DKBRANCH_DIR"

	::### Get DKHTTP_DKCMAKE_FUNCTIONS_DIR
	if not defined DKHTTP_DKCMAKE_DIR					(set "DKHTTP_DKCMAKE_DIR=%DKHTTP_DKBRANCH_DIR%/DKCMake")
	if not defined DKHTTP_DKCMAKE_FUNCTIONS_DIR			(set "DKHTTP_DKCMAKE_FUNCTIONS_DIR=%DKHTTP_DKCMAKE_DIR%/functions")

	::### Download files if missing
	if not exist "%DKCMAKE_FUNCTIONS_DIR%/DK.cmake"		(%dk_call% dk_download "%DKHTTP_DKCMAKE_FUNCTIONS_DIR%/DK.cmake" "%DKCMAKE_FUNCTIONS_DIR%/DK.cmake")
	::if not exist "%DKCMAKE_FUNCTIONS_DIR%/%~1.cmake"	(%dk_call% dk_download "%DKHTTP_DKCMAKE_FUNCTIONS_DIR%/%~1.cmake" "%DKCMAKE_FUNCTIONS_DIR%/%~1.cmake")

	%dk_call% dk_validate DKIMPORTS_DIR				"%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate CMAKE_EXE					"%dk_call% %DKIMPORTS_DIR%/cmake/DKINSTALL.cmd"

	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%"

	::### All but first Args ###
	::%dk_call% dk_allButFirstArgs %*
	
	set CMAKE_COMMAND=%~1
	::set "DKCOMMAND=%DKCOMMAND:"='%"

	::############ DKCMake function call ############
	set DKCOMMAND=%CMAKE_EXE% "-DDKCOMMAND=%CMAKE_COMMAND%" "-DDKSCRIPT_PATH=%DKSCRIPT_PATH%" "-DQUEUE_BUILD=ON" "-DDKCMAKE_FUNCTIONS_DIR_=%DKCMAKE_FUNCTIONS_DIR_%" "-P" "%DKCMAKE_DIR%/DKEval.cmake"
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_evalDKCmake=%dk_exec%"
	)

%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_evalDKCmake "dk_test('arg 1' 'arg 2' 'arg 3')"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_evalDKCmake = %dk_evalDKCmake%"
%endfunction%
