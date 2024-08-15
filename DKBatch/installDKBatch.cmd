@echo off

if "%~1" neq "" goto:runDKBatch
:installDKBatch
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
	::###### Install DKBatch ######
	%dk_call% dk_echo "Installing DKBatch . . ."
	%dk_call% dk_validate DKBATCH_FUNCTIONS_DIR "%dk_call% dk_validateBranch"
	
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKBatch"
	ftype DKBatch=cmd /c call "%~f0" "%DKBATCH_FUNCTIONS_DIR%" "%%1" %%*
	%dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\DKBatch\DefaultIcon" "" "REG_SZ" "C:\Windows\System32\cmd.exe"
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.cmd"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cmd"
	assoc .cmd=DKBatch
	
	%dk_call% dk_echo "DKBatch install complete"
goto:eof


:runDKBatch
	set "DKBATCH_FUNCTIONS_DIR=%~1"
	set "DKBATCH_FUNCTIONS_DIR_=%~1\"
	set "DKBATCH_FILE=%~2"
	
	:: /K		keep the window open at the CMD prompt.
	:: /V:ON	enable delayed expansion
	cmd /V:ON /K call "%DKBATCH_FILE%" && (echo returned TRUE) || (echo returned FALSE)
	
	if %ERRORLEVEL% neq 0 echo ERROR:%ERRORLEVEL% && pause
	
	::###### reload ######
	if not exist %~dp0\reload goto:eof
	del %~dp0\reload
	cls
	goto:runDKBatch
	
goto:eof
