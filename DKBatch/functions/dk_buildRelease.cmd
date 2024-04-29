@echo off
call dk_includeGuard
call DK

::####################################################################
::# dk_buildRelease()
::#
::#
:dk_buildRelease () {
	call dk_debugFunc
	
    if "%MSYSTEM%" NEQ "" (
        %MSYS2%/usr/bin/env MSYSTEM=%MSYSTEM% /usr/bin/bash -lc "'%CMAKE_EXE%' --build %CMAKE_TARGET_PATH%/%TARGET_OS%/Release --config Debug --verbose"
        goto:eof
    )
    if exist %TARGET_PATH%\%TARGET_OS%\Release\CMakeCache.txt (
        echo "%CMAKE_EXE%" --build %TARGET_PATH%\%TARGET_OS%\Release --config Release --verbose
        "%CMAKE_EXE%" --build %TARGET_PATH%\%TARGET_OS%\Release --config Release --verbose
        goto:eof
    )
    if exist %TARGET_PATH%\%TARGET_OS%\CMakeCache.txt (
        echo "%CMAKE_EXE%" --build %TARGET_PATH%\%TARGET_OS% --config Release --verbose
        "%CMAKE_EXE%" --build %TARGET_PATH%\%TARGET_OS% --config Release --verbose
        goto:eof
    )
goto:eof