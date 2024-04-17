::dk_include_guard()

::####################################################################
::# dk_validate_cmake()
::#
::#
:dk_validate_cmake () {
	call dk_verbose "dk_validate_cmake(%*)"
	
    if "%HOST_OS%_%HOST_ARCH%"=="win_arm32"    set "CMAKE_DL=%CMAKE_DL_WIN_ARM32%"
    if "%HOST_OS%_%HOST_ARCH%"=="win_arm64"    set "CMAKE_DL=%CMAKE_DL_WIN_ARM64%"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86"      set "CMAKE_DL=%CMAKE_DL_WIN_X86%"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86_64"   set "CMAKE_DL=%CMAKE_DL_WIN_X86_64%"
    if "%HOST_OS%"=="mac"                        set "CMAKE_DL=%CMAKE_DL_MAC%"
    if "%HOST_OS%_%HOST_ARCH%"=="linux_x86_64" set "CMAKE_DL=%CMAKE_DL_LINUX_X86_64%"
    if "%HOST_OS%_%HOST_ARCH%"=="linux_arm64"  set "CMAKE_DL=%CMAKE_DL_LINUX_ARM64%"
    call dk_debug CMAKE_DL
    
    call dk_get_filename %CMAKE_DL% CMAKE_DL_FILE
    call dk_debug CMAKE_DL_FILE
        
    set CMAKE_FOLDER=%CMAKE_DL_FILE:~0,-4%
    call dk_convert_to_c_identifier %CMAKE_FOLDER% CMAKE_FOLDER
    call dk_convert_to_lowercase %CMAKE_FOLDER% CMAKE_FOLDER
    call dk_debug CMAKE_FOLDER
        
    set "CMAKE_EXE=%DKTOOLS_DIR%\%CMAKE_FOLDER%\bin\cmake.exe"
    call dk_debug CMAKE_EXE
        
    if exist "%CMAKE_EXE%" goto:eof
       
    echo.   
    echo "Installing cmake . . ."
    ::echo MsiExec.exe /i "%DKDOWNLOAD_DIR%\%CMAKE_DL_FILE%" INSTALL_ROOT="%DKTOOLS_DIR%\%CMAKE_FOLDER%" /qn
    ::MsiExec.exe /i "%DKDOWNLOAD_DIR%\%CMAKE_DL_FILE%" INSTALL_ROOT="%DKTOOLS_DIR%\%CMAKE_FOLDER%" /qn
    call dk_download "%CMAKE_DL%" "%DKDOWNLOAD_DIR%\%CMAKE_DL_FILE%"
	call dk_extract "%DKDOWNLOAD_DIR%\%CMAKE_DL_FILE%" "%DKTOOLS_DIR%"
	set CMAKE_DL_NAME=%CMAKE_DL_FILE:~0,-4%
	rename "%DKTOOLS_DIR%\%CMAKE_DL_NAME%" "%CMAKE_FOLDER%"
	echo %CMAKE_FOLDER%>"%DKTOOLS_DIR%\%CMAKE_FOLDER%\installed"
    
    if NOT exist "%CMAKE_EXE%" (
        call assert "cannot find cmake"
    )
        
    call dk_check_error
goto:eof