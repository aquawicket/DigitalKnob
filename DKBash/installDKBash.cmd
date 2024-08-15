@echo off

if "%~1" neq "" (goto:runDKBash)
:installDKBash	
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
	::###### Install DKBash ######
	%dk_call% dk_echo "Installing DKBash . . ."
	%dk_call% dk_validate DKBASH_FUNCTIONS_DIR "%dk_call% dk_validateBranch"
	%dk_call% dk_validate GITBASH_EXE "%dk_call% dk_installGit"
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKBash"
	ftype DKBash=cmd /c call "%~f0" "%DKBASH_FUNCTIONS_DIR%" "%GITBASH_EXE%" "%%1" %*
	%dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\DKBash\DefaultIcon" "" "REG_SZ" "%GITBASH_EXE%"
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.sh"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.sh
	assoc .sh=DKBash
	
	%dk_call% dk_echo "DKBash install complete"
goto:eof


:runDKBash
	set "DKBASH_FUNCTIONS_DIR=%~1"
	set "GITBASH_EXE=%~2"
	set "DKBASH_FILE=%~3"
	%GITBASH_EXE% %DKBASH_FILE% && (echo returned TRUE) || (echo returned FALSE)
	echo ERRORLEVEL = %ERRORLEVEL%
	pause
goto:eof
