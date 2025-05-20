@echo off
echo line:2 %~0(%*)


goto:after
set "DE=1"
setlocal enableDelayedExpansion
set PRINT_DE_VAR_A=if ^!DE^! equ 1 (echo ^!DE^! equ 1) else (echo ^!DE^! neq 1)
set PRINT_DE_VAR_B=if "^!DE^!" equ "1" (echo "^!DE^!" equ "1") else (echo "^!DE^!" neq "1")
set PRINT_DE_VAR_C=if "!!DE!!" equ "1" (echo "3" equ "1") else (echo "3" neq "1")
set PRINT_DE_VAR_D=if !!DE!! equ 1 (echo 4 equ 1) else (echo 4 neq 1)
set PRINT_DE_STATUS=if ^!DE^! neq 1 (echo disabled_1) else if "^!DE^!" equ "1" (echo enabled_1) else if "!!DE!!" neq "1" (echo enabled_2) else (echo disabled_2)

echo:
setlocal enableDelayedExpansion
echo ENABLED
%PRINT_DE_VAR_A%
%PRINT_DE_VAR_B%
%PRINT_DE_VAR_C%
%PRINT_DE_VAR_D%
%PRINT_DE_STATUS% 
echo DE = %DE% = !DE!

echo:
setlocal disableDelayedExpansion
echo DISABLED
%PRINT_DE_VAR_A%
%PRINT_DE_VAR_B%
%PRINT_DE_VAR_C%
%PRINT_DE_VAR_D%
%PRINT_DE_STATUS%
echo DE = %DE% = !DE!

echo:
setlocal enableDelayedExpansion
echo ENABLED
%PRINT_DE_VAR_A%
%PRINT_DE_VAR_B%
%PRINT_DE_VAR_C%
%PRINT_DE_VAR_D%
%PRINT_DE_STATUS%
echo DE = %DE% = !DE!
:after



if "%~1" equ "" (goto DKINSTALL)

:runDKcmd
	echo :runDKcmd
	if not exist "%DKBATCH_FUNCTIONS_DIR%"	(set "DKBATCH_FUNCTIONS_DIR=%~1")
	if not exist "%DKBATCH_FUNCTIONS_DIR_%"	(set "DKBATCH_FUNCTIONS_DIR_=%~1\")
	if not exist "%CMD_EXE%"				(set "CMD_EXE=%~2")
	if not exist "%DKSCRIPT_PATH%"			(set "DKSCRIPT_PATH=%~3")
	if not defined DKSCRIPT_ARGS			(for /F "usebackq tokens=4*" %%a in ('%*') do set DKSCRIPT_ARGS=%%b)
	::if not exist "%TCC_EXE%"				(set "TCC_EXE=C:/Users/Administrator/digitalknob/DKTools/tcc-rt-master/tcc.exe")
	
	::###### run script ######
	:: "%ComSpec%"	path to cmd.exe
	:: /V:ON		enable delayed expansion
	:: /K			keep the window open at the CMD prompt.
	start "" "%CMD_EXE:/=\%" /V:ON /K "%DKSCRIPT_PATH%"
	::(start "" /b "%TCC_EXE:/=\%" /V:ON /K %DKSCRIPT_PATH% & pause)

	::"%ComSpec%" /V:ON /K call "%DKSCRIPT_PATH%" %DKSCRIPT_ARGS%

	::###### exit_code ######
	if %ERRORLEVEL% neq 0 (
		echo exit_code:%ERRORLEVEL%
	)

%endfunction%













:DKINSTALL
	if "%~1" neq "" (goto:eof)
	echo :DKINSTALL
	

	::#################################################### DigitalKnob DKBatch ########################################################################
	if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
	if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
	::#################################################################################################################################################

	echo Installing DKcmd . . .
	
	::###### Install DKcmd ######
	%dk_call% dk_validate DKBATCH_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_validate CMD_EXE "%dk_call% dk_CMD_EXE"

	:: Set the registry entry for the exxtension
	ftype DKcmd="%CMD_EXE:/=\%" /c if exist "%~f0" ^
	(echo DKcmd installed ^& "%CMD_EXE:/=\%" /c call "%~f0" "%DKBATCH_FUNCTIONS_DIR%" "%CMD_EXE%" "%%1" %%*) else ^
	(echo DKcmd not installed ^& "%%1" %%*)

	%dk_call% dk_registrySetKey "HKCR/DKcmd/DefaultIcon" "" "REG_SZ" "%CMD_EXE%"
	assoc .cmd=DKcmd

	%dk_call% dk_success "DKcmd install complete"
%endfunction%