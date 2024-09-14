@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_buildRelease()
::#
::#
:dk_buildRelease
    call dk_debugFunc 0
 setlocal
 
    if "%MSYSTEM%" neq "" (
        %MSYS2%/usr/bin/env MSYSTEM=%MSYSTEM% /usr/bin/bash -lc "'%CMAKE_EXE%' --build %CMAKE_TARGET_PATH%/%TARGET_OS%/Release --config Debug --verbose" && %dk_call% dk_echo "CMake Build Successful" || %dk_call% dk_error "CMake Build Failed"
        goto:eof
    )
    if exist %TARGET_PATH%\%TARGET_OS%\Release\CMakeCache.txt (
        %dk_call% dk_echo "%CMAKE_EXE% --build %TARGET_PATH%\%TARGET_OS%\Release --config Release --verbose"
        "%CMAKE_EXE%" --build %TARGET_PATH%\%TARGET_OS%\Release --config Release --verbose && %dk_call% dk_echo "CMake Build Successful" || %dk_call% dk_error "CMake Build Failed"
        goto:eof
    )
    if exist %TARGET_PATH%\%TARGET_OS%\CMakeCache.txt (
        %dk_call% dk_echo "%CMAKE_EXE% --build %TARGET_PATH%\%TARGET_OS% --config Release --verbose"
        "%CMAKE_EXE%" --build %TARGET_PATH%\%TARGET_OS% --config Release --verbose && %dk_call% dk_echo "CMake Build Successful" || %dk_call% dk_error "CMake Build Failed"
        goto:eof
    )
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_buildRelease
%endfunction%
