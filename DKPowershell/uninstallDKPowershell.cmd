@echo off
::call "%DKBATCH_FUNCTIONS_DIR%\DK.cmd"

:uninstallDKPowershell
	::###### DKINIT ######
	set "DIGITALKNOB_DIR=%HOMEDRIVE%%HOMEPATH%\digitalknob"
	set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\Development"
	set "DKBATCH_FUNCTION_DIR=%DKBRANCH_DIR%\DKBatch\functions"
	set "DKBATCH_FUNCTION_DIR_=%DKBATCH_FUNCTION_DIR%\"
	call "%DKBATCH_FUNCTION_DIR_%DK.cmd"
	
	echo Uninstalling .ps1 file associations . . .
	
	ftype dkpowershell=
	assoc .ps1=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\dkpowershell"
goto:eof
