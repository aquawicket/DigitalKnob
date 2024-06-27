@echo off
::echo uninstall.cmd(%0 %*)

call "%DKBATCH_FUNCTION_DIR_%elevate.cmd" %~0 %*

net session >nul 2>&1
if %ERRORLEVEL% equ 0 (echo %green%Administrator Priviledges Detected%clr%) else (echo %red%Not an Admin%clr%)

call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

:DKTEST
:uninstall_launcher
	echo Uninstalling .cmd file associations . . .
	
	ftype dk_batch=
	assoc .cmd=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\dk_batch"
goto:eof
