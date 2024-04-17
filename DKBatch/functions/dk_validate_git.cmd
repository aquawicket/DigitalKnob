::dk_include_guard()

::####################################################################
::# dk_validate_git()
::#
::#
:dk_validate_git () {
	call:dk_verbose "dk_validate_git(%*)"
	
    if "%HOST_ARCH%"=="arm32" set GIT_DL=
    if "%HOST_ARCH%"=="arm64" set GIT_DL=%GIT_DL_WIN_ARM64%
    if "%HOST_ARCH%"=="x86" set GIT_DL=%GIT_DL_WIN_X86%
    if "%HOST_ARCH%"=="x86_64" set GIT_DL=%GIT_DL_WIN_X86_64%
        
    call:dk_get_filename %GIT_DL% GIT_DL_FILE
    ::call:dk_debug GIT_DL_FILE

    set GIT_FOLDER=%GIT_DL_FILE:~0,-4%
    call:dk_convert_to_c_identifier %GIT_FOLDER% GIT_FOLDER
    call:dk_convert_to_lowercase %GIT_FOLDER% GIT_FOLDER
    ::call:dk_debug GIT_FOLDER
        
    set "GIT_EXE=%DKTOOLS_DIR%\%GIT_FOLDER%\bin\git.exe"
    call:dk_debug GIT_EXE
        
    if exist "%GIT_EXE%" goto:eof
        
    echo.   
    echo "Installing git . . ."
    call:dk_download %GIT_DL% "%DKDOWNLOAD_DIR%\%GIT_DL_FILE%"
    ::echo "%DKDOWNLOAD_DIR%\%GIT_DL_FILE%" /DIR=%DKTOOLS_DIR%\%GIT_FOLDER%
    ::"%DKDOWNLOAD_DIR%\%GIT_DL_FILE%" /DIR="%DKTOOLS_DIR%\%GIT_FOLDER%" /VERYSILENT
	echo "%DKDOWNLOAD_DIR%\%GIT_DL_FILE%" -y -o "%DKTOOLS_DIR%\%GIT_FOLDER%"
    "%DKDOWNLOAD_DIR%\%GIT_DL_FILE%" -y -o "%DKTOOLS_DIR%\%GIT_FOLDER%"
	   
    if NOT exist "%GIT_EXE%" (
        call:assert "cannot find git"
    )
        
    call:dk_check_error
goto:eof