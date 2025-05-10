@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_buildDebug()
::#
:dk_buildDebug
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_assertVar TARGET_PATH

	if defined MSYSTEM (
		(set cmnd=%MSYS2%/usr/bin/env MSYSTEM=%MSYSTEM% /usr/bin/bash -lc "'%CMAKE_EXE%' --build %CMAKE_TARGET_PATH%/%Target_Tuple%/%Target_Type% --config %Target_Type% --verbose")
	)

	if exist "%TARGET_PATH%/%Target_Tuple%/%Target_Type%/CMakeCache.txt" (
		(set cmnd="%CMAKE_EXE%" --build %TARGET_PATH%/%Target_Tuple%/%Target_Type% --config %Target_Type% --verbose)
	)
	if exist "%TARGET_PATH%/%Target_Tuple%/CMakeCache.txt" (
		(set cmnd="%CMAKE_EXE%" --build %TARGET_PATH%/%Target_Tuple% --config %Target_Type% --verbose)
	)

	if "%cmnd%" equ "" (%return%)

	%cmnd% && (
		%dk_call% dk_success "CMake Build Successful" 
	) || (
		%dk_call% dk_error "CMake Build Failed"
	)
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_buildDebug
%endfunction%
