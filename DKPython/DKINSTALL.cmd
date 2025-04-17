@echo off
if "%~1" equ "" (goto DKINSTALL)

:runDKPython
	set "DKPYTHON_FUNCTIONS_DIR=%~1"
	set "PYTHON3_EXE=%~2"
	set "DKSCRIPT_PATH=%~3"
	
	::echo DKPYTHON_FUNCTIONS_DIR = %DKPYTHON_FUNCTIONS_DIR%
	::echo PYTHON3_EXE = %PYTHON3_EXE%
	::echo DKSCRIPT_PATH = %DKSCRIPT_PATH%
	::echo:
	
	::###### run script ######
	::title %DKSCRIPT_PATH%
	::(set PATH=%DKPYTHON_FUNCTIONS_DIR%;%PATH% & 
	(set cmnd=%COMSPEC:/=\% /V:ON /k call "%PYTHON3_EXE:\=/%" "%DKSCRIPT_PATH:\=/%")
	::echo %cmnd%
	::echo:
	::echo:
	%cmnd%
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

	::###### DK.cmd ######
	if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../DKBatch/functions/")
	if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
	if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

	::###### Install DKPython ######
	%dk_call% dk_validate DKPYTHON_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate PYTHON3_EXE "%dk_call% %DKIMPORTS_DIR%/python3/DKINSTALL.cmd"

	ftype DKPython="%COMSPEC%" /V:ON /K call "%~f0" "%DKPYTHON_FUNCTIONS_DIR%" "%PYTHON3_EXE%" "%%1" %*
	%dk_call% dk_registrySetKey "HKCR/DKPython/DefaultIcon" "" "REG_SZ" "%PYTHON3_EXE%"	
	assoc .py=DKPython

	%dk_call% dk_success "DKPython install complete"
%endfunction%
