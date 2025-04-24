@echo off
if "%~1" equ "" (goto DKINSTALL)

:runDKPowershell
	set "DKPOWERSHELL_FUNCTIONS_DIR=%~1"
	set "POWERSHELL_EXE=%~2"
	set "DKSCRIPT_PATH=%~3"

	::###### run script ######
	:: "%ComSpec%"	path to cmd.exe
	:: /V:ON		enable delayed expansion
	:: /K			keep the window open at the CMD prompt.
	%ComSpec% /V:ON /K call %POWERSHELL_EXE% -Command %DKSCRIPT_PATH%; exit $LASTEXITCODE && (echo returned TRUE) || (echo returned FALSE)

	::###### exit_code ######
	if %ERRORLEVEL% neq 0 (
		echo ERROR:%ERRORLEVEL%
		pause
	)
%endfunction%



















:DKINSTALL
	if "%~1" neq "" (goto:eof)

	echo Installing DKPowershell . . .
	
	::###### DK.cmd ######
	if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../DKBatch/functions/")
	if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
	if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

	::###### Install DKPowershell ######
	%dk_call% dk_validate DKIMPORTS_DIR 				"%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate POWERSHELL_EXE 				"%dk_call% dk_POWERSHELL_EXE"
	%dk_call% dk_validate DKPOWERSHELL_FUNCTIONS_DIR	"%dk_call% dk_DKBRANCH_DIR"

	::###### DKPowershell ######
	ftype DKPowershell="%ComSpec%" /V:ON /K call "%~f0" "%DKPOWERSHELL_FUNCTIONS_DIR%" "%POWERSHELL_EXE%" "%%1" %*
	%dk_call% dk_registrySetKey "HKCR/DKPowershell/DefaultIcon" "" "REG_SZ" "%POWERSHELL_EXE%"

	::###### .ps1 ######
	assoc .ps1=DKPowershell

	%dk_call% dk_success "DKPowershell install complete"
%endfunction%