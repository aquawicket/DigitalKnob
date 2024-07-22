@echo off

if "%~1" neq "" goto:runDKBatch
:installDKBatch
	echo Associating .cmd files with DKBatch . . .
	
	set "DKBATCH_FUNCTIONS_DIR_=%HOMEDRIVE%%HOMEPATH%\digitalknob\Development\DKBatch\functions\"
	call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"
	call dk_validate DKBATCH_FUNCTIONS_DIR "call dk_validateBranch"
	ftype dkbatch=cmd /c call "%~f0" "%DKBATCH_FUNCTIONS_DIR%" "%%1" %%*
	assoc .cmd=dkbatch
	call dk_registrySetKey "HKEY_CLASSES_ROOT\dkbatch\DefaultIcon" "" "REG_SZ" "C:\Windows\System32\cmd.exe"
	
	echo DKBatch install complete 
goto:eof



:runDKBatch
	set "DKBATCH_FUNCTIONS_DIR=%~1"
	set "DKBATCH_FUNCTIONS_DIR_=%~1\"
	set "CMD_FILE=%~2"
	
	:: /K		keep the window open at the CMD prompt.
	:: /V:ON	enable delayed expansion
	cmd /V:ON /K call "%CMD_FILE%"
goto:eof
