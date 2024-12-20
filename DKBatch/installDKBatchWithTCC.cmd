@echo off

if "%~1" neq "" goto runDKBatch
:installDKBatch
	::###### DKINIT ######
	if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\"
	if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
	
	::###### Install DKBatch ######
	%dk_call% dk_echo "Installing DKBatch . . ."
	%dk_call% dk_validate DKBATCH_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DIGITALKNOB_DIR"
	%dk_call% dk_findProgram TCC_EXE "tcc.exe" "%DKTOOLS_DIR%"
	%dk_call% dk_set ComSpec %TCC_EXE%
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKBatch"
	ftype DKBatch="%ComSpec%" /c call "%~f0" "%DKBATCH_FUNCTIONS_DIR%" "%ComSpec%" "%%1" %%*
	%dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\DKBatch\DefaultIcon" "" "REG_SZ" "%ComSpec%"
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.cmd"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cmd"
	assoc .cmd=DKBatch
	
	%dk_call% dk_success "DKBatch install complete"
%endfunction%


:runDKBatch
	set "DKBATCH_FUNCTIONS_DIR=%~1"
	set "DKBATCH_FUNCTIONS_DIR_=%~1\"
	set "ComSpec=%~2"
	set "DKSCRIPT_PATH=%~3"
	
	::###### run script ######
	:: /K		keep the window open at the CMD prompt.
	:: /V:ON	enable delayed expansion
	"%ComSpec%" /V:ON /K call "%DKSCRIPT_PATH%" && (echo returned TRUE) || (echo returned FALSE)

	::###### exit_code ######
	if %ERRORLEVEL% neq 0 echo ERROR:%ERRORLEVEL% && pause
	
	::###### reload ######
	if not exist %~dp0\reload goto:eof
	del %~dp0\reload
	cls
	goto runDKBatch
	
%endfunction%
