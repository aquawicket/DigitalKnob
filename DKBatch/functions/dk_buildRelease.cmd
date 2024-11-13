@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_buildRelease()
::#
::#
:dk_buildRelease
    call dk_debugFunc 0
 setlocal
 
    if defined MSYSTEM (
        %MSYS2%/usr/bin/env MSYSTEM=%MSYSTEM% /usr/bin/bash -lc "'%CMAKE_EXE%' --build %CMAKE_TARGET_PATH%/%triple%/Release --config Debug --verbose" && %dk_call% dk_echo "CMake Build Successful" || %dk_call% dk_error "CMake Build Failed"
        %return%
    )
    if exist %TARGET_PATH%\%triple%\Release\CMakeCache.txt (
        %dk_call% dk_echo "%CMAKE_EXE% --build %TARGET_PATH%\%triple%\Release --config Release --verbose"
        "%CMAKE_EXE%" --build %TARGET_PATH%\%triple%\Release --config Release --verbose && %dk_call% dk_echo "CMake Build Successful" || %dk_call% dk_error "CMake Build Failed"
        %return%
    )
    if exist %TARGET_PATH%\%triple%\CMakeCache.txt (
        %dk_call% dk_echo "%CMAKE_EXE% --build %TARGET_PATH%\%triple% --config Release --verbose"
        "%CMAKE_EXE%" --build %TARGET_PATH%\%triple% --config Release --verbose && %dk_call% dk_echo "CMake Build Successful" || %dk_call% dk_error "CMake Build Failed"
        %return%
    )
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_buildRelease
%endfunction%
