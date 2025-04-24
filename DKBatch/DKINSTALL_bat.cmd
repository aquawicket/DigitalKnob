@echo off
if "%~1" equ "" (goto DKINSTALL)

:runDKbat
	if not exist "%DKBATCH_FUNCTIONS_DIR%"	(set "DKBATCH_FUNCTIONS_DIR=%~1")
	if not exist "%DKBATCH_FUNCTIONS_DIR_%"	(set "DKBATCH_FUNCTIONS_DIR_=%~1\")
	if not exist "%ComSpec%"				(set "ComSpec=%~2")
	if not exist "%DKCACHE_DIR%"			(set "DKCACHE_DIR=%~3")
	if not exist "%DKSCRIPT_PATH%"			(set "DKSCRIPT_PATH=%~4")
	if not defined DKSCRIPT_ARGS			(for /F "usebackq tokens=4*" %%a in ('%*') do set DKSCRIPT_ARGS=%%b)

	::###### run script ######
	:: "%ComSpec%"	path to cmd.exe
	:: /V:ON		enable delayed expansion
	:: /K			keep the window open at the CMD prompt.
	"%ComSpec%" /V:ON /K call "%DKSCRIPT_PATH%"
	::"%ComSpec%" /V:ON /K call "%DKSCRIPT_PATH%" %DKSCRIPT_ARGS%

	::###### exit_code ######
	if %ERRORLEVEL% neq 0 (
		echo exit_code:%ERRORLEVEL%
	)

%endfunction%













:DKINSTALL
	if "%~1" neq "" (goto:eof)

	::#################################################### DigitalKnob DKBatch ########################################################################
	if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
	if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
	::#################################################################################################################################################

	echo Installing DKbat . . .
	
	::###### Install DKbat ######
	%dk_call% dk_validate DKBATCH_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_validate CMD_EXE "%dk_call% dk_CMD_EXE"

	:: Set the registry entry for the exxtension
	ftype DKbat="%ComSpec%" /c if exist "%~f0" ^
	(echo DKbat installed ^& "%ComSpec%" /c call "%~f0" "%DKBATCH_FUNCTIONS_DIR%" "%ComSpec%" "%DKCACHE_DIR%" "%%1" %%*) else ^
	(echo DKbat not installed ^& "%%1" %%*)

	%dk_call% dk_registrySetKey "HKCR\DKbat\DefaultIcon" "" "REG_SZ" "%ComSpec%"
	assoc .cmd=DKbat

	%dk_call% dk_success "DKbat install complete"
%endfunction%