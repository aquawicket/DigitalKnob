@echo off
::if not defined DKINIT call "../../../DKBatch/functions/DK.cmd"
call "../../../DKBatch/functions/DK.cmd"

::####################################################################
::# dk_installNodeJs()
::#
:dk_installNodeJs () {
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	call dk_validate HOST_OS "call dk_getHostTriple"
	call dk_validate DKTOOLS_DIR "call dk_getDKPaths"
	
	:: https://nodejs.org/dist/v19.8.1/
    if "%HOST_OS%_%HOST_ARCH%"=="linux_arm64"  call dk_set NODEJS_DL "https://nodejs.org/dist/v19.8.1/node-v19.8.1-linux-arm64.tar.gz"
    if "%HOST_OS%_%HOST_ARCH%"=="linux_x86_64" call dk_set NODEJS_DL "https://nodejs.org/dist/v19.8.1/node-v19.8.1-linux-x64.tar.gz"
    if "%HOST_OS%_%HOST_ARCH%"=="mac_arm64"    call dk_set NODEJS_DL "https://nodejs.org/dist/v19.8.1/node-v19.8.1-darwin-arm64.tar.gz"
	if "%HOST_OS%_%HOST_ARCH%"=="mac_x86_64"   call dk_set NODEJS_DL "https://nodejs.org/dist/v19.8.1/node-v19.8.1-darwin-x64.tar.gz"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86"      call dk_set NODEJS_DL "https://nodejs.org/dist/v19.8.1/node-v19.8.1-win-x86.zip"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86_64"   call dk_set NODEJS_DL "https://nodejs.org/dist/v19.8.1/node-v19.8.1-win-x64.zip"
    
    call dk_getBasename %NODEJS_DL% NODEJS_DL_FILE
	call dk_removeExtension %NODEJS_DL_FILE% NODEJS_DL_NAME
    call dk_convertToCIdentifier %NODEJS_DL_NAME% NODEJS_FOLDER
    call dk_toLower %NODEJS_FOLDER% NODEJS_FOLDER
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