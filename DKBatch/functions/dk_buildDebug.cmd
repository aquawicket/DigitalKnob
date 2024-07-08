@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::####################################################################
::# dk_buildDebug()
::#
::#
:dk_buildDebug
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
    if "%MSYSTEM%" neq "" (
        %MSYS2%/usr/bin/env MSYSTEM=%MSYSTEM% /usr/bin/bash -lc "'%CMAKE_EXE%' --build %CMAKE_TARGET_PATH%/%TARGET_OS%/Debug --config Debug --verbose"
        goto:eof
    )
    if exist %TARGET_PATH%\%TARGET_OS%\Debug\CMakeCache.txt (
        echo "%CMAKE_EXE%" --build %TARGET_PATH%/%TARGET_OS%/Debug --config Debug --verbose
        "%CMAKE_EXE%" --build %TARGET_PATH%/%TARGET_OS%/Debug --config Debug --verbose
        goto:eof
    )
    if exist %TARGET_PATH%\%TARGET_OS%\CMakeCache.txt (
        echo "%CMAKE_EXE%" --build %TARGET_PATH%/%TARGET_OS% --config Debug --verbose
        "%CMAKE_EXE%" --build %TARGET_PATH%/%TARGET_OS% --config Debug --verbose
        goto:eof
    )
goto:eof



::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_buildDebug
goto:eof
