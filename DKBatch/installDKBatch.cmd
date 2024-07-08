@echo off


if exist %DKBATCH_FUNCTION_DIR_%DK.cmd call %DKBATCH_FUNCTION_DIR_%DK.cmd %0 %*
if not "%*" == "" (goto:runDKBatch)

	
:installDKBatch
	echo Associating .cmd files with DKBatch . . .
	
	call dk_load dk_validate
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	
	ftype dkbatch=cmd /c call "%~f0" "%DKBATCH_FUNCTIONS_DIR%" "%%1" %*
	assoc .cmd=dkbatch
	call dk_registrySetKey "HKEY_CLASSES_ROOT\dkbatch\DefaultIcon" "" "REG_SZ" "C:\Windows\System32\cmd.exe"
goto:eof



:runDKBatch
	echo dk_installDKBatch(%0 %*)
	
	set "DKBATCH_FUNCTIONS_DIR=%~1"
	set "DKBATCH_FUNCTIONS_DIR_=%~1\"
	echo "DKBATCH_FUNCTIONS_DIR_ = %DKBATCH_FUNCTIONS_DIR_%"
	set "CMD_FILE=%~2"
	cmd /c call %CMD_FILE%
goto:eof