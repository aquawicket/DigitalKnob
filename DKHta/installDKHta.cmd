@echo off

if "%~1" neq "" (goto:runDKHta)
:installDKHta
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
	::###### Install DKBash ######
	call dk_echo "Installing DKHta . . ."
	set "MSHTA_EXE=C:\Windows\SysWOW64\mshta.exe"
	set "DKHTA_FUNCTIONS_DIR=..\DKHta\functions"
	
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.hta
	::ftype DKHta=C:\Windows\SysWOW64\mshta.exe "%1" {1E460BD7-F1C3-4B2E-88BF-4E770A288AF5}%U{1E460BD7-F1C3-4B2E-88BF-4E770A288AF5} %*
	ftype DKHta=cmd /c call "%~f0" "%DKHTA_FUNCTIONS_DIR%" "%MSHTA_EXE%" "%%1" %*
	assoc .hta=DKHta
	call dk_registrySetKey "HKEY_CLASSES_ROOT\DKHta\DefaultIcon" "" "REG_SZ" "%MSHTA_EXE%"
	
	call dk_echo "DKHta install complete"
	call dk_pause
goto:eof


:runDKHta
	set "DKHTA_FUNCTIONS_DIR=%~1"
	set "MSHTA_EXE=%~2"
	set "HTA_FILE=%~3"
	start %MSHTA_EXE% %HTA_FILE%
goto:eof
