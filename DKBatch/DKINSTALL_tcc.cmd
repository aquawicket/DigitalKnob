@echo off
if "%~1" equ "" (goto DKINSTALL)

:runDKtcc
	if not exist "%DKBATCH_FUNCTIONS_DIR%"	(set "DKBATCH_FUNCTIONS_DIR=%~1")
	if not exist "%DKBATCH_FUNCTIONS_DIR_%"	(set "DKBATCH_FUNCTIONS_DIR_=%~1\")
	if not exist "%TCC_EXE%"				(set "TCC_EXE=%~2")
	if not exist "%DKCACHE_DIR%"			(set "DKCACHE_DIR=%~3")
	if not exist "%DKSCRIPT_PATH%"			(set "DKSCRIPT_PATH=%~4")
	if not defined DKSCRIPT_ARGS			(for /F "usebackq tokens=4*" %%a in ('%*') do set DKSCRIPT_ARGS=%%b)

	::###### run script ######
	:: "%TCC_EXE%"	path to tcc.exe
	:: /V:ON		enable delayed expansion
	:: /K			keep the window open at the TCC prompt.
	"%TCC_EXE%" /V:ON /K call "%DKSCRIPT_PATH%"
	::"%TCC_EXE%" /V:ON /K call "%DKSCRIPT_PATH%" %DKSCRIPT_ARGS%

	::###### exit_code ######
	if %ERRORLEVEL% neq 0 (
		echo exit_code:%ERRORLEVEL%
	)

%endfunction%
















:DKINSTALL
	if "%~1" neq "" (goto:eof)
	
	::#################################################### DigitalKnob DKBatch ########################################################################
	if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
	if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
	::#################################################################################################################################################
	
	::###### Install DKtcc ######
	%dk_call% dk_echo "Installing DKtcc . . ."
	%dk_call% dk_validate DKBATCH_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_validate DKTOOLS_DIR 			"%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_validate DKIMPORTS_DIR 		"%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate TCC_EXE 				"%dk_call% "%DKIMPORTS_DIR%/tcc-rt/DKINSTALL.cmd"
	::%dk_call% dk_findProgram TCC_EXE 			"tcc.exe" "%DKTOOLS_DIR%"
	::%dk_call% dk_set ComSpec 					"%TCC_EXE%"
	
	%dk_call% dk_registryDeleteKey 	"HKCR\DKtcc"
	ftype DKtcc="%ComSpec%" /c call "%~f0" "%DKBATCH_FUNCTIONS_DIR%" "%TCC_EXE%" "%%1" %%*
	%dk_call% dk_registrySetKey 	"HKCR\DKtcc\DefaultIcon" "" "REG_SZ" "%TCC_EXE%"
	%dk_call% dk_registryDeleteKey 	"HKCR\.cmd"
	%dk_call% dk_registryDeleteKey 	"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cmd"
	assoc .cmd=DKtcc
	
	%dk_call% dk_success "DKtcc install complete"
%endfunction%



