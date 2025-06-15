@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL
::#
::#
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_getFileParams "%~dp0/dkconfig.txt"
	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
	set "VSCODE_IMPORT=!VSCode_%Host_Tuple%_Import!"
	%dk_call% dk_assertVar VSCODE_IMPORT
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_importVariables %VSCODE_IMPORT% ROOT %DKTOOLS_DIR%
	%dk_call% dk_assertVar VSCODE
	
	%dk_call% dk_Host_Os
	if defined Windows_Host (
		%dk_call% dk_set VSCODE_EXE "%VSCODE%/Code.exe"
	) else (
		%dk_call% dk_set VSCODE_EXE "%VSCODE%/code"
	)	
	if exist %VSCODE_EXE% (%return%)
	
	%dk_call% dk_echo
    %dk_call% dk_info "Installing VSCode . . ."
	%dk_call% dk_download %VSCODE_IMPORT%
	%dk_call% dk_smartExtract "%dk_download%" "%VSCODE%"
	%dk_call% dk_mkdir %VSCODE%/data
	%dk_call% dk_assertFile VSCODE_EXE
	
	::###### dk_installVSCodeFileAssociations.cmd ######
	%dk_call% "%DKIMPORTS_DIR%/vscode/fileAssoc/DKINSTALL.cmd"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKINSTALL
%endfunction%
