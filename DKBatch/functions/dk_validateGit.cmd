@echo off
call DK

::call dk_load dk_validate
::call dk_load dk_convertToCIdentifier
::call dk_load dk_toLower

call dk_set GIT_DL_WIN_X86 https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-32-bit.7z.exe
call dk_set GIT_DL_WIN_X86_64 https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe

::####################################################################
::# dk_validateGit()
::#
::#
:dk_validateGit () {
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	call dk_validate HOST_ARCH "call dk_getHostTriple"
    if "%HOST_ARCH%"=="arm32"  call dk_set GIT_DL ""
    if "%HOST_ARCH%"=="arm64"  call dk_set GIT_DL %GIT_DL_WIN_ARM64%
    if "%HOST_ARCH%"=="x86"    call dk_set GIT_DL %GIT_DL_WIN_X86%
    if "%HOST_ARCH%"=="x86_64" call dk_set GIT_DL %GIT_DL_WIN_X86_64%
        
    call dk_getFilename %GIT_DL% GIT_DL_FILE
	call dk_removeExtension %GIT_DL_FILE% GIT_DL_NAME
    call dk_convertToCIdentifier %GIT_DL_NAME% GIT_FOLDER
    call dk_toLower %GIT_FOLDER% GIT_FOLDER
	call dk_validate DKTOOLS_DIR "call dk_getDKPaths"
    call dk_set GIT_EXE %DKTOOLS_DIR%\%GIT_FOLDER%\bin\git.exe
        
    if exist "%GIT_EXE%" goto:eof
        
    echo.   
    call dk_info "Installing git . . ."
    call dk_download %GIT_DL% "%DKDOWNLOAD_DIR%\%GIT_DL_FILE%"
    ::echo "%DKDOWNLOAD_DIR%\%GIT_DL_FILE%" /DIR=%DKTOOLS_DIR%\%GIT_FOLDER%
    ::"%DKDOWNLOAD_DIR%\%GIT_DL_FILE%" /DIR="%DKTOOLS_DIR%\%GIT_FOLDER%" /VERYSILENT
	call dk_info "%DKDOWNLOAD_DIR%\%GIT_DL_FILE% -y -o %DKTOOLS_DIR%\%GIT_FOLDER%"
    "%DKDOWNLOAD_DIR%\%GIT_DL_FILE%" -y -o "%DKTOOLS_DIR%\%GIT_FOLDER%"
	   
    if NOT exist "%GIT_EXE%" (call dk_error "cannot find git")
        
    call dk_checkError
goto:eof



:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	
    call dk_validateGit