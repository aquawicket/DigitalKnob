@echo off

if "%~1" equ "%~0" goto:installDKBatch
if "%~1" neq ""    goto:runDKBatch
:installDKBatch
	::###### DKINIT ######
	if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\"
	if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

	::###### Install DKBatch ######
	%dk_call% dk_echo "Installing DKBatch . . ."
	%dk_call% dk_validate DKBATCH_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_findProgram CMD_EXE "cmd.exe" "%windir%\system32"
	%dk_call% dk_set ComSpec %CMD_EXE%
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKBatch"
	
	:: Set the registry entry for the exxtension
	ftype DKBatch="%ComSpec%" /c if exist "%~f0" ^
	(echo installed ^& "%ComSpec%" /c call "%~f0" "%DKBATCH_FUNCTIONS_DIR%" "%ComSpec%" "%DKCACHE_DIR%" "%%1" %%*) else ^
	(echo not installed ^& "%%1" %%*)
	
	%dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\DKBatch\DefaultIcon" "" "REG_SZ" "%ComSpec%"
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.cmd"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cmd"
	assoc .cmd=DKBatch
	
	%dk_call% dk_success "DKBatch install complete"
%endfunction%


:runDKBatch
	if not exist "%DKBATCH_FUNCTIONS_DIR%"   set "DKBATCH_FUNCTIONS_DIR=%~1"
	if not exist "%DKBATCH_FUNCTIONS_DIR_%"  set "DKBATCH_FUNCTIONS_DIR_=%~1\"
	if not exist "%ComSpec%"                 set "ComSpec=%~2"
	if not exist "%DKCACHE_DIR%"              set "DKCACHE_DIR=%~3"
	if not exist "%DKSCRIPT_PATH%"           set "DKSCRIPT_PATH=%~4"
	if not defined DKSCRIPT_ARGS             for /f "tokens=4,* delims= " %%a in ("%*") do set DKSCRIPT_ARGS=%%b
	
	::echo DKBATCH_FUNCTIONS_DIR  = %DKBATCH_FUNCTIONS_DIR%
	::echo DKBATCH_FUNCTIONS_DIR_ = %DKBATCH_FUNCTIONS_DIR_%
	::echo ComSpec                = %ComSpec%
	::echo DKCACHE_DIR            = %DKCACHE_DIR%
	::echo DKSCRIPT_PATH          = %DKSCRIPT_PATH%
	::echo DKSCRIPT_ARGS          = %DKSCRIPT_ARGS%
	
	::###### run script ######
	:: /K		keep the window open at the CMD prompt.
	:: /V:ON	enable delayed expansion
	::"%ComSpec%" /V:ON /K call "%DKSCRIPT_PATH%" %DKSCRIPT_ARGS%
	"%ComSpec%" /V:ON /K call "%DKSCRIPT_PATH%"
	
	::###### exit_code ######
	if %ERRORLEVEL% gtr 0 echo exit_code:%ERRORLEVEL% & pause
	
	::###### reload ######
	if not exist "%DKCACHE_DIR%\reload" goto:eof
	del "%DKCACHE_DIR%\reload"
	goto:runDKBatch
	
%endfunction%
