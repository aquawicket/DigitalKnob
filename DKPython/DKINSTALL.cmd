@echo off
if "%~1" equ "" (goto DKINSTALL)

:runDKPython
	set "DKPYTHON_FUNCTIONS_DIR=%~1"
	echo DKPYTHON_FUNCTIONS_DIR = %DKPYTHON_FUNCTIONS_DIR%
	set "PYTHON3_EXE=%~2"
	set "DKSCRIPT_PATH=%~3"
	
	::###### run script ######
	::title %DKSCRIPT_PATH%
	%ComSpec% /V:ON /K call "%PYTHON3_EXE:\=/%" "%DKSCRIPT_PATH:\=/%"

	::###### exit_code ######
	if %ERRORLEVEL% neq 0 (
		echo ERROR:%ERRORLEVEL%
		pause
	)
	pause
exit /b %ERRORLEVEL%





















:DKINSTALL
	if "%~1" neq "" (goto:eof)

	echo Installing DKPython . . .

	@echo off&::###### DK.cmd #########################################################################################################################
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../DKBatch/functions/") 
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
	if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
	::#################################################################################################################################################

	::###### Install DKPython ######
	%dk_call% dk_validate DKPYTHON_FUNCTIONS_DIR	"%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_validate DKIMPORTS_DIR				"%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate PYTHON3_EXE				"%dk_call% dk_depend python3"

	ftype DKPython="%ComSpec%" /V:ON /K call "%~f0" "%DKPYTHON_FUNCTIONS_DIR%" "%PYTHON3_EXE%" "%%1" %*
	%dk_call% dk_registrySetKey "HKCR/DKPython/DefaultIcon" "" "REG_SZ" "%PYTHON3_EXE%"	
	assoc .py=DKPython

	%dk_call% dk_success "DKPython install complete"
%endfunction%
