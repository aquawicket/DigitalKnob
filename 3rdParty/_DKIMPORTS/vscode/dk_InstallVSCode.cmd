@echo off
call ../../../DKBatch/functions/DK.cmd
call dk_includeGuard

::####################################################################
::# dk_InstallVSCode()
::#
::#
:dk_InstallVSCode () {
	call dk_debugFunc
	
	call dk_validate DKIMPORTS_DIR dk_getDKPaths
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/vscode/DKMAKE.cmake')" "VSCODE_EXE"
	call dk_printVar VSCODE_EXE
    call dk_checkError
goto:eof