@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_buildRelease()
::#
::#
:dk_buildRelease
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
    if "%MSYSTEM%" neq "" (
        %MSYS2%/usr/bin/env MSYSTEM=%MSYSTEM% /usr/bin/bash -lc "'%CMAKE_EXE%' --build %CMAKE_TARGET_PATH%/%TARGET_OS%/Release --config Debug --verbose" && call dk_echo "CMake Build Successful" || call dk_error "CMake Build Failed"
        goto:eof
    )
    if exist %TARGET_PATH%\%TARGET_OS%\Release\CMakeCache.txt (
        call dk_echo "%CMAKE_EXE% --build %TARGET_PATH%\%TARGET_OS%\Release --config Release --verbose"
        "%CMAKE_EXE%" --build %TARGET_PATH%\%TARGET_OS%\Release --config Release --verbose && call dk_echo "CMake Build Successful" || call dk_error "CMake Build Failed"
        goto:eof
    )
    if exist %TARGET_PATH%\%TARGET_OS%\CMakeCache.txt (
        call dk_echo "%CMAKE_EXE% --build %TARGET_PATH%\%TARGET_OS% --config Release --verbose"
        "%CMAKE_EXE%" --build %TARGET_PATH%\%TARGET_OS% --config Release --verbose && call dk_echo "CMake Build Successful" || call dk_error "CMake Build Failed"
        goto:eof
    )
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc

	call dk_buildRelease
goto:eof
