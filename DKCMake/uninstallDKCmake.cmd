@echo off
::call "%DKBATCH_FUNCTIONS_DIR%\DK.cmd"

:uninstall_launcher
	::###### DKINIT ######
	set "DIGITALKNOB_DIR=%HOMEDRIVE%%HOMEPATH%\digitalknob"
	set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\Development"
	set "DKBATCH_FUNCTIONS_DIR=%DKBRANCH_DIR%\DKBatch\functions"
	set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_FUNCTIONS_DIR%\"
	call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"
	
	echo Uninstalling .cmake file associations . . .
	
	ftype dkcmake=
	assoc .cmake=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\dkcmake"
goto:eof
