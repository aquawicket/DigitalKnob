@echo off

:DKTEST
:uninstallDKBatch

	call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

	call dk_echo "Uninstalling DKBatch file associations . . ."
	ftype dkbatch=
	assoc .cmd=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\dkbatch"
goto:eof