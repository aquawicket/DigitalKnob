@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_buildDebug()
::#
::#
:dk_buildDebug
    call dk_debugFunc 0
 setlocal

	echo if "%MSYSTEM%" neq "" (
    if "%MSYSTEM%" neq "" (
        %MSYS2%/usr/bin/env MSYSTEM=%MSYSTEM% /usr/bin/bash -lc "'%CMAKE_EXE%' --build %CMAKE_TARGET_PATH%/%TARGET_OS%/Debug --config Debug --verbose" && %dk_call% dk_echo "CMake Build Successful" || %dk_call% dk_error "CMake Build Failed"
        
		%return%
    )
	
    if exist "%TARGET_PATH%\%TARGET_OS%\Debug\CMakeCache.txt" (
        %dk_call% dk_verbose "%CMAKE_EXE% --build %TARGET_PATH%/%TARGET_OS%/Debug --config Debug --verbose"
		
		rem call dk_refreshEnv
		"%CMAKE_EXE%" --build %TARGET_PATH%/%TARGET_OS%/Debug --config Debug --verbose && echo "CMake Build Successful" || echo "CMake Build Failed"
        rem endlocal
		
        %return%
    )
	
	%dk_call% dk_assert TARGET_PATH
    if exist "%TARGET_PATH%\%TARGET_OS%\CMakeCache.txt" (

        %dk_call% dk_verbose "%CMAKE_EXE% --build %TARGET_PATH%/%TARGET_OS% --config Debug --verbose"
        "%CMAKE_EXE%" --build %TARGET_PATH%/%TARGET_OS% --config Debug --verbose && %dk_call% dk_echo "CMake Build Successful" || %dk_call% dk_error "CMake Build Failed"
       
        %return%
    )
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_buildDebug
%endfunction%
