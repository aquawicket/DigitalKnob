@echo off

if "%~1" neq "" (goto:runDKVb)
:installDKVb
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
	::###### Install DKVb ######
	call dk_echo "Installing DKVb . . ."
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.vbs
	set "DKVB_FUNCTIONS_DIR=..\DKVb\functions"
	set "WSCRIPT_EXE=%SystemRoot%\System32\WScript.exe"
	
	
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKVb"
	ftype DKVb=cmd /c call "%~f0" "%DKVB_FUNCTIONS_DIR%" "%WSCRIPT_EXE%" "%%1" %*
	call dk_registrySetKey "HKEY_CLASSES_ROOT\DKVb\DefaultIcon" "" "REG_SZ" "%WSCRIPT_EXE%"
	
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\.vbs"
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.vbs"
	assoc .vbs=DKVb
	
	call dk_echo "DKVb install complete"
goto:eof


:runDKVb
	set "DKVB_FUNCTIONS_DIR=%~1"
	set "WSCRIPT_EXE=%~2"
	set "DKSCRIPT_PATH=%~3"
	start %WSCRIPT_EXE% %DKSCRIPT_PATH%
goto:eof