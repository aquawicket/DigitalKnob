@echo off

if "%~1" neq "" goto runDKBatch
:dk_install_tcc
	::###### DKINIT ######
	if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\")
	if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)
	
	::###### Install DKBatch ######
	%dk_call% dk_echo "Installing DKBatch . . ."
	%dk_call% dk_validate DKBATCH_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_findProgram TCC_EXE "tcc.exe" "%DKTOOLS_DIR%"
	%dk_call% dk_set COMSPEC %TCC_EXE%
	
	%dk_call% dk_registryDeleteKey "HKCR\DKBatch"
	ftype DKBatch="%COMSPEC%" /c call "%~f0" "%DKBATCH_FUNCTIONS_DIR%" "%COMSPEC%" "%%1" %%*
	%dk_call% dk_registrySetKey "HKCR\DKBatch\DefaultIcon" "" "REG_SZ" "%COMSPEC%"
	%dk_call% dk_registryDeleteKey "HKCR\.cmd"
	%dk_call% dk_registryDeleteKey "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cmd"
	assoc .cmd=DKBatch
	
	%dk_call% dk_success "DKBatch install complete"
%endfunction%


:runDKBatch
	set "DKBATCH_FUNCTIONS_DIR=%~1"
	set "DKBATCH_FUNCTIONS_DIR_=%~1\"
	set "COMSPEC=%~2"
	set "DKSCRIPT_PATH=%~3"
	
	::###### run script ######
	:: /K		keep the window open at the CMD prompt.
	:: /V:ON	enable delayed expansion
	"%COMSPEC%" /V:ON /K call "%DKSCRIPT_PATH%" && (echo returned TRUE) || (echo returned FALSE)

	::###### exit_code ######
	if %ERRORLEVEL% neq 0 echo ERROR:%ERRORLEVEL% && pause
	
	::###### reload ######
::	if not exist %~dp0\reload goto:eof
::	del %~dp0\reload
::	cls
::	goto runDKBatch	
%endfunction%
