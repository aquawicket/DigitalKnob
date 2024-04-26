::call dk_includeGuard

::####################################################################
::# dk_buildDebug()
::#
::#
:dk_buildDebug () {
	call dk_debugFunc
	
    if "%MSYSTEM%" NEQ "" (
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