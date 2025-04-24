<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::####################################################################
::# dk_buildDebug()
::#
<<<<<<< HEAD
::#
:dk_buildDebug
    call dk_debugFunc 0
 setlocal

    if defined MSYSTEM (
        %MSYS2%/usr/bin/env MSYSTEM=%MSYSTEM% /usr/bin/bash -lc "'%CMAKE_EXE%' --build %CMAKE_TARGET_PATH%/%triple%/Debug --config Debug --verbose" && %dk_call% dk_echo "CMake Build Successful" || %dk_call% dk_error "CMake Build Failed"
		%return%
    )
	
    if exist "%TARGET_PATH%\%triple%\Debug\CMakeCache.txt" (
        %dk_call% dk_verbose "%CMAKE_EXE% --build %TARGET_PATH%/%triple%/Debug --config Debug --verbose"
		"%CMAKE_EXE%" --build %TARGET_PATH%/%triple%/Debug --config Debug --verbose && echo "CMake Build Successful" || echo "CMake Build Failed"
        %return%
    )
	
	%dk_call% dk_assertVar TARGET_PATH
    if exist "%TARGET_PATH%\%triple%\CMakeCache.txt" (
        %dk_call% dk_verbose "%CMAKE_EXE% --build %TARGET_PATH%/%triple% --config Debug --verbose"
        "%CMAKE_EXE%" --build %TARGET_PATH%/%triple% --config Debug --verbose && %dk_call% dk_echo "CMake Build Successful" || %dk_call% dk_error "CMake Build Failed"
        %return%
    )
=======
:dk_buildDebug
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 0

	%dk_call% dk_assertVar TARGET_PATH

	if defined MSYSTEM (
		(set cmnd=%MSYS2%/usr/bin/env MSYSTEM=%MSYSTEM% /usr/bin/bash -lc "'%CMAKE_EXE%' --build %CMAKE_TARGET_PATH%/%target_triple%/%target_type% --config %target_type% --verbose")
	)

	if exist "%TARGET_PATH%/%target_triple%/%target_type%/CMakeCache.txt" (
		(set cmnd="%CMAKE_EXE%" --build %TARGET_PATH%/%target_triple%/%target_type% --config %target_type% --verbose)
	)
	if exist "%TARGET_PATH%/%target_triple%/CMakeCache.txt" (
		(set cmnd="%CMAKE_EXE%" --build %TARGET_PATH%/%target_triple% --config %target_type% --verbose)
	)

	if "%cmnd%" equ "" (%return%)

	%cmnd% && (
		%dk_call% dk_success "CMake Build Successful" 
	) || (
		%dk_call% dk_error "CMake Build Failed"
	)
>>>>>>> Development
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_buildDebug
=======
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 0

	%dk_call% dk_buildDebug
>>>>>>> Development
%endfunction%
