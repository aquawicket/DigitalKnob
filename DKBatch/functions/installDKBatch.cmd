@echo off


:DKTEST
:installDKBatch
	call "%DKBATCH_FUNCTION_DIR_%DK.cmd" %0 %*
	
	if not "%*" == "" (goto:run_file)
	echo Associating .cmd files with DKBatch . . .
	
	call dk_load dk_validate
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	
	ftype dk_batch=cmd /c call "%~f0" "%DKBATCH_FUNCTIONS_DIR%" "%%1" %*
	assoc .cmd=dk_batch
	call dk_registrySetKey "HKEY_CLASSES_ROOT\dk_batch\DefaultIcon" "" "REG_SZ" "C:\Windows\System32\cmd.exe"
goto:eof



:run_file
	echo dk_installDKBatch(%0 %*)
	set "DKBATCH_FUNCTIONS_DIR=%~1"
	set "DKBATCH_FUNCTIONS_DIR_=%~1\"
	set "CMD_FILE=%~2"
	cmd /c call %CMD_FILE%
goto:eof