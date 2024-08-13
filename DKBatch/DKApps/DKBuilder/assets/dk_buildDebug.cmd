@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_buildDebug()
::#
::#
:dk_buildDebug
	call dk_debugFunc 0
	
    if "%MSYSTEM%" neq "" (
        %MSYS2%/usr/bin/env MSYSTEM=%MSYSTEM% /usr/bin/bash -lc "'%CMAKE_EXE%' --build %CMAKE_TARGET_PATH%/%TARGET_OS%/Debug --config Debug --verbose" && %dk_call% dk_echo "CMake Build Successful" || %dk_call% dk_error "CMake Build Failed"
        goto:eof
    )
    if exist %TARGET_PATH%\%TARGET_OS%\Debug\CMakeCache.txt (
        %dk_call% dk_echo "%CMAKE_EXE% --build %TARGET_PATH%/%TARGET_OS%/Debug --config Debug --verbose"
        "%CMAKE_EXE%" --build %TARGET_PATH%/%TARGET_OS%/Debug --config Debug --verbose && %dk_call% dk_echo "CMake Build Successful" || %dk_call% dk_error "CMake Build Failed"
        goto:eof
    )
    if exist %TARGET_PATH%\%TARGET_OS%\CMakeCache.txt (
        %dk_call% dk_echo "%CMAKE_EXE% --build %TARGET_PATH%/%TARGET_OS% --config Debug --verbose"
        "%CMAKE_EXE%" --build %TARGET_PATH%/%TARGET_OS% --config Debug --verbose && %dk_call% dk_echo "CMake Build Successful" || %dk_call% dk_error "CMake Build Failed"
        goto:eof
    )
goto:eof



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_buildDebug
goto:eof
