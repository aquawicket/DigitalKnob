@echo off
call ../../../DKBatch/functions/DK.cmd


::####################################################################
::# dk_installVSCode()
::#
::#
:dk_installVSCode () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	
	call dk_validate HOST "dk_getHostTriple"
	if "%HOST_OS%"=="mac" 			           call dk_set VSCODE_DL "https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/VSCode-darwin-universal.zip"
	if "%HOST_OS%_%HOST_ARCH%"=="linux_arm32"  call dk_set VSCODE_DL "https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/code-stable-armhf-1709684464.tar.gz"
	if "%HOST_OS%_%HOST_ARCH%"=="linux_arm64"  call dk_set VSCODE_DL "https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/code-stable-arm64-1709684476.tar.gz"
	if "%HOST_OS%_%HOST_ARCH%"=="linux_x86_64" call dk_set VSCODE_DL "https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/code-stable-x64-1709684476.tar.gz"
	if "%HOST_OS%_%HOST_ARCH%"=="win_arm64"    call dk_set VSCODE_DL "https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/VSCode-win32-arm64-1.87.1.zip"
	if "%HOST_OS%_%HOST_ARCH%"=="win_x86_64"   call dk_set VSCODE_DL "https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/VSCode-win32-x64-1.87.1.zip"
	dk_assert VSCODE_DL
	
	call dk_getFilename %VSCODE_DL% VSCODE_DL_FILE
	call dk_removeExtension %VSCODE_DL_FILE% VSCODE_FOLDER
	call dk_convertToCIdentifier %VSCODE_FOLDER% VSCODE_FOLDER
	call dk_toLower %VSCODE_FOLDER% VSCODE_FOLDER
	
	call dk_validate DKTOOLS_DIR "dk_getDKPaths"
	call dk_set VSCODE "%DKTOOLS_DIR%/%VSCODE_FOLDER%"
	
	if "%HOST_OS%"=="win" (
		call dk_set VSCODE_EXE %VSCODE%/Code.exe
	) else (
		call dk_set VSCODE_EXE %VSCODE%/code
	)	

	if exist %VSCODE_EXE% goto:eof
	
	call dk_echo 
    call dk_info "Installing VSCode . . ."
	call dk_makeDirectory %DKTOOLS_DIR%
::	call dk_import %VSCODE_DL% PATH %VSCODE%
	call dk_download "%VSCODE_DL%" "%DKDOWNLOAD_DIR%\%VSCODE_DL_FILE%"
	call dk_smartExtract "%DKDOWNLOAD_DIR%\%VSCODE_DL_FILE%" "%VSCODE%"
	dk_makeDirectory %VSCODE%/data
	
	if not exist %VSCODE_EXE% call dk_error "cannot find %VSCODE_EXE%"
	
	:: install via CMake
::	call dk_validate DKIMPORTS_DIR dk_getDKPaths
::  call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/vscode/DKMAKE.cmake')" "VSCODE_EXE"
::	call dk_printVar VSCODE_EXE
    call dk_checkError
goto:eof