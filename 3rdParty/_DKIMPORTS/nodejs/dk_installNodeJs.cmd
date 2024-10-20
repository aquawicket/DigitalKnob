@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_installNodeJs()
::#
:dk_installNodeJs
	call dk_debugFunc 0
	
	
	%dk_call% dk_validate DK_HOST_OS "%dk_call% dk_getHostTriple"
    if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="linux_arm64"  %dk_call% dk_set NODEJS_DL "https://nodejs.org/dist/v19.8.1/node-v19.8.1-linux-arm64.tar.gz"
    if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="linux_x86_64" %dk_call% dk_set NODEJS_DL "https://nodejs.org/dist/v19.8.1/node-v19.8.1-linux-x64.tar.gz"
    if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="mac_arm64"    %dk_call% dk_set NODEJS_DL "https://nodejs.org/dist/v19.8.1/node-v19.8.1-darwin-arm64.tar.gz"
	if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="mac_x86_64"   %dk_call% dk_set NODEJS_DL "https://nodejs.org/dist/v19.8.1/node-v19.8.1-darwin-x64.tar.gz"
    if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="win_x86"      %dk_call% dk_set NODEJS_DL "https://nodejs.org/dist/v19.8.1/node-v19.8.1-win-x86.zip"
    if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="win_x86_64"   %dk_call% dk_set NODEJS_DL "https://nodejs.org/dist/v19.8.1/node-v19.8.1-win-x64.zip"
    if not defined NODEJS_DL %dk_call% dk_error "NODEJS_DL is invalid"
	
    %dk_call% dk_basename %NODEJS_DL% NODEJS_DL_FILE
	%dk_call% dk_removeExtension %NODEJS_DL_FILE% NODEJS_FOLDER
    ::%dk_call% dk_convertToCIdentifier %NODEJS_FOLDER% NODEJS_FOLDER
    %dk_call% dk_toLower %NODEJS_FOLDER% NODEJS_FOLDER
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_setDKTOOLS_DIR"
	%dk_call% dk_set NODEJS %DKTOOLS_DIR%\%NODEJS_FOLDER%
	
	
    %dk_call% dk_set NODEJS_EXE "%NODEJS%\node.exe"
        
    if exist "%NODEJS_EXE%" goto:nodejs_installed
    %dk_call% dk_info " "
    %dk_call% dk_info "Installing NodeJS . . ."
    %dk_call% dk_download "%NODEJS_DL%"
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_setDKDOWNLOAD_DIR"
	%dk_call% dk_smartExtract "%DKDOWNLOAD_DIR%\%NODEJS_DL_FILE%" "%NODEJS%"
    if NOT exist "%NODEJS_EXE%" %dk_call% dk_error "cannot find NODEJS_EXE:%NODEJS_EXE%"
	:nodejs_installed		
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_installNodeJs
%endfunction%
