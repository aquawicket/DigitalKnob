@echo off
call "..\..\..\DKBatch\functions\DK.cmd"

::####################################################################
::# dk_installVSCode()
::#
::#
:dk_installVSCodeFileAssociations
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate VSCODE_EXE "call %DKIMPORTS_DIR%\vscode\dk_installVSCode"
	call dk_installFileAssoc .vscode %VSCODE_EXE%
	call dk_installFileAssoc .code-workspace %VSCODE_EXE%
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_installVSCodeFileAssociations
goto:eof
