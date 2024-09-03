@echo off

if "%~1" neq "" goto:runDKBatch
:installDKBatch
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd" %~0
	
	::###### Install DKBatch ######
	%dk_call% dk_echo "Installing DKBatch . . ."
	%dk_call% dk_validate DKBATCH_FUNCTIONS_DIR "%dk_call% dk_validateBranch"
	%dk_call% dk_findProgram CMD_EXE "cmd.exe" "%windir%\system32"
	%dk_call% dk_set ComSpec %CMD_EXE%
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKBatch"
	ftype DKBatch="%ComSpec%" /c call "%~f0" "%DKBATCH_FUNCTIONS_DIR%" "%ComSpec%" "%%1" %%*
	%dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\DKBatch\DefaultIcon" "" "REG_SZ" "%ComSpec%"
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.cmd"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cmd"
	assoc .cmd=DKBatch
	
	%dk_call% dk_echo "DKBatch install complete"
goto:eof


:runDKBatch
	set "DKBATCH_FUNCTIONS_DIR=%~1"
	set "DKBATCH_FUNCTIONS_DIR_=%~1\"
	set "ComSpec=%~2"
	set "DKSCRIPT_PATH=%~3"
	set "DKTEMP_DIR=%DKBATCH_FUNCTIONS_DIR%\..\..\..\temp"
	
	::###### run script ######
	:: /K		keep the window open at the CMD prompt.
	:: /V:ON	enable delayed expansion
	"%ComSpec%" /V:ON /K call "%DKSCRIPT_PATH%"
	
	::###### exit_code ######
	if %ERRORLEVEL% neq 0 echo ERROR:%ERRORLEVEL% & pause
	
	::###### reload ######
	if not exist "%DKTEMP_DIR%\reload" pause & goto:eof
	del "%DKTEMP_DIR%\reload"
	goto:runDKBatch
	
goto:eof
