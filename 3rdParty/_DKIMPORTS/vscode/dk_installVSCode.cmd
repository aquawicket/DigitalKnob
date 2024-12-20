@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*


::####################################################################
::# dk_installVSCode()
::#
::#
:dk_installVSCode
	call dk_debugFunc 0
	
	%dk_call% dk_validate host_triple "%dk_call% dk_host_triple"
	if defined mac_host          set "VSCODE_DL=https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/VSCode-darwin-universal.zip"
	if defined linux_arm32_host  set "VSCODE_DL=https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/code-stable-armhf-1709684464.tar.gz"
	if defined linux_arm64_host  set "VSCODE_DL=https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/code-stable-arm64-1709684476.tar.gz"
	if defined linux_x86_64_host set "VSCODE_DL=https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/code-stable-x64-1709684476.tar.gz"
	if defined win_arm64_host    set "VSCODE_DL=https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/VSCode-win32-arm64-1.87.1.zip"
	if defined win_x86_64_host   set "VSCODE_DL=https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/VSCode-win32-x64-1.87.1.zip"
	if not defined VSCODE_DL %dk_call% dk_error "VSCODE_DL is invalid"
	
	%dk_call% dk_basename %VSCODE_DL% VSCODE_DL_FILE
	%dk_call% dk_removeExtension %VSCODE_DL_FILE% VSCODE_FOLDER
	::%dk_call% dk_convertToCIdentifier %VSCODE_FOLDER% VSCODE_FOLDER
	%dk_call% dk_toLower %VSCODE_FOLDER% VSCODE_FOLDER
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DIGITALKNOB_DIR"
	%dk_call% dk_set VSCODE_DIR "%DKTOOLS_DIR%\%VSCODE_FOLDER%"
	
	if defined win_host (
		%dk_call% dk_set VSCODE_EXE %VSCODE_DIR%\Code.exe
	) else (
		%dk_call% dk_set VSCODE_EXE %VSCODE_DIR%\code
	)	

	if exist %VSCODE_EXE% goto vscodeInstalled
	%dk_call% dk_echo 
    %dk_call% dk_info "Installing VSCode . . ."
	%dk_call% dk_makeDirectory %DKTOOLS_DIR%
::	%dk_call% dk_import %VSCODE_DL% PATH %VSCODE_DIR%
	%dk_call% dk_download %VSCODE_DL%
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DIGITALKNOB_DIR"
	%dk_call% dk_smartExtract "%DKDOWNLOAD_DIR%\%VSCODE_DL_FILE%" "%VSCODE_DIR%"
	%dk_call% dk_makeDirectory %VSCODE_DIR%\data
	if not exist %VSCODE_EXE% %dk_call% dk_error "cannot find %VSCODE_EXE%"
	:vscodeInstalled
	
	::###### dk_installVSCodeFileAssociations.cmd ######
	%dk_call% %DKIMPORTS_DIR%\vscode\dk_installVSCodeFileAssociations.cmd
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_installVSCode
%endfunction%
