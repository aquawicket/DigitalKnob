@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0


::####################################################################
::# dk_installVSCode()
::#
::#
:dk_installVSCode
	call dk_debugFunc 0
	
	call dk_validate DK_HOST_OS "call dk_getHostTriple"
	if "%DK_HOST_OS%"=="mac" 			           call dk_set VSCODE_DL "https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/VSCode-darwin-universal.zip"
	if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="linux_arm32"  call dk_set VSCODE_DL "https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/code-stable-armhf-1709684464.tar.gz"
	if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="linux_arm64"  call dk_set VSCODE_DL "https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/code-stable-arm64-1709684476.tar.gz"
	if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="linux_x86_64" call dk_set VSCODE_DL "https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/code-stable-x64-1709684476.tar.gz"
	if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="win_arm64"    call dk_set VSCODE_DL "https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/VSCode-win32-arm64-1.87.1.zip"
	if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="win_x86_64"   call dk_set VSCODE_DL "https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/VSCode-win32-x64-1.87.1.zip"
	if not defined VSCODE_DL call dk_error "VSCODE_DL is invalid"
	
	call dk_basename %VSCODE_DL% VSCODE_DL_FILE
	call dk_removeExtension %VSCODE_DL_FILE% VSCODE_FOLDER
	call dk_convertToCIdentifier %VSCODE_FOLDER% VSCODE_FOLDER
	call dk_toLower %VSCODE_FOLDER% VSCODE_FOLDER
	
	call dk_validate DKTOOLS_DIR "call dk_setDKTOOLS_DIR"
	call dk_set VSCODE_DIR "%DKTOOLS_DIR%\%VSCODE_FOLDER%"
	if "%DK_HOST_OS%"=="win" (
		call dk_set VSCODE_EXE %VSCODE_DIR%\Code.exe
	) else (
		call dk_set VSCODE_EXE %VSCODE_DIR%\code
	)	

	if exist %VSCODE_EXE% goto :vscodeInstalled
	call dk_echo 
    call dk_info "Installing VSCode . . ."
	call dk_makeDirectory %DKTOOLS_DIR%
::	call dk_import %VSCODE_DL% PATH %VSCODE_DIR%
	call dk_download %VSCODE_DL%
	call dk_smartExtract "%DKDOWNLOAD_DIR%\%VSCODE_DL_FILE%" "%VSCODE_DIR%"
	call dk_makeDirectory %VSCODE_DIR%\data
	if not exist %VSCODE_EXE% call dk_error "cannot find %VSCODE_EXE%"
	:vscodeInstalled
	
	::###### dk_installVSCodeFileAssociations.cmd ######
	call %DKIMPORTS_DIR%\vscode\dk_installVSCodeFileAssociations.cmd
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_installVSCode
%endfunction%
