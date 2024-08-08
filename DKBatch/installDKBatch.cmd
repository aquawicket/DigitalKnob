@echo off

if "%~1" neq "" goto:runDKBatch
:installDKBatch
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
	::###### Install DKBatch ######
	call dk_echo "Installing DKBatch . . ."
	call dk_validate DKBATCH_FUNCTIONS_DIR "call dk_validateBranch"
	
	
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKBatch"
	ftype DKBatch=cmd /c call "%~f0" "%DKBATCH_FUNCTIONS_DIR%" "%%1" %%*
	call dk_registrySetKey "HKEY_CLASSES_ROOT\DKBatch\DefaultIcon" "" "REG_SZ" "C:\Windows\System32\cmd.exe"
	
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\.cmd"
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cmd"
	assoc .cmd=DKBatch
	
	call dk_echo "DKBatch install complete"
goto:eof



:runDKBatch
	set "DKBATCH_FUNCTIONS_DIR=%~1"
	set "DKBATCH_FUNCTIONS_DIR_=%~1\"
	set "DKBATCH_FILE=%~2"
	
	:: /K		keep the window open at the CMD prompt.
	:: /V:ON	enable delayed expansion
	cmd /V:ON /K call "%DKBATCH_FILE%"
goto:eof
