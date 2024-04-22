::dk_include_guard()

set GIT_DL_WIN_X86=https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-32-bit.7z.exe
set GIT_DL_WIN_X86_64=https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe

::####################################################################
::# dk_validateGit()
::#
::#
:dk_validateGit () {
	call dk_verbose "dk_validateGit(%*)"
	
    if "%HOST_ARCH%"=="arm32" set GIT_DL=
    if "%HOST_ARCH%"=="arm64" set GIT_DL=%GIT_DL_WIN_ARM64%
    if "%HOST_ARCH%"=="x86" set GIT_DL=%GIT_DL_WIN_X86%
    if "%HOST_ARCH%"=="x86_64" set GIT_DL=%GIT_DL_WIN_X86_64%
        
    call dk_getFilename %GIT_DL% GIT_DL_FILE
    ::call dk_debug GIT_DL_FILE

    set GIT_FOLDER=%GIT_DL_FILE:~0,-4%
	::call dk_debug GIT_FOLDER
    call dk_convertToCIdentifier %GIT_FOLDER% GIT_FOLDER
	::call dk_debug GIT_FOLDER
    call dk_convertToLowercase %GIT_FOLDER% GIT_FOLDER
	::call dk_debug GIT_FOLDER
    
    set "GIT_EXE=%DKTOOLS_DIR%\%GIT_FOLDER%\bin\git.exe"
    ::call dk_debug GIT_EXE
        
    if exist "%GIT_EXE%" goto:eof
        
    echo.   
    echo "Installing git . . ."
    call dk_download %GIT_DL% "%DKDOWNLOAD_DIR%\%GIT_DL_FILE%"
    ::echo "%DKDOWNLOAD_DIR%\%GIT_DL_FILE%" /DIR=%DKTOOLS_DIR%\%GIT_FOLDER%
    ::"%DKDOWNLOAD_DIR%\%GIT_DL_FILE%" /DIR="%DKTOOLS_DIR%\%GIT_FOLDER%" /VERYSILENT
	echo "%DKDOWNLOAD_DIR%\%GIT_DL_FILE%" -y -o "%DKTOOLS_DIR%\%GIT_FOLDER%"
    "%DKDOWNLOAD_DIR%\%GIT_DL_FILE%" -y -o "%DKTOOLS_DIR%\%GIT_FOLDER%"
	   
    if NOT exist "%GIT_EXE%" (
        call assert "cannot find git"
    )
        
    call dk_checkError
goto:eof