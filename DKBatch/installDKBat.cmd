@echo off


if "%~1" equ "%~0" goto installDKBat
if "%~1" neq ""    goto runDKBat
:installDKBat
	::###### DKINIT ######
	if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\"
	if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

	::###### Install DKBat ######
	%dk_call% dk_echo "Installing DKBat . . ."
	%dk_call% dk_validate DKBATCH_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_validate CMD_EXE "%dk_call% dk_CMD_EXE"
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKBat"
	
	:: Set the registry entry for the exxtension
	ftype DKBat="%COMSPEC%" /c if exist "%~f0" ^
	(echo installed ^& "%COMSPEC%" /c call "%~f0" "%DKBATCH_FUNCTIONS_DIR%" "%COMSPEC%" "%DKCACHE_DIR%" "%%1" %%*) else ^
	(echo not installed ^& "%%1" %%*)
	
	%dk_call% dk_registrySetKey    "HKEY_CLASSES_ROOT\DKBat\DefaultIcon" "" "REG_SZ" "%ComSpec%"
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.bat"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.bat"
	assoc .bat=DKBat
	
	%dk_call% dk_success "DKBat install complete"
%endfunction%


:runDKBat
	if not exist "%DKBATCH_FUNCTIONS_DIR%"   set "DKBATCH_FUNCTIONS_DIR=%~1"
	if not exist "%DKBATCH_FUNCTIONS_DIR_%"  set "DKBATCH_FUNCTIONS_DIR_=%~1\"
	if not exist "%ComSpec%"                 set "ComSpec=%~2"
	if not exist "%DKCACHE_DIR%"             set "DKCACHE_DIR=%~3"
	if not exist "%DKSCRIPT_PATH%"           set "DKSCRIPT_PATH=%~4"
	if not defined DKSCRIPT_ARGS             for /f "tokens=4,* delims= " %%a in ("%*") do set DKSCRIPT_ARGS=%%b
	
	::###### run script ######
	:: /K		keep the window open at the CMD prompt.
	:: /V:ON	enable delayed expansion
	::"%ComSpec%" /V:ON /K call "%DKSCRIPT_PATH%" %DKSCRIPT_ARGS%
	"%ComSpec%" /V:ON /K call "%DKSCRIPT_PATH%" && pause || pause
	
	if ERRORLEVEL 1 pause
	
	::###### exit_code ######
	if %ERRORLEVEL% neq 0 echo exit_code:%ERRORLEVEL% & pause
	
	::###### reload ######
	if not exist "%DKCACHE_DIR%\reload" goto:eof
	del "%DKCACHE_DIR%\reload"
	goto runDKBat
%endfunction%
