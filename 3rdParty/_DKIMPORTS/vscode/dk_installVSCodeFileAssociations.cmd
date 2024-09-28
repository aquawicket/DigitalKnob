@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_installVSCode()
::#
::#
:dk_installVSCodeFileAssociations
	call dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_validate VSCODE_EXE "call %DKIMPORTS_DIR%\vscode\dk_installVSCode"
	call dk_installFileAssoc .vscode %VSCODE_EXE%
	call dk_installFileAssoc .code-workspace %VSCODE_EXE%
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_installVSCodeFileAssociations
%endfunction%
