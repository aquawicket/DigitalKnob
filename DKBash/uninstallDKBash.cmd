@echo off

:uninstallDKBash
	::###### DKINIT ######
	set "DIGITALKNOB_DIR=%HOMEDRIVE%%HOMEPATH%\digitalknob"
	set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\Development"
	set "DKBATCH_FUNCTION_DIR=%DKBRANCH_DIR%\DKBatch\functions"
	set "DKBATCH_FUNCTION_DIR_=%DKBATCH_FUNCTION_DIR%\"
	call "%DKBATCH_FUNCTION_DIR_%DK.cmd"
	
	echo Uninstalling .sh file associations . . .
	
	ftype dkbash=
	assoc .sh=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\dkbash"
goto:eof
