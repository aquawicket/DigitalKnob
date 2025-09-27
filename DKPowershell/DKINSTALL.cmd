@echo off
if "%~1" equ "" (goto DKINSTALL)

:runDKPowershell
	set "DKPOWERSHELL_FUNCTIONS_DIR=%~1"
	set "powershell_exe=%~2"
	set "DKSCRIPT_PATH=%~3"

	::###### run script ######
	:: "%ComSpec%"	path to cmd.exe
	:: /V:ON		enable delayed expansion
	:: /K			keep the window open at the CMD prompt.
	
	::%ComSpec% /V:ON /c call %powershell_exe% -Command "%DKSCRIPT_PATH%" && (echo returned TRUE) || (echo returned FALSE)
	::%ComSpec% /V:ON /c call %powershell_exe% -Command "%DKSCRIPT_PATH%"
	%powershell_exe% -Command "%DKSCRIPT_PATH%"

	echo(
	echo ###### DKPowershell Exit ######
	echo errorlevel:%errorlevel%
	echo(
	if %errorlevel% neq 0 (pause)
%endfunction%



















:DKINSTALL
	if "%~1" neq "" (goto:eof)

	echo Installing DKPowershell . . .
	
	@echo off&::###### DK.cmd #########################################################################################################################
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../DKBatch/functions/") 
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
	if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
	::#################################################################################################################################################

	::###### Install DKPowershell ######
	%dk_call% dk_validate DKIMPORTS_DIR 				"%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate powershell_exe 				"%dk_call% dk_depend powershell_exe"
	%dk_call% dk_validate DKPOWERSHELL_FUNCTIONS_DIR	"%dk_call% dk_DKBRANCH_DIR"

	::###### DKPowershell ######
	ftype DKPowershell="%ComSpec%" /V:ON /K call "%~f0" "%DKPOWERSHELL_FUNCTIONS_DIR%" "%powershell_exe%" "%%1" %*
	%dk_call% dk_registrySetKey "HKCR/DKPowershell/DefaultIcon" "" "REG_SZ" "%powershell_exe%"

	::###### .ps1 ######
	assoc .ps1=DKPowershell

	%dk_call% dk_success "DKPowershell install complete"
%endfunction%