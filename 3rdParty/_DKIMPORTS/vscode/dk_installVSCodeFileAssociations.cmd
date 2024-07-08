@echo off
call ..\..\..\DKBatch\functions\DK.cmd


call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
call dk_validate VSCODE_EXE "call %DKIMPORTS_DIR%\vscode\dk_installVSCode"

call dk_installFileAssoc .vscode %VSCODE_EXE%
call dk_installFileAssoc .code-workspace %VSCODE_EXE%
