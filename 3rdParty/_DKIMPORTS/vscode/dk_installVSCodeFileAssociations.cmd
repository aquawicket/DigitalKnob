@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\")
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_installVSCode()
::#
::#
:dk_installVSCodeFileAssociations
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate VSCODE_EXE "%dk_call% %DKIMPORTS_DIR%\vscode\dk_install.cmd"
	%dk_call% dk_installFileAssoc .vscode %VSCODE_EXE%
	%dk_call% dk_installFileAssoc .code-workspace %VSCODE_EXE%
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_installVSCodeFileAssociations
%endfunction%
