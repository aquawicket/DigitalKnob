@echo off

:installDKPowershell
	if not "%*" == "" (goto:runDKPowershell)
	echo Associating .ps1 files with DKPowershell . . .
	
	::###### DKINIT ######
	set "DIGITALKNOB_DIR=%HOMEDRIVE%%HOMEPATH%\digitalknob"
	set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\Development"
	set "DKBATCH_FUNCTION_DIR=%DKBRANCH_DIR%\DKBatch\functions"
	set "DKBATCH_FUNCTION_DIR_=%DKBATCH_FUNCTION_DIR%\"
	call "%DKBATCH_FUNCTION_DIR_%DK.cmd"
	
	call dk_load dk_validate
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate POWERSHELL_EXE "call %DKIMPORTS_DIR%\powershell\dk_installPowershell"
	
	ftype dkpowershell=cmd /c call "%~f0" "%DKPOWERSHELL_FUNCTIONS_DIR%" "%POWERSHELL_EXE%" "%%1" %*
	assoc .ps1=dkpowershell
	call dk_registrySetKey "HKEY_CLASSES_ROOT\dkpowershell\DefaultIcon" "" "REG_SZ" "%POWERSHELL_EXE%"
goto:eof


:runDKPowershell
	set "DKPOWERSHELL_FUNCTIONS_DIR=%~1"
	set "POWERSHELL_EXE=%~2"
	set "PS_FILE=%~3"

	echo ############### Digitalknob ##################
	start %POWERSHELL_EXE% %PS_FILE%
goto:eof