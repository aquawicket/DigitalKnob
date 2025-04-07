@echo off
if "%~1" equ "" (goto dk_install)

:runDKBatch
	if not exist "%DKBATCH_FUNCTIONS_DIR%"	(set "DKBATCH_FUNCTIONS_DIR=%~1")
	if not exist "%DKBATCH_FUNCTIONS_DIR_%"	(set "DKBATCH_FUNCTIONS_DIR_=%~1\")
	if not exist "%COMSPEC%"				(set "COMSPEC=%~2")
	if not exist "%DKCACHE_DIR%"			(set "DKCACHE_DIR=%~3")
	if not exist "%DKSCRIPT_PATH%"			(set "DKSCRIPT_PATH=%~4")
	if not defined DKSCRIPT_ARGS			(for /F "usebackq tokens=4*" %%a in ('%*') do set DKSCRIPT_ARGS=%%b)

	::###### run script ######
	:: /K		keep the window open at the CMD prompt.
	:: /V:ON	enable delayed expansion
	"%COMSPEC%" /V:ON /K call "%DKSCRIPT_PATH%"
	::"%COMSPEC%" /V:ON /K call "%DKSCRIPT_PATH%" %DKSCRIPT_ARGS%

	::###### exit_code ######
	if %ERRORLEVEL% neq 0 (
		echo exit_code:%ERRORLEVEL%
	)

%endfunction%













:dk_install
	if "%~1" neq "" (goto:eof)

	echo Installing DKBatch . . .
	
	::###### DK_CMD ######
	if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r %USERPROFILE% DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
	if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

	::###### Install DKBatch ######
	%dk_call% dk_validate DKBATCH_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_validate CMD_EXE "%dk_call% dk_CMD_EXE"

	:: Set the registry entry for the exxtension
	ftype DKBatch="%COMSPEC%" /c if exist "%~f0" ^
	(echo DKBatch installed ^& "%COMSPEC%" /c call "%~f0" "%DKBATCH_FUNCTIONS_DIR%" "%COMSPEC%" "%DKCACHE_DIR%" "%%1" %%*) else ^
	(echo DKBatch not installed ^& "%%1" %%*)

	%dk_call% dk_registrySetKey "HKCR\DKBatch\DefaultIcon" "" "REG_SZ" "%COMSPEC%"
	assoc .cmd=DKBatch

	%dk_call% dk_success "DKBatch install complete"
%endfunction%