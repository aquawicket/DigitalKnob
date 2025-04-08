@echo off
if "%~1" equ "" (goto DKINSTALL)

:runDKPowershell
	echo runDKPowershell %*
	set "DKPOWERSHELL_FUNCTIONS_DIR=%~1"
	echo DKPOWERSHELL_FUNCTIONS_DIR = %DKPOWERSHELL_FUNCTIONS_DIR%

	set "POWERSHELL_EXE=%~2"
	echo POWERSHELL_EXE = %POWERSHELL_EXE%

	set "DKSCRIPT_PATH=%~3"
	echo DKSCRIPT_PATH = %DKSCRIPT_PATH%

	::###### run script ######
	%COMSPEC% /v:on /K call %POWERSHELL_EXE% -Command %DKSCRIPT_PATH%; exit $LASTEXITCODE && (echo returned TRUE) || (echo returned FALSE)

	::###### exit_code ######
	if %ERRORLEVEL% neq 0 (
		echo ERROR:%ERRORLEVEL%
		pause
	)
%endfunction%



















:DKINSTALL
	if "%~1" neq "" (goto:eof)

	echo Installing DKPowershell . . .
	
	::###### DK_CMD ######
	if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r %USERPROFILE% DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
	if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

	::###### Install DKPowershell ######
	%dk_call% dk_validate DKIMPORTS_DIR 				"%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate POWERSHELL_EXE 				"%dk_call% dk_POWERSHELL_EXE"
	%dk_call% dk_validate DKPOWERSHELL_FUNCTIONS_DIR	"%dk_call% dk_DKBRANCH_DIR"

	::###### DKPowershell ######
	ftype DKPowershell="%COMSPEC%" /V:ON /K call "%~f0" "%DKPOWERSHELL_FUNCTIONS_DIR%" "%POWERSHELL_EXE%" "%%1" %*
	%dk_call% dk_registrySetKey "HKCR/DKPowershell/DefaultIcon" "" "REG_SZ" "%POWERSHELL_EXE%"

	::###### .ps1 ######
	assoc .ps1=DKPowershell

	%dk_call% dk_success "DKPowershell install complete"
%endfunction%