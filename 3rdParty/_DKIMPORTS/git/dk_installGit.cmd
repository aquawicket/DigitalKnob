@echo off
call ../../../DKBatch/functions/DK.cmd

::####################################################################
::# dk_installGit()
::#
::#
:dk_installGit () {
	call dk_debugFunc
	
	call dk_validate HOST_ARCH  dk_getHostTriple
::  if "%HOST_ARCH%"=="arm32" call dk_set GIT_DL ""
::  if "%HOST_ARCH%"=="arm64"  call dk_set GIT_DL ""
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86_64" call dk_set GIT_DL "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-32-bit.7z.exe"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86_64" call dk_set GIT_DL "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe"
        
    call dk_getFilename %GIT_DL% GIT_DL_FILE
	call dk_getName %GIT_DL_FILE% GIT_FOLDER
	call dk_convertToCIdentifier %GIT_FOLDER% GIT_FOLDER
    call dk_toLower %GIT_FOLDER% GIT_FOLDER
    
	call dk_validate DKTOOLS_DIR "dk_getDKPaths"
    call dk_set "GIT_EXE=%DKTOOLS_DIR%\%GIT_FOLDER%\bin\git.exe"
        
    if exist "%GIT_EXE%" goto:eof
        
    call dk_echo   
    call dk_info "Installing git . . ."
    call dk_download %GIT_DL% "%DKDOWNLOAD_DIR%\%GIT_DL_FILE%"
    ::echo "%DKDOWNLOAD_DIR%\%GIT_DL_FILE%" /DIR=%DKTOOLS_DIR%\%GIT_FOLDER%
    ::"%DKDOWNLOAD_DIR%\%GIT_DL_FILE%" /DIR="%DKTOOLS_DIR%\%GIT_FOLDER%" /VERYSILENT
	call dk_info "%DKDOWNLOAD_DIR%\%GIT_DL_FILE% -y -o %DKTOOLS_DIR%\%GIT_FOLDER%"
    "%DKDOWNLOAD_DIR%\%GIT_DL_FILE%" -y -o "%DKTOOLS_DIR%\%GIT_FOLDER%"
	   
    if not exist "%GIT_EXE%" call dk_error "cannot find git"
        
    call dk_checkError
goto:eof