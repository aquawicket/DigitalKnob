@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_installNodeJs()
::#
:dk_installNodeJs
	call dk_debugFunc 0
	
	
	call dk_validate DK_HOST_OS "call dk_getHostTriple"
    if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="linux_arm64"  call dk_set NODEJS_DL "https://nodejs.org/dist/v19.8.1/node-v19.8.1-linux-arm64.tar.gz"
    if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="linux_x86_64" call dk_set NODEJS_DL "https://nodejs.org/dist/v19.8.1/node-v19.8.1-linux-x64.tar.gz"
    if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="mac_arm64"    call dk_set NODEJS_DL "https://nodejs.org/dist/v19.8.1/node-v19.8.1-darwin-arm64.tar.gz"
	if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="mac_x86_64"   call dk_set NODEJS_DL "https://nodejs.org/dist/v19.8.1/node-v19.8.1-darwin-x64.tar.gz"
    if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="win_x86"      call dk_set NODEJS_DL "https://nodejs.org/dist/v19.8.1/node-v19.8.1-win-x86.zip"
    if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="win_x86_64"   call dk_set NODEJS_DL "https://nodejs.org/dist/v19.8.1/node-v19.8.1-win-x64.zip"
    if not defined NODEJS_DL call dk_error "NODEJS_DL is invalid"
	
    call dk_basename %NODEJS_DL% NODEJS_DL_FILE
	call dk_removeExtension %NODEJS_DL_FILE% NODEJS_DL_NAME
    call dk_convertToCIdentifier %NODEJS_DL_NAME% NODEJS_FOLDER
    call dk_toLower %NODEJS_FOLDER% NODEJS_FOLDER
	
	call dk_validate DKTOOLS_DIR "call dk_setDKTOOLS_DIR"
	call dk_set NODEJS %DKTOOLS_DIR%\%NODEJS_FOLDER%
    call dk_set NODEJS_EXE "%NODEJS%\node.exe"
        
    if exist "%NODEJS_EXE%" goto:nodejs_installed
    call dk_info " "
    call dk_info "Installing NodeJS . . ."
    call dk_download "%NODEJS_DL%"
	call dk_smartExtract "%DKDOWNLOAD_DIR%\%NODEJS_DL_FILE%" "%NODEJS%"
    if NOT exist "%NODEJS_EXE%" call dk_error "cannot find NODEJS_EXE:%NODEJS_EXE%"
	:nodejs_installed		
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_installNodeJs
goto:eof
