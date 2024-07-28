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
	ftype DKVb=cmd /c call "%~f0" "%DKVB_FUNCTIONS_DIR%" "%WSCRIPT_EXE%" "%%1" %*
	::assoc .dkvb=DKVb
	assoc .vbs=DKVb
	call dk_registrySetKey "HKEY_CLASSES_ROOT\DKVb\DefaultIcon" "" "REG_SZ" "%WSCRIPT_EXE%"
	
	call dk_echo DKVb install complete
	call dk_pause
goto:eof


:runDKVb
	set "DKVB_FUNCTIONS_DIR=%~1"
	set "WSCRIPT_EXE=%~2"
	set "DKVB_FILE=%~3"
	start %WSCRIPT_EXE% %DKVB_FILE%
goto:eof