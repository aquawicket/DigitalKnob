@echo off

if "%~1" neq "" (goto:runDKBash)
:installDKBash	
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
	::###### Install DKBash ######
	call dk_echo "Installing DKBash . . ."
	call dk_validate GITBASH_EXE "call dk_installGit"
	
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.sh
	ftype DKBash=cmd /c call "%~f0" "%DKBASH_FUNCTIONS_DIR%" "%GITBASH_EXE%" "%%1" %*
	assoc .sh=DKBash
	call dk_registrySetKey "HKEY_CLASSES_ROOT\DKBash\DefaultIcon" "" "REG_SZ" "%GITBASH_EXE%"
	
	call dk_echo "DKBash install complete"
	call dk_pause
goto:eof


:runDKBash
	set "DKBASH_FUNCTIONS_DIR=%~1"
	set "GITBASH_EXE=%~2"
	set "DKBASH_FILE=%~3"
	start %GITBASH_EXE% %DKBASH_FILE%
goto:eof
