@echo off
if "%~1" equ "" (goto DKINSTALL)

:runDKbat
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR%"	(set "DKBATCH_FUNCTIONS_DIR=%~1")
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%"	(set "DKBATCH_FUNCTIONS_DIR_=%~1\")
	if NOT EXIST "%ComSpec%"				(set "ComSpec=%~2")
	if NOT EXIST "%DKCACHE_DIR%"			(set "DKCACHE_DIR=%~3")
	if NOT EXIST "%DKSCRIPT_PATH%"			(set "DKSCRIPT_PATH=%~4")
	if NOT defined DKSCRIPT_ARGS			(for /F "usebackq tokens=4*" %%a in ('%*') do set DKSCRIPT_ARGS=%%b)

	::###### run script ######
	:: "%ComSpec%"	path to cmd.exe
	:: /V:ON		enable delayed expansion
	:: /K			keep the window open at the CMD prompt.
	"%ComSpec%" /V:ON /K call "%DKSCRIPT_PATH%"
	::"%ComSpec%" /V:ON /K call "%DKSCRIPT_PATH%" %DKSCRIPT_ARGS%

	::###### exit_code ######
	if %errorlevel% neq 0 (
		echo exit_code:%errorlevel%
	)

%endfunction%













:DKINSTALL
	if "%~1" neq "" (goto:eof)

	@echo off&::###### DK.cmd #########################################################################################################################
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../DKBatch/functions/") 
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
	if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
	::#################################################################################################################################################

	echo Installing DKbat . . .
	
	::###### Install DKbat ######
	%dk_call% dk_validate DKBATCH_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_validate cmd_exe 				"%dk_call% dk_depend cmd_exe"

	:: Set the registry entry for the exxtension
	ftype DKbat="%ComSpec%" /c if EXIST "%~f0" ^
	(echo DKbat installed ^& "%ComSpec%" /c call "%~f0" "%DKBATCH_FUNCTIONS_DIR%" "%ComSpec%" "%DKCACHE_DIR%" "%%1" %%*) else ^
	(echo DKbat NOT installed ^& "%%1" %%*)

	%dk_call% dk_registrySetKey "HKCR/DKbat/DefaultIcon" "" "REG_SZ" "%ComSpec%"
	assoc .cmd=DKbat

	%dk_call% dk_success "DKbat install complete"
%endfunction%